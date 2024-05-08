//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
// import 'package:producer_family_app/components/containers/card_app.dart';
// import 'package:producer_family_app/components/containers/container_app.dart';
// import 'package:producer_family_app/components/headers/app_bar_family.dart';
// import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/main_screen.dart';
// import 'package:producer_family_app/storage/api/order_controller.dart';
// import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
// import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
// import 'package:producer_family_app/style/size_config.dart';
// import 'package:producer_family_app/style/style_button.dart';
// import 'package:producer_family_app/style/style_colors.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:producer_family_app/style/style_text.dart';
//
// class ChooseDriverScreen extends StatefulWidget {
// int index;
//
// ChooseDriverScreen({this.index=0});
//
//
//   @override
//   _ChooseDriverScreenState createState() => _ChooseDriverScreenState();
// }
//
// class _ChooseDriverScreenState extends State<ChooseDriverScreen> {
//   getOrderGetX cont = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWhite(
//         context,
//         onPressed: (){},
//         title: AppLocalizations.of(context)!.chooseyourdriver,
//       ),
//       body: GetX<getOrderGetX>(
//         init: getOrderGetX(language: Localizations.localeOf(context).languageCode=="ar"?"ar":"en"),
//     builder: (getOrderGetX controller) {
//       return Padding(
//         padding: EdgeInsetsDirectional.only(
//           start: wPadding,
//           end: wPadding,
//           bottom: hPadding,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: hSpace,
//               ),
//
//               controller.isLoading.value
//                   ? Center(
//                 child: indicator_nourah_loading()
//               )
//
//
//               : controller.orders[widget.index]
//                   .deliveryoffers.length!=0?
//               ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     padding: EdgeInsets.zero,
//                     shrinkWrap: true,
//                     itemCount: controller.orders[widget.index]
//                         .deliveryoffers.length,
//                     itemBuilder: (context, indexxx) {
//                       return
//                       Card_waiting_delivery_user_order(
//
//                           context,
//                           id: controller.orders[widget.index]
//                               .deliveryoffers[indexxx].id,
//
//                           driverCost:
//                           "${controller.orders[widget.index].deliveryoffers[indexxx]
//                               .shippingCost}",
//                           driverName:
//                           "${controller.orders[widget.index].deliveryoffers[indexxx]
//                               .deliveryname}",
//                           driverRate:
//                           "${controller.orders[widget.index].deliveryoffers[indexxx]
//                               .deliveryrate}",
//                           driverTimeUnit:
//                           "${controller.orders[widget.index].deliveryoffers[indexxx]
//                               .deliveryDurationUnit == "h" ? AppLocalizations
//                               .of(context)!.hour : "${controller.orders[widget.index]
//                               .deliveryoffers[indexxx].deliveryDurationUnit}" ==
//                               "m"
//                               ? AppLocalizations.of(context)!.minute
//                               : AppLocalizations.of(context)!.day} ",
//                           driverTime:
//                           "${controller.orders[widget.index].deliveryoffers[indexxx]
//                               .deliveryDuration}",
//                           special: true,
//                           driverImage:
//                           "${controller.orders[widget.index].deliveryoffers[indexxx]
//                               .deliveryimage}");
//                             }
//
//                   // controller.orders[widget.index]
//                   // .deliveryoffers.length!=0
//               ) :noContent(context,
//                   AppLocalizations.of(context)!.thereIsnoDriversUntilNow)
//
//           ],
//           ),
//         ),
//       );
//
//     }
//     ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//
//         floatingActionButton:
//         StyleButton(
//           "${AppLocalizations.of(context)!.refresh} ",
//
//
//             onPressed: () async {
//               await refreshOrder();
//             },
//
//           width: SizeConfig.scaleWidth(400),
//           height: SizeConfig.scaleHeight(65),
//           backgroundColor: kSpecialColor,
//           sideColor: kSpecialColor,
//         )
//
//     );
//
//   }
//
//   ContainerApp Card_waiting_delivery_user_order(BuildContext context,
//       {bool? special,
//         String? driverName = "",
//         String? driverRate = "",
//         String? driverTime = "",
//         String? driverTimeUnit = "",
//         String? driverCost = "",
//         required int id ,
//         String driverImage = ""}) {
//     return card_app(
//         Row(
//           children: [
//             Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,                children: [
//                   SizedBox(
//                     width: wBetweenCard,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 11,
//                           child: StyleText(
//                             "$driverName",
//                             textColor: kSecondaryColor,
//                             textAlign: TextAlign.start,
//                           ),
//                         ),
//                         Expanded(
//                           flex: 3,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               StyleText(
//                                 "$driverRate",
//                                 textAlign: TextAlign.end,
//                               ),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.amber,
//                                 size: fIconSmall,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: hSpaceSmall,
//                   ),
//                   SizedBox(
//                     width: wBetweenCard,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           child: StyleText(
//                             "$driverTime $driverTimeUnit",
//                             textAlign: TextAlign.start,
//                           ),
//                         ),
//                         Expanded(
//                           child: StyleText(
//                             "$driverCost ${AppLocalizations.of(context)!.reyal}",
//                             textColor: kSpecialColor,
//                             textAlign: TextAlign.end,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: hSpaceSmall,
//                   ),
//                   StyleButton(
//                     AppLocalizations.of(context)!.acceptdeal,
//                     onPressed: () async {
//                       // await confirmDeliveryOrder(id:id);
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//         special: true,
//         image: driverImage,);
//   }
// //   Future confirmDeliveryOrder({required int id}) async {
// //     await cont.confirmDeliveryOrder(
// //        id:id ,
// //         context: context);
// // print("id ${id}confirmed");
// //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(currentIndex: 1,orderIndex: 1,)));
// //
// //   }
//   Future refreshOrder() async {
//     await OrderController().RefreshOrderUserController(
//       language: Localizations.localeOf(context).languageCode=="ar"?"ar":"en"
//       ,
//       context: context,
//     );
//   }
//
// }
