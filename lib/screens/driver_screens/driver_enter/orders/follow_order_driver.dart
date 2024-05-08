import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/screens/public_screens/chat.dart';
import 'package:producer_family_app/screens/public_screens/chat_damily_driver.dart';
import 'package:producer_family_app/screens/public_screens/splash.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../public_screens/reporting.dart';

class FollowOrderDriver extends StatefulWidget {
  final int index;

  const FollowOrderDriver({required this.index});
  @override
  _FollowOrderDriverState createState() => _FollowOrderDriverState();
}

class _FollowOrderDriverState extends State<FollowOrderDriver> {
  final _googleMapController = Completer();
  getProfileGetx controllerProfile = Get.put(getProfileGetx());
  Location locationTraker = Location(); //
  // StreamSubscription? _locationSubscriptionUser;
  // StreamSubscription? _locationSubscriptionFamily;
  StreamSubscription? _locationSubscription;
  BitmapDescriptor? iconUser;
  BitmapDescriptor? iconFamily;
  // Location _locationTracker = Location();
  // Marker? markerUser;
  // Marker? markerDriver;
  // Set<Marker> _markers = {};
  // Circle? circleDriver;
  int index = 0;
  getOrderDriverGetX controller = Get.put(getOrderDriverGetX());
  @override
  void initState() {
    setState(() {
      index = widget.index;
      // print(index);
    });

    _getMarker();
    super.initState();
    managenotificationAction(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _locationSubscription!.isPaused;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // LatLng currentLocation = LatLng(
    //     controller.orders[index].shippingLat.toDouble(),
    //     controller.orders[index].shippingLng.toDouble());
    final Set<Marker> markers = {
      if (iconUser != null)
        Marker(
          markerId: const MarkerId("user"),
          position: LatLng(
            controller.orders[index].clientlat.toDouble(),
            controller.orders[index].clientlng.toDouble(),
          ),
          draggable: false,
          onTap: () {
            // print(controller.orders[index].clientphone);
            customLaunch(controller.orders[index].clientphone);
          },
          anchor: const Offset(0.5, .2),
          flat: true,
          icon: iconUser!,
          infoWindow: InfoWindow(
            title: controller.orders[index].clientname,
          ),
        ),
      if (iconFamily != null)
        Marker(
          markerId: const MarkerId("family"),
          infoWindow: InfoWindow(
            title: controller.orders[index].familyname,
          ),
          position: LatLng(
            controller.orders[index].familylat.toDouble(),
            controller.orders[index].familylng.toDouble(),
          ),
          draggable: false,
          anchor: const Offset(0.4, .3),
          onTap: () {
            // print(controller.orders[index].familyphone);

            customLaunch(controller.orders[index].familyphone);
          },
          flat: true,
          icon: iconFamily!,
        ),
    };

    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.followorder,
        onPressed: () {},
      ),
      body: GetX<getOrderDriverGetX>(
        init: getOrderDriverGetX(),
        builder: (getOrderDriverGetX controller) {
          return controller.isLoading.value
              ? Center(child: indicatorNourahLoading())
              : Stack(
                  children: [
                    GoogleMap(
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      onMapCreated: (GoogleMapController controller) async {
                        _googleMapController.complete(controller);
                      },
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(
                          24.71768642425082,
                          46.666466158159736,
                        ),
                        zoom: 9.0,
                      ),
                      onCameraMove: (CameraPosition newPos) {
                        // currentLocation = newPos.target;
                      },
                      // markers: Set.of((markerUser != null &&markerDriver != null &&markerFamily != null) ? [markerUser!,markerDriver!,markerFamily!]:[] ),
                      //         circles: Set.of((circleUser != null &&circleDriver != null &&circleFamily != null) ?  [circleUser!,circleFamily!,circleDriver!,]:[] ),
                      markers: markers.toSet(),
                      // markers: Set.of((markerDriver != null ) ? [markerDriver!,_markers.last,_markers.first]:[] ),
                      // circles: Set.of((circleDriver != null ) ?  [circleDriver!]:[] ),
                      // markers: _markers.toSet(),
                    ),
                    Dot(
                      radius: SizeConfig.scaleTextFont(12),
                      color: kSpecialColor,
                    ),
                    Positioned(
                      bottom: SizeConfig.scaleHeight(30),
                      right: SizeConfig.scaleWidth(10),
                      left: SizeConfig.scaleWidth(10),
                      child: ContainerApp(
                        child: Column(
                          children: [
                            SizedBox(
                              height: hSpace,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Expanded(child: SizedBox()),
                                Expanded(
                                  child: StyleText(
                                    AppLocalizations.of(context)!.deliveryTi,
                                  ),
                                ),
                                Expanded(
                                  child: StyleText(
                                    "${controller.orders[index].deliveryDuration}  ${controller.orders[index].deliveryDurationUnit == "h" ? AppLocalizations.of(context)!.hour : controller.orders[index].deliveryDurationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                    textColor: kSpecialColor,
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                            SizedBox(
                              height: hSpace,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: wSpaceSmall,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: StyleButton(
                                    AppLocalizations.of(context)!
                                        .chatWithCustomer,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Chat(
                                            orderNo: controller
                                                .orders[index].orderNo,
                                            driverId: controller
                                                .orders[index].deliveryId,
                                            userId:
                                                controller.orders[index].userId,
                                            phone: controller
                                                .orders[index].clientphone,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: wSpaceSmall,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: StyleButton(
                                    AppLocalizations.of(context)!
                                        .chatWithFamily,
                                    sideColor: kSpecialColor,
                                    backgroundColor: kSpecialColor,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatFamily(
                                            orderNo: controller
                                                .orders[index].orderNo,
                                            driverId: controller
                                                .orders[index].deliveryId,
                                            familyId: controller
                                                .orders[index].familyId,
                                            phone: controller
                                                .orders[index].familyphone,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: wSpaceSmall,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: StyleButton(
                                    AppLocalizations.of(context)!.reporting,
                                    sideColor: kRefuse,
                                    backgroundColor: kRefuse,
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Reporting(
                                              family: true,
                                              user: true,
                                              id: controller.orders[index].id,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: wSpaceSmall,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: hSpace,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
      floatingActionButton: SizedBox(
        height: SizeConfig.scaleHeight(800),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              child: const Icon(
                Icons.gps_fixed,
                color: Colors.white,
              ),
              backgroundColor: kSpecialColor,
              onPressed: () async {
                // var location = await locationTraker.getLocation();
                // LocationData currentLocation = await LocationService().getLocation();

                if (_locationSubscription != null) {
                  _locationSubscription!.cancel();
                }
                _locationSubscription = locationTraker.onLocationChanged
                    .listen((newLocalDataDriver) async {
                  _animateCamera(
                    LatLng(
                      newLocalDataDriver.latitude!.toDouble(),
                      newLocalDataDriver.longitude!.toDouble(),
                    ),
                  );
                });

                // _animateCamera(
                //   LatLng(currentLocation.latitude!, currentLocation.longitude!),
                // );
                // List<Placemark> placemarks = await placemarkFromCoordinates(
                //     currentLocation.latitude!.toDouble(), currentLocation.longitude!.toDouble());
                // print("longitude  ${currentLocation.longitude}");
                // print("latitude  ${currentLocation.latitude}");
                // print("${placemarks[0].street!} ${placemarks[0].subLocality!}");
              },
            ),
            SizedBox(
              height: hSpaceLarge,
            ),
            FloatingActionButton(
              heroTag: "btn2",
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              backgroundColor: kSpecialColor,
              onPressed: () async {
                _animateCamera(
                  LatLng(
                    controller.orders[index].clientlat.toDouble(),
                    controller.orders[index].clientlng.toDouble(),
                  ),
                );
                // print("clientlat ${controller.orders[index].clientlat}");
                // print("clientlng ${controller.orders[index].clientlng}");
              },
            ),
            SizedBox(
              height: hSpaceLarge,
            ),
            FloatingActionButton(
              heroTag: "btn3",
              child: const Icon(
                Icons.family_restroom,
                color: Colors.white,
              ),
              backgroundColor: kSpecialColor,
              onPressed: () async {
                _animateCamera(
                  LatLng(
                    controller.orders[index].familylat.toDouble(),
                    controller.orders[index].familylng.toDouble(),
                  ),
                );
                // print("familylat ${controller.orders[index].familylat}");
                // print("familylng ${controller.orders[index].familylng}");
              },
            ),
          ],
        ),
      ),
    );
  }

  // void getCurrentLocationDriver() async {
  //   try {
  //
  //     Uint8List imageData = await getMarkerDriver();
  //     var locationDriver = await _locationTracker.getLocation();
  //
  //     // updateMarkerDriver(locationDriver, imageData);
  //
  //     if (_locationSubscriptionDriver != null) {
  //       _locationSubscriptionDriver!.cancel();
  //     }
  //
  //
  //     _locationSubscriptionDriver = _locationTracker.onLocationChanged.listen((newLocalDataDriver) {
  //       if (_googleMapControllerDriver != null&&Driver==true) {
  //         _googleMapControllerDriver.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
  //             bearing: 190,
  //             target: LatLng(newLocalDataDriver.latitude!, newLocalDataDriver.longitude!),
  //             tilt: 0,
  //             zoom: 18.00)));
  //         // updateMarkerDriver(newLocalDataDriver, imageData);
  //       }
  //     });
  //
  //   } on PlatformException catch (e) {
  //     if (e.code == 'PERMISSION_DENIED') {
  //       debugPrint("Permission Denied");
  //     }
  //   }
  //
  //
  // }

  // Future<Uint8List> getMarkerDriver() async {
  //   ByteData byteData = await DefaultAssetBundle.of(context).load('assets/images/driverIcon.png');
  //   return byteData.buffer.asUint8List();
  // }

  // void updateMarkerDriver(LocationData newLocalData, Uint8List imageData) {
  //   LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
  //   this.setState(() {
  //     markerDriver = Marker(
  //         markerId: MarkerId("${controller.orders[index].deliveryId}"),
  //         position: latlng,
  //         rotation: newLocalData.heading!,
  //         draggable: true,
  //         zIndex: 2,
  //         flat: true,
  //         infoWindow: InfoWindow(
  //           title: AppLocalizations.of(context)!.driver,
  //         ),
  //         anchor: Offset(0.5, 0.5),
  //         icon: BitmapDescriptor.fromBytes(imageData));
  //     circleDriver = Circle(
  //         circleId: CircleId("driverCircle"),
  //         radius: newLocalData.accuracy!,
  //         zIndex: 1,
  //         strokeColor: kSpecialColor,
  //         center: latlng,
  //         strokeWidth: 3,
  //         fillColor: Colors.transparent.withOpacity(.5));
  //
  //   });
  // }

  //••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
//   void getCurrentLocationFamily() async {
//     try {
//
//       Uint8List imageData = await getMarkerFamily();
//       var locationFamily = await _locationTracker.getLocation();
//
//       updateMarkerFamily(locationFamily, imageData);
//
//       if (_locationSubscriptionFamily != null) {
//         _locationSubscriptionFamily!.cancel();
//       }
//
//
//       _locationSubscriptionFamily = _locationTracker.onLocationChanged.listen((newLocalData) {
//         if (_googleMapControllerFamily != null) {
//           _googleMapControllerFamily.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
//               bearing: 190,
//               target: LatLng(newLocalData.latitude!, newLocalData.longitude!),
//               tilt: 0,
//               zoom: 18.00)));
//           updateMarkerFamily(newLocalData, imageData);
//         }
//       });
//
//     } on PlatformException catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
//         debugPrint("Permission Denied");
//       }
//     }
//
//
//   }
//
//   Future<Uint8List> getMarkerFamily() async {
//     ByteData byteData = await DefaultAssetBundle.of(context).load('assets/images/familyIcon.png');
//     return byteData.buffer.asUint8List();
//   }
//
//   void updateMarkerFamily(LocationData newLocalData, Uint8List imageData) {
//     LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
//     this.setState(() {
//       markerFamily = Marker(
//           markerId: MarkerId("${controller.orders[index].familyId}"),
//           position: latlng,
//           rotation: newLocalData.heading!,
//           draggable: false,
//           zIndex: 2,
//           flat: true,
//           infoWindow: InfoWindow(
//             title: AppLocalizations.of(context)!.driver,
//           ),
//           anchor: Offset(0.5, 0.5),
//           icon: BitmapDescriptor.fromBytes(imageData));
//       circleFamily = Circle(
//           circleId: CircleId("familyCircle"),
//           radius: newLocalData.accuracy!,
//           zIndex: 1,
//           strokeColor: kSpecialColor,
//           center: latlng,
//           strokeWidth: 3,
//           fillColor: Colors.transparent.withOpacity(.5));
//
//     });
//   }
// //••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••
//   void getCurrentLocationUser() async {
//     try {
//
//       Uint8List imageData = await getMarkerUser();
//       var locationUser = await _locationTracker.getLocation();
//
//       updateMarkerUser(locationUser, imageData);
//
//       if (_locationSubscriptionUser != null) {
//         _locationSubscriptionUser!.cancel();
//       }
//
//
//       _locationSubscriptionUser = _locationTracker.onLocationChanged.listen((newLocalData) {
//         if (_googleMapControllerUser != null) {
//           _googleMapControllerUser.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
//               bearing: 190,
//               target: LatLng(newLocalData.latitude!, newLocalData.longitude!),
//               tilt: 0,
//               zoom: 18.00)));
//           updateMarkerUser(newLocalData, imageData);
//         }
//       });
//
//     } on PlatformException catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
//         debugPrint("Permission Denied");
//       }
//     }
//
//
//   }
//
//   Future<Uint8List> getMarkerUser() async {
//     ByteData byteData = await DefaultAssetBundle.of(context).load('assets/images/userIcon.png');
//     return byteData.buffer.asUint8List();
//   }
//
//   void updateMarkerUser(LocationData newLocalData, Uint8List imageData) {
//     LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
//     this.setState(() {
//       markerUser = Marker(
//           markerId: MarkerId("${controller.orders[index].userId}"),
//           position: latlng,
//           rotation: newLocalData.heading!,
//           draggable: false,
//           zIndex: 2,
//           flat: true,
//           infoWindow: InfoWindow(
//             title: AppLocalizations.of(context)!.driver,
//           ),
//           anchor: Offset(0.5, 0.5),
//           icon: BitmapDescriptor.fromBytes(imageData));
//       circleUser = Circle(
//           circleId: CircleId("userCircle"),
//           radius: newLocalData.accuracy!,
//           zIndex: 1,
//           strokeColor: kSpecialColor,
//           center: latlng,
//           strokeWidth: 3,
//           fillColor: Colors.transparent.withOpacity(.5));
//
//     });
//   }

  Future<void> _getMarker() async {
    iconUser = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/userIcon.png',
    );

    iconFamily = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/familyIcon.png',
    );
  }

  // Future updateProfile({
  //   required String address,
  //   required dynamic latitude,
  //   required dynamic longitude,
  //   required String name,
  //   required String email,
  //   required String phone,
  // }) async {
  //   await controller.updateProfile(
  //     name: name,
  //     email: email,
  //     address: address,
  //     lat: latitude,
  //     lng: longitude,
  //     phone: phone,
  //     uploadEvent: (bool status) {
  //       if (status) {}
  //     },
  //   );
  //
  // }

  Future<void> _animateCamera(LatLng currentLocation) async {
    final GoogleMapController controller = await _googleMapController.future;
    final CameraPosition cameraPosition = CameraPosition(
      target: currentLocation,
      zoom: 18.00,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<void> customLaunch(command) async {
    if (await canLaunchUrl(Uri.parse(command))) {
      await launchUrl(Uri.parse(command));
    } else {
      // print(' could not launch $command');
    }
  }
}
