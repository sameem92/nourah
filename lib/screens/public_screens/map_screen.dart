import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:producer_family_app/screens/public_screens/splash.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';
import '../../components/location_services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapScreen extends StatefulWidget {
  bool user;
  bool driver;
  bool family;
  double lat;
  double long;

  MapScreen({this.lat = 24.71768642425082, this.long = 46.666466158159736,
  this.user=false,this.driver=false,this.family=false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with FbNotifications{
  String latitude = "";
  String longitude = "";
  late GoogleMapController _googleMapController;
  LatLng currentLocation = _initialCameraPosition.target;
  @override
  void initState() {
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    // managenotificationAction(context);
    FirebaseMessaging.instance.getToken();
    super.initState();
    _getMyLocation();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: StyleText(

          "$latitude $longitude",
          maxLines: 3,
          height: 1.7,
          textAlign: TextAlign.center,
          textColor: kSecondaryColor,
        ),
        toolbarHeight: SizeConfig.scaleHeight(100),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(MapScreen().lat, MapScreen().long), zoom: 13
                ),
            onMapCreated: (controller) async {
                String style = await DefaultAssetBundle.of(context)
                    .loadString('assets/map_style.json');
                controller.setMapStyle(style);
                _googleMapController = controller;
            },
            onCameraMove: (CameraPosition newPos) {
                currentLocation = newPos.target;
                getAddressLocation(
                    lat: currentLocation.latitude,
                    long: currentLocation.longitude);
            },
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,

          ),
          Dot(
            radius: SizeConfig.scaleTextFont(10),
            color: kSpecialColor,
          ),
          Positioned(
            bottom: SizeConfig.scaleWidth(70),
            right: SizeConfig.scaleWidth(10),
            left: SizeConfig.scaleWidth(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Image.asset(
                'assets/images/header.webp',
                fit: BoxFit.fill,
                width: double.infinity,
                height: SizeConfig.scaleHeight(100),
              ),
            ),
          ),
          Positioned(
            bottom: SizeConfig.scaleWidth(20),
            right: SizeConfig.scaleWidth(10),
            left: SizeConfig.scaleWidth(10),
            child: StyleButton(
              AppLocalizations.of(context)!.addYourLocation,
              sideColor: kSpecialColor,
              backgroundColor: kSpecialColor,
              onPressed: () async{

    if(widget.driver==true) {
      Navigator.pushReplacementNamed(context, "/mainDriver");

      Provider.of<LatNotiferDriver>(context, listen: false)
          .changeLatDriver(currentLocation.latitude);

      Provider.of<LongNotiferDriver>(context, listen: false)
          .changeLongDriver(currentLocation.longitude);
    }else if(widget.family==true){
                  Navigator.pushReplacementNamed(context, "/mainFamily");
                  Provider.of<LatNotiferFamily>(context, listen: false)
                      .changeLatFamily(currentLocation.latitude);

                  Provider.of<LongNotiferFamily>(context, listen: false)
                      .changeLongFamily(currentLocation.longitude);

                  Provider.of<stringNotiferFamily>(context, listen: false)
                      .changeStringFamily(latitude);
    }else{
      Navigator.pushReplacementNamed(context, "/mainScreen");
      Provider.of<LatNotiferUser>(context, listen: false)
          .changeLatUser(currentLocation.latitude);

      Provider.of<LongNotiferUser>(context, listen: false)
          .changeLongUser(currentLocation.longitude);

      Provider.of<stringNotiferUser>(context, listen: false)
          .changeStringUser(
          latitude
      );

    }
                print("latitude${currentLocation.latitude}longitude${currentLocation.longitude}");

              },
            ),
          ),
        ],
      ),

      floatingActionButton: Container(

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
                backgroundColor: kSpecialColor.withOpacity(.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //احداثيات الرياض
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(24.71768642425082, 46.666466158159736),
    zoom: 11.5,
  );

  Future<void> _getMyLocation() async {
    LocationData currentLocation = await LocationService().getLocation();
    _animateCamera(
        LatLng(currentLocation.latitude!, currentLocation.longitude!));
  }

  Future<void> _animateCamera(LatLng currentLocation) async {
      final GoogleMapController controller = await _googleMapController;
      CameraPosition _cameraPosition = CameraPosition(
        target: currentLocation,
        zoom: 13.00,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  getAddressLocation({lat, long}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    if(mounted) {
      setState(() {
        latitude = "${placemarks[0].street!} ";
        longitude = "${placemarks[0].street!} ${placemarks[0].subLocality!}";
      });
    }
  }
}
