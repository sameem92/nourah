// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:producer_family_app/components/location_services.dart';
// import 'package:producer_family_app/screens/public_screens/chat.dart';
// import 'package:producer_family_app/components/headers/app_bar_family.dart';
// import 'package:producer_family_app/components/containers/container_app.dart';
// import 'package:producer_family_app/storage/api/order_controller.dart';
// import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
// import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
// import 'package:producer_family_app/style/size_config.dart';
// import 'package:producer_family_app/style/style_button.dart';
// import 'package:producer_family_app/style/style_colors.dart';
// import 'package:producer_family_app/style/style_text.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../../../public_screens/reporting.dart';
//
// class FollowOrderUser extends StatefulWidget {
//   int index;
//
//   FollowOrderUser({this.index = 0});
//
//   @override
//   _FollowOrderUserState createState() => _FollowOrderUserState();
// }
//
// class _FollowOrderUserState extends State<FollowOrderUser> {
//   Completer<GoogleMapController> _googleMapController = Completer();
//   getProfileGetx controllerProfile = Get.put(getProfileGetx());
//
//   BitmapDescriptor? iconUser;
//   BitmapDescriptor? iconDriver;
//   Set<Marker> _markers = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _getMarker();
//   }
//
//   getOrderGetX controller=Get.put(getOrderGetX());
//   @override
//   Widget build(BuildContext context) {
//
//     LatLng currentLocation = LatLng(
//         controller.orders[widget.index].shippingLat.toDouble(),
//         controller.orders[widget.index].shippingLng.toDouble());
//
//     Set<Marker> _markers = {
//
//       if (iconUser != null)
//         Marker(
//           markerId: MarkerId("user"),
//           position: LatLng(
//               controller.orders[widget.index].shippingLat.toDouble(),
//               controller.orders[widget.index].shippingLng.toDouble()),
//           draggable: true,
//           icon: iconUser!,
//         ),
//       if (iconDriver != null)
//         Marker(
//           markerId: MarkerId("driver"),
//           infoWindow: InfoWindow(
//             title: controller.orders[widget.index].deliveryname,
//           ),
//           position: LatLng(
//               controller.orders[widget.index].deliverylat.toDouble(),
//               controller.orders[widget.index].deliverylng.toDouble()),
//           draggable: true,
//           icon: iconDriver!,
//         ),
//     };
//     return
//
//       Scaffold(
//               appBar: AppBarWhite(context,
//                   title: AppLocalizations.of(context)!.followorder,
//                   icon: Icons.call,
//                   onPressed: () {
//
//                     launchURL(controller.orders[widget.index].deliveryphone);
//                 print(controller.orders[widget.index].deliveryphone);
//                   }),
//               body: controller.isLoading.value
//                   ? Center(child: indicator_nourah_loading())
//                   : Stack(
//                       children: [
//                         GoogleMap(
//                           mapType: MapType.normal,
//                           myLocationButtonEnabled: false,
//                           zoomControlsEnabled: false,
//                           onMapCreated: (GoogleMapController controller) async {
//                             _googleMapController.complete(controller);
//                           },
//                           initialCameraPosition:
//                           CameraPosition(
//                             target: LatLng(
//                                 controller.orders[widget.index].shippingLat
//                                     .toDouble(),
//                                 controller.orders[widget.index].shippingLng
//                                     .toDouble()),
//                             zoom: 12.0,
//                           ),
//                           onCameraMove: (CameraPosition newPos) {
//                             currentLocation = newPos.target;
//                           },
//                           markers: _markers.toSet(),
//                         ),
//                         Positioned(
//                           bottom: SizeConfig.scaleHeight(10),
//                           right: SizeConfig.scaleWidth(10),
//                           left: SizeConfig.scaleWidth(10),
//                           child: ContainerApp(
//                             child: Column(
//                               children: [
//                                 Column(
//                                   children: [
//                                     SizedBox(
//                                       height: hSpaceSmall,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         SizedBox(),
//                                         image_circle(
//                                             imageString: controller
//                                                 .orders[widget.index]
//                                                 .deliveryimage,
//                                             size: 60),
//                                         Column(
//                                           children: [
//                                             StyleText(
//                                               controller.orders[widget.index]
//                                                   .deliveryname,
//                                             ),
//                                             SizedBox(
//                                               height: hSpace,
//                                             ),
//
//                                             StyleText(AppLocalizations.of(context)!
//                                                 .ourRepresentativeHasReceivedYourRequest),
//                                           ],
//                                         ),
//                                         SizedBox()
//                                       ],
//                                     ),
//
//                                   ],
//                                 ),
//                                 // Row(
//                                 //   mainAxisAlignment:
//                                 //       MainAxisAlignment.spaceBetween,
//                                 //   children: [
//                                 //     Expanded(
//                                 //       child: StyleText(
//                                 //         "${controller.orders[widget.index].shippingCost}  ${AppLocalizations.of(context)!.reyal}",
//                                 //         textColor: kSpecialColor,
//                                 //       ),
//                                 //     ),
//                                 //     Expanded(
//                                 //       child: StyleText(
//                                 //         "${controller.orders[widget.index].deliveryDuration}  ${controller.orders[widget.index].deliveryDurationUnit == "h" ? AppLocalizations.of(context)!.hour : "${controller.orders[widget.index].deliveryDurationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
//                                 //         textColor: kSpecialColor,
//                                 //       ),
//                                 //     ),
//                                 //   ],
//                                 // ),
//                                 SizedBox(
//                                   height: hSpace,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Expanded(
//                                       flex: 6,
//                                       child: StyleButton(
//                                         AppLocalizations.of(context)!
//                                             .chatWithDriver,
//                                         onPressed: () {
//                                           Navigator.pushReplacement(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) => Chat(
//
//                                                         orderNo:
//                                                             "${controller.orders[widget.index].orderNo}",
//                                                         user:
//                                                             "${controller.orders[widget.index].userId}",
//                                                         driver:
//                                                             "${controller.orders[widget.index].deliveryname}",
//                                                         family:
//                                                             "${controller.orders[widget.index].familyname}",
//                                                    phone:
//                                                    "${controller.orders[widget.index].deliveryphone}"
//
//
//                                                       )));
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: wSpace,
//                                     ),
//                                     Expanded(
//                                       flex: 4,
//                                       child: StyleButton(
//                                         AppLocalizations.of(context)!.done,
//                                         sideColor: kConfirm,
//                                         backgroundColor: kConfirm,
//                                         onPressed: () async {
//                                           await deliveredrmDeliveryOrder(
//                                               order_id:
//                                                   "${controller.orders[widget.index].id}");
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: wSpace,
//                                     ),
//                                     Expanded(
//                                       flex: 3,
//                                       child: StyleButton(
//                                         AppLocalizations.of(context)!.reporting,
//                                         sideColor: kRefuse,
//                                         backgroundColor: kRefuse,
//                                         onPressed: () async {
//                                           Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) {
//                                                 return Reporting(
//                                                   family: true,
//                                                   driver: true,
//                                                   id: controller.orders[widget.index].id,
//                                                 );
//                                               },
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: hSpace,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//               floatingActionButton:
//               Container(
//                       height: SizeConfig.scaleHeight(600),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FloatingActionButton(
//                       heroTag: "btn1",
//                             onPressed: () async {
//                               LocationData currentLocation = await LocationService().getLocation();
//                               _animateCamera(
//                                 LatLng(currentLocation.latitude!, currentLocation.longitude!),
//                               );
//                               List<Placemark> placemarks = await placemarkFromCoordinates(
//                                   currentLocation.latitude!, currentLocation.longitude!);
//                               await    updateProfile(latitude: currentLocation.latitude,longitude:currentLocation.longitude ,address: "${placemarks[0].street!} ${placemarks[0].subLocality!}",name: "user",phone: "0109886631111",email: "user@gmail.com");
//                               controller.refreshData();
//                                print("longitude  ${currentLocation.longitude}");
//                                print("latitude  ${currentLocation.latitude}");
//                                print("${placemarks[0].street!} ${placemarks[0].subLocality!}");
//                             },
//                             child: Icon(
//                               Icons.gps_fixed,
//                               color: Colors.white,
//                             ),
//                             backgroundColor: kSpecialColor,
//                           ),
//                           SizedBox(
//                             height: hSpaceLarge,
//                           ),
//                           FloatingActionButton(
//                               heroTag: "btn2",
//                             onPressed: () async {
//                               _animateCamera(
//                                 LatLng(
//                                     controller
//                                         .orders[widget.index].deliverylat
//                                         .toDouble(),
//                                     controller
//                                         .orders[widget.index].deliverylng
//                                         .toDouble()),
//
//                               );
//                             },
//                             child: Icon(
//                               Icons.delivery_dining,
//                               color: Colors.white,
//                             ),
//                             backgroundColor: kSpecialColor,
//                           ),
//                         ],
//                       ),
//                     )
//       );
//
//   }
//
//   void _getMarker() async {
//     iconUser = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(), 'assets/images/userIcon.png');
//
//     iconDriver = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(), 'assets/images/driverIcon.png');
//   }
//
//   Future deliveredrmDeliveryOrder({String order_id = ""}) async {
//     bool deliveredIt =
//         await OrderController().DeliveredDeliveryOrderUserController(
//       context: context,
//       language:
//           Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
//       order_id: order_id,
//     );
//
//     print(deliveredIt);
//
//     if (deliveredIt) {
//       print('ccccctrueeee55555');
//     }
//   }
//
//   Future<void> _animateCamera(LatLng currentLocation) async {
//     final GoogleMapController controller =await _googleMapController.future;
//     CameraPosition _cameraPosition = CameraPosition(
//       target: currentLocation,
//       zoom: 18.00,
//
//     );
//     controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
//   }
//
//   Future updateProfile({required String address,required dynamic latitude,required dynamic longitude, required String name,required String email,required String phone,
//
//   }) async {
//     await  controllerProfile.updateProfile(
//       name: name,
//       email: email,
//       address: address,
//
//       lat:latitude,
//       lng:longitude,
//       phone: phone,
//       uploadEvent: (bool status) {
//         if (status) {
//         }
//       },
//     );
//
//   }
// }
