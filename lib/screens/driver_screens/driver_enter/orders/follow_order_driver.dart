import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/screens/public_screens/reporting.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FollowOrderDriver extends StatefulWidget {
  int index;

  FollowOrderDriver({this.index = 0});
  @override
  _FollowOrderDriverState createState() => _FollowOrderDriverState();
}

class _FollowOrderDriverState extends State<FollowOrderDriver> {
  late GoogleMapController _googleMapControllerDriver;
  late GoogleMapController _googleMapControllerFamily;
  late GoogleMapController _googleMapControllerUser;
  StreamSubscription? _locationSubscriptionUser;
  StreamSubscription? _locationSubscriptionFamily;
  StreamSubscription? _locationSubscriptionDriver;
  BitmapDescriptor ? iconUser;
   // BitmapDescriptor?  iconDriver;
   BitmapDescriptor?  iconFamily;
  Location _locationTracker = Location();
  // Marker? markerUser;
  Marker? markerDriver;
    Set<Marker> _markers = {};

  // Marker? markerFamily;
bool Driver=true;
//     Circle? circleUser;
//     Circle? circleFamily;
    Circle? circleDriver;
  @override
void initState() {
    // TODO: implement initState
    super.initState();
    _getMarker();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_locationSubscriptionUser != null) {
      _locationSubscriptionUser!.cancel();
    }
    if (_locationSubscriptionFamily != null) {
      _locationSubscriptionFamily!.cancel();
    }
    if (_locationSubscriptionDriver != null) {
      _locationSubscriptionDriver!.cancel();
    }
    super.dispose();
  }
  getOrderDriverGetX controller = Get.put(getOrderDriverGetX());

  @override
  Widget build(BuildContext context) {
    return GetX<getOrderDriverGetX>(
        init: getOrderDriverGetX(),
        builder: (getOrderDriverGetX controller) {

          Set<Marker> _markers = {
            if(iconUser !=null)

              Marker(
                  markerId: MarkerId("user"),
                  position: LatLng(controller.orders[widget.index].clientlat.toDouble(),
                      controller.orders[widget.index].clientlng.toDouble()),
                  draggable: true,

                  icon: iconUser!,
                  infoWindow: InfoWindow(
                    title: controller.orders[widget.index].clientname,
                  )),

            if(iconFamily !=null)
              Marker(
                markerId: MarkerId("family"),
                infoWindow: InfoWindow(
                  title: controller.orders[widget.index].familyname,
                ),
                position: LatLng(controller.orders[widget.index].familylat.toDouble(),
                    controller.orders[widget.index].familylng.toDouble()),
                draggable: true,
                icon: iconFamily!,
              ),
          };


          return Scaffold(
            appBar: AppBarWhite(context,
                title: AppLocalizations.of(context)!.followorder,
                icon: Icons.call,
                onPressed: () {}),
            body:controller.isLoading.value
                ? Center(
              child: indicator_nourah_loading()
            )
                :  Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapType: MapType.hybrid,
                  onMapCreated: (controller) async {
                      _googleMapControllerUser = controller;
                      _googleMapControllerDriver = controller;
                      _googleMapControllerFamily = controller;
                      },

                  initialCameraPosition: CameraPosition(
                    target: LatLng(controller.orders[widget.index].shippingLng.toDouble()??0,
                        controller.orders[widget.index].shippingLng.toDouble()??0),
                    zoom: 14.0,
                  ),
                  // markers: Set.of((markerUser != null &&markerDriver != null &&markerFamily != null) ? [markerUser!,markerDriver!,markerFamily!]:[] ),
                  //         circles: Set.of((circleUser != null &&circleDriver != null &&circleFamily != null) ?  [circleUser!,circleFamily!,circleDriver!,]:[] ),
                  markers: Set.of((markerDriver != null ) ? [markerDriver!,_markers.last,_markers.first]:[] ),
                  circles: Set.of((circleDriver != null ) ?  [circleDriver!]:[] ),
                  // markers: _markers.toSet(),

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: StyleText(
                                  AppLocalizations.of(context)!.deliveryTi),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: hSpace,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: StyleText(
                                "${controller.orders[widget.index].deliveryDuration}  ${controller.orders[widget.index].deliveryDurationUnit == "h" ? AppLocalizations.of(context)!.hour : "${controller.orders[widget.index].deliveryDurationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                textColor: kSpecialColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: hSpace,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: wSpace,),

                            Expanded(
                              flex: 4,
                              child: StyleButton(
                                AppLocalizations.of(context)!.chatWithCustomer,
                                onPressed: () {
                                  Navigator.pushNamed(context, "/chat");
                                },
                              ),
                            ),
                            SizedBox(
                              width: wSpace,
                            ),
                            SizedBox(
                              width: wSpace,
                            ),
                            Expanded(
                              flex: 3,
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
                                      );
                                    },
                                  ),
                                );
                              }),
                            ),
                            SizedBox(width: wSpace,)
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
            ),
            floatingActionButton: Container(
              height: SizeConfig.scaleHeight(800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    FloatingActionButton(
                      onPressed: () async {
                        setState(() {
                          Driver=false;
                        });
                        // getCurrentLocationUser();
                        await _googleMapControllerUser.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target: LatLng(
                                  controller.orders[widget.index].clientlat.toDouble(),
                                  controller.orders[widget.index].clientlng.toDouble()),
                              zoom: 13)));
//
                      },
                      child: Icon(
                        Icons.gps_fixed,
                        color: Colors.white,
                      ),
                      backgroundColor: kSpecialColor,
                    ),
                  SizedBox(
                    height: hSpaceLarge,
                  ),

                    FloatingActionButton(
                      onPressed: () async {
                        setState(() {
                          Driver=true;
                        });
                        getCurrentLocationDriver();

                      },
                      child: Icon(
                        Icons.delivery_dining,
                        color: Colors.white,
                      ),
                      backgroundColor: kSpecialColor,
                    ),
                  SizedBox(
                    height: hSpaceLarge,
                  ),

                    FloatingActionButton(
                      onPressed: () async {
                       setState(() {
                         Driver=false;
                       });
                        // getCurrentLocationFamily();
                        await _googleMapControllerFamily.animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                              target: LatLng(
                                  controller.orders[widget.index].familylat.toDouble(),
                                  controller.orders[widget.index].familylng.toDouble()),
                              zoom: 13)));
