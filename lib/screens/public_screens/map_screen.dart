import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/screens/public_screens/splash.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:provider/provider.dart';

import '../../components/location_services.dart';
import '../../storage/providersAndGetx/home_getx.dart';
import '../../storage/providersAndGetx/language_change.dart';

class MapScreen extends StatefulWidget {
  final bool user;
  final bool driver;
  final bool family;
  final double lat;
  final double long;

  const MapScreen(
      {this.lat = 24.71768642425082,
      this.long = 46.666466158159736,
      this.user = false,
      this.driver = false,
      this.family = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with FbNotifications {
  // bool _mapLoading = true;
  String latitude = "";
  String longitude = "";
  final Completer<GoogleMapController> _googleMapController = Completer();
  GetBannersGetx controllerBanners = Get.find();

  LatLng currentLocation = _initialCameraPosition.target;
  @override
  void initState() {
    deleteCache();
    widget.driver == true || widget.user == true || widget.family == true
        ? Get.put(getProfileGetx())
        : print('no user');
    super.initState();
    _getMyLocation();
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    managenotificationAction(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<GetNetworkGetx>(
          init: GetNetworkGetx(),
          builder: (GetNetworkGetx network) {
            return network.connectionType.value == 0
                ? Column(
                    children: [
                      noContent(
                          context, AppLocalizations.of(context)!.noInternet),
                      SizedBox(
                        height: SizeConfig.scaleHeight(30),
                      ),
                      StyleButton(AppLocalizations.of(context)!.refresh,
                          sideColor: kSpecialColor,
                          backgroundColor: kSpecialColor, onPressed: () async {
                        await network.refreshData();
                      })
                    ],
                  )
                : Stack(
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                const MapScreen().lat, const MapScreen().long),
                            zoom: 13),
                        onMapCreated: (GoogleMapController controller) async {
                          _googleMapController.complete(controller);
                        },
                        onCameraMove: (CameraPosition newPos) {
                          currentLocation = newPos.target;
                        },
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                      ),
                      Dot(
                        radius: SizeConfig.scaleTextFont(10),
                        color: kSpecialColor,
                      ),
                      controllerBanners.isLoading.value
                          ? Column(
                              children: [
                                SizedBox(
                                  height: SizeConfig.scaleHeight(350),
                                ),
                                Center(child: indicatorNourahLoading()),
                              ],
                            )
                          : controllerBanners.banners.isNotEmpty
                              ? Positioned(
                                  bottom: SizeConfig.scaleWidth(70),
                                  right: SizeConfig.scaleWidth(10),
                                  left: SizeConfig.scaleWidth(10),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(borderRadius),
                                    child: ImageContainer(
                                      controllerBanners.banners[0].image,
                                    ),
                                  ))
                              : Column(),
                      Positioned(
                        bottom: SizeConfig.scaleWidth(20),
                        right: SizeConfig.scaleWidth(10),
                        left: SizeConfig.scaleWidth(10),
                        child: StyleButton(
                            AppLocalizations.of(context)!.addYourLocation,
                            sideColor: kSpecialColor,
                            backgroundColor: kSpecialColor,
                            onPressed: () async {
                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                                  currentLocation.latitude,
                                  currentLocation.longitude);
                          if (mounted) {
                            setState(() {
                              latitude =
                                  "${placemarks[0].administrativeArea!} ${placemarks[0].locality!} ${placemarks[0].subLocality!} ${placemarks[0].street!}  ${placemarks[0].subThoroughfare!}  ${placemarks[0].postalCode!}";
                            });
                          }

                          if (widget.driver == true) {
                            Provider.of<LatNotiferDriver>(context,
                                    listen: false)
                                .changeLatDriver(currentLocation.latitude);

                            Provider.of<LongNotiferDriver>(context,
                                    listen: false)
                                .changeLongDriver(currentLocation.longitude);

                            Provider.of<stringNotiferDriver>(context,
                                    listen: false)
                                .changeStringDriver(latitude);

                            await updateProfile();
                            // print('driver');
                            Navigator.pushReplacementNamed(
                                context, "/mainDriver");
                          } else if (widget.family == true) {
                            Provider.of<LatNotiferFamily>(context,
                                    listen: false)
                                .changeLatFamily(currentLocation.latitude);

                            Provider.of<LongNotiferFamily>(context,
                                    listen: false)
                                .changeLongFamily(currentLocation.longitude);

                            Provider.of<stringNotiferFamily>(context,
                                    listen: false)
                                .changeStringFamily(latitude);
                            await updateProfile();
                            // print('family');
                            Navigator.pushReplacementNamed(
                                context, "/mainFamily");
                          } else if (widget.user) {
                            Provider.of<LatNotiferUser>(context, listen: false)
                                .changeLatUser(currentLocation.latitude);

                            Provider.of<LongNotiferUser>(context, listen: false)
                                .changeLongUser(currentLocation.longitude);

                            Provider.of<stringNotiferUser>(context,
                                    listen: false)
                                .changeStringUser(latitude);
                            await updateProfile();
                            // print('user');

                            Get.put(HomeGetx(
                              context: context,
                              lat:
                                  "${Provider.of<LatNotiferUser>(context, listen: false).latUser}",
                              page: 1,
                              lng:
                                  "${Provider.of<LongNotiferUser>(context, listen: false).longUser}",
                            ));
                            Navigator.pushReplacementNamed(
                                context, "/mainScreen");
                          } else {
                            Provider.of<LatNotiferUser>(context, listen: false)
                                .changeLatUser(currentLocation.latitude);

                            Provider.of<LongNotiferUser>(context, listen: false)
                                .changeLongUser(currentLocation.longitude);

                            Provider.of<stringNotiferUser>(context,
                                    listen: false)
                                .changeStringUser(latitude);
                            // print('no user');

                            Get.put(HomeGetx(
                                context: context,
                                lat:
                                    "${Provider.of<LatNotiferUser>(context, listen: false).latUser}",
                                lng:
                                    "${Provider.of<LongNotiferUser>(context, listen: false).longUser}",
                                page: 1));
                            Navigator.pushReplacementNamed(
                                context, "/mainScreen");
                          }
                          // print(
                          //     "latitude${currentLocation.latitude}longitude${currentLocation.longitude}");
                          // print("address  $latitude ");
                        }),
                      ),
                    ],
                  );
          }),
      floatingActionButton: GetX<GetNetworkGetx>(
          init: GetNetworkGetx(),
          builder: (GetNetworkGetx network) {
            return network.connectionType.value == 0
                ? Column()
                : Container(
                    height: SizeConfig.scaleHeight(500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: SizeConfig.scaleWidth(50),
                          height: SizeConfig.scaleWidth(50),
                          child: FloatingActionButton(
                            onPressed: () async {
                              _getMyLocation();
                            },
                            child: Icon(
                              Icons.gps_fixed,
                              color: Colors.white,
                              size: fIcon,
                            ),
                            backgroundColor: kSpecialColor,
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }

  //احداثيات الرياض
  static final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(24.71768642425082, 46.666466158159736),
    zoom: 11.5,
  );

  Future<void> _getMyLocation() async {
    LocationData currentLocation = await LocationService().getLocation(context);
    _animateCamera(
      LatLng(currentLocation.latitude!, currentLocation.longitude!),
    );
  }

  Future<void> _animateCamera(LatLng currentLocation) async {
    final GoogleMapController controller = await _googleMapController.future;
    CameraPosition cameraPosition = CameraPosition(
      target: currentLocation,
      zoom: 18.00,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future updateProfile() async {
    // Get.put(getProfileGetx());
    // List<Placemark> placemarks = await placemarkFromCoordinates(
    //     currentLocation.latitude, currentLocation.longitude);
    // if (mounted) {
    //   setState(() {
    //     latitude =
    //         "${placemarks[0].administrativeArea!} ${placemarks[0].locality!} ${placemarks[0].subLocality!} ${placemarks[0].street!}  ${placemarks[0].subThoroughfare!}  ${placemarks[0].postalCode!}";
    //   });
    // }

    await getProfileGetx().updateLatLan(
      helpBool: false,
      address: latitude,
      lat: currentLocation.latitude,
      lng: currentLocation.longitude,
      context: context,
      uploadEvent: (bool status) {
        if (status) {}
      },
    );
    // print("address  :  $latitude");
    // print("lat  :  ${currentLocation.latitude}");
    // print("lng  :  ${currentLocation.longitude}");
    // print('update profile');
    // print("phone :${controller.profile['phone']}");
    // print("lat :${controller.profile['lat']}");
    // print("lng :${controller.profile['lng']}");
    // print("name  ${controller.profile['name']}");
    // print("email  ${controller.profile['email']}");
    // print("minimum_order ${controller.profile['minimum_order']}");
    // print("notes ${controller.profile['notes']}");
    // print("ennotes ${controller.profile['ennotes']}");
  }

  Future deleteCache() async {
    Get.delete<HomeGetx>();
    String fileName2 = "getHome.json";
    var dir2 = await getTemporaryDirectory();
    File file2 = File("${dir2.path}/$fileName2");
    if (file2.existsSync()) {
      file2.deleteSync(recursive: true);
      // print('delete getHome');
    }

    String fileName1 = "getMessageController.json";
    var dir1 = await getTemporaryDirectory();
    File file1 = File("${dir1.path}/$fileName1");
    if (file1.existsSync()) {
      file1.deleteSync(recursive: true);
      // print('delete getMessageController');
    }

    String fileName3 = "getColumnStatistics.json";
    var dir3 = await getTemporaryDirectory();
    File file3 = File("${dir3.path}/$fileName3");
    if (file3.existsSync()) {
      file3.deleteSync(recursive: true);
      // print('delete getColumnStatistics');
    }

    String fileName6 = "getStatistics.json";
    var dir6 = await getTemporaryDirectory();
    File file6 = File("${dir6.path}/$fileName6");
    if (file6.existsSync()) {
      file6.deleteSync(recursive: true);
      // print('delete getStatistics');
    }

    String fileName4 = "getSocialMediaController.json";
    var dir4 = await getTemporaryDirectory();
    File file4 = File("${dir4.path}/$fileName4");
    if (file4.existsSync()) {
      file4.deleteSync(recursive: true);
      // print('delete getSocialMediaController');
    }
  }
}
