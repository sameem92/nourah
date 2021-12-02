// buildGestureDetector_order(),
// if (visible == true) buildContainer_order(context),
// divider_app(height: 70),
// buildGestureDetector_order(),
// if (visible1 == true) buildContainer_order(context),
// divider_app(height: 70),
// buildGestureDetector_order(),
// if (visible2 == true) buildContainer_order(context),
// divider_app(height: 70),
// buildGestureDetector_order(),
// if (visible3 == true) buildContainer_order(context),


// Container buildContainer_order(BuildContext context) {
//   return Container(
//     decoration: BoxDecoration(
//       border: Border.all(color: kSecondaryColor, width: borderWidth),
//       borderRadius: BorderRadius.circular(
//         SizeConfig.scaleHeight(borderRadius),
//       ),
//       color: Colors.white,
//     ),
//     margin: EdgeInsetsDirectional.only(
//       // bottom: SizeConfig.scaleHeight(20),
//     ),
//     padding: EdgeInsetsDirectional.only(
//       end: wCard,
//       start: wCard,
//       top: hCard,
//       bottom: hCard,
//     ),
//     child: Column(
//       children: [
//         rowProduct(
//           notFirst: false,
//           text1: "الصنف",
//           text2: "الكمية",
//           text3: "سعر الحبة",
//           text4: "الاجمالي",
//         ),
//         SizedBox(
//           height: hSpace,
//         ),
//         rowProduct(
//           text1: "بيتزا",
//           text2: "٩٩٩٩",
//           text3: "٩٩٩٩٩",
//           text4: "٩٩٩٩٩",
//         ),
//         rowProduct(
//           text1: "بيتزا",
//           text2: "٩٩٩٩",
//           text3: "٩٩٩٩٩",
//           text4: "٩٩٩٩٩",
//         ),
//         rowProduct(
//           text1: "بيتزا",
//           text2: "٩٩٩٩",
//           text3: "٩٩٩٩٩",
//           text4: "٩٩٩٩٩",
//         ),
//         rowProduct(
//           text1: "بيتزا",
//           text2: "٩٩٩٩",
//           text3: "٩٩٩٩٩",
//           text4: "٩٩٩٩٩",
//         ),
//         SizedBox(
//           height: hSpaceLarge,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             StyleText(AppLocalizations.of(context).totalCost),
//             SizedBox(
//                 width: SizeConfig.scaleWidth(80),
//                 child: StyleText(
//                   "7777 sr",
//                   textColor: kSpecialColor,
//                 ))
//           ],
//         ),
//         SizedBox(
//           height: hSpaceLarge,
//         ),
//         SizedBox(
//             width: double.infinity,
//             child: StyleText(
//               AppLocalizations.of(context).userNotes,
//               textAlign: TextAlign.start,
//             )),
//         SizedBox(
//           height: hSpaceSmall,
//         ),
//         notes(),
//         SizedBox(
//           height: hSpaceLarge,
//         ),
//         StyleField(
//           title: AppLocalizations.of(context).familyNotes,
//           width: double.infinity,
//           maxLines: 10,
//           height: SizeConfig.scaleHeight(130),
//         ),
//         SizedBox(
//           height: hSpaceLarge,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: StyleField(
//                 title: AppLocalizations.of(context).processingTime,
//                 keyboardType: TextInputType.number,
//                 // controller: _toController,
//               ),
//             ),
//             SizedBox(
//               width: wSpace,
//             ),
//             Expanded(
//               flex: 2,
//               child: Container(
//                 height: SizeConfig.scaleHeight(40),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   border:
//                   Border.all(color: kSecondaryColor, width: borderWidth),
//                   borderRadius: BorderRadius.circular(
//                     SizeConfig.scaleHeight(borderRadius),
//                   ),
//                   color: Colors.white,
//                 ),
//                 padding: EdgeInsetsDirectional.only(
//                   start: SizeConfig.scaleHeight(20),
//                   end: SizeConfig.scaleHeight(20),
//                 ),
//                 child: DropdownButton(
//                   dropdownColor: Colors.white,
//                   elevation: 2,
//                   underline: SizedBox(),
//                   style: TextStyle(
//                     fontFamily: "Almarai",
//                     color: kPrimaryColor,
//                   ),
//                   icon: Icon(Icons.arrow_drop_down_sharp),
//                   iconSize: fIcon,
//                   isExpanded: true,
//                   value: valueChooseDuration,
//                   onChanged: (newValue) {
//                     setState(() {
//                       valueChooseDuration = newValue;
//                     });
//                   },
//                   items: listItemDuration.map((valueItem) {
//                     return DropdownMenuItem(
//                         value: valueItem, child: StyleText(valueItem));
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: hSpaceLargev,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               flex: 1,
//               child: StyleButton(
//                 AppLocalizations.of(context).refuse,
//                 sideColor: kRefuse,
//                 backgroundColor: kRefuse,
//               ),
//             ),
//             SizedBox(
//               width: wSpace,
//             ),
//             Expanded(
//               flex: 2,
//               child: StyleButton(
//                 AppLocalizations.of(context).confirm,
//                 sideColor: kConfirm,
//                 backgroundColor: kConfirm,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
//
// GestureDetector buildGestureDetector_order() {
//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         if (visible == true) {
//           visible = false;
//         } else {
//           visible = true;
//         }
//       });
//     },
//     child: gesture_order(
//       title: "رقم الطلبية ١٢٣ ",
//       date: "11/2/2020",
//       currentAndEnd: true,
//     ),
//   );
// }
// }