//                     },
                      },
                      child: Icon(
                        Icons.family_restroom,
                        color: Colors.white,
                      ),
                      backgroundColor: kSpecialColor,
                    ),
                ],
              ),
            ),
          );
        });
  }

  void getCurrentLocationDriver() async {
    try {

      Uint8List imageData = await getMarkerDriver();
      var locationDriver = await _locationTracker.getLocation();

      updateMarkerDriver(locationDriver, imageData);

      if (_locationSubscriptionDriver != null) {
        _locationSubscriptionDriver!.cancel();
      }


      _locationSubscriptionDriver = _locationTracker.onLocationChanged.listen((newLocalDataDriver) {
        if (_googleMapControllerDriver != null&&Driver==true) {
          _googleMapControllerDriver.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 190,
              target: LatLng(newLocalDataDriver.latitude!, newLocalDataDriver.longitude!),
              tilt: 0,
              zoom: 18.00)));
          updateMarkerDriver(newLocalDataDriver, imageData);
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }


  }

  Future<Uint8List> getMarkerDriver() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load('assets/images/driverIcon.png');
    return byteData.buffer.asUint8List();
  }

  void updateMarkerDriver(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
    this.setState(() {
      markerDriver = Marker(
          markerId: MarkerId("${controller.orders[widget.index].deliveryId}"),
          position: latlng,
          rotation: newLocalData.heading!,
          draggable: true,
          zIndex: 2,
          flat: true,
          infoWindow: InfoWindow(
            title: AppLocalizations.of(context)!.driver,
          ),
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circleDriver = Circle(
          circleId: CircleId("driverCircle"),
          radius: newLocalData.accuracy!,
          zIndex: 1,
          strokeColor: kSpecialColor,
          center: latlng,
          strokeWidth: 3,
          fillColor: Colors.transparent.withOpacity(.5));

    });
  }

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
//           markerId: MarkerId("${controller.orders[widget.index].familyId}"),
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
//           markerId: MarkerId("${controller.orders[widget.index].userId}"),
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



  void _getMarker() async {
    // if(iconUser!=null)
    iconUser = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/userIcon.png');

    // if(iconFamily!=null)

    iconFamily = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/familyIcon.png');

  }



}
