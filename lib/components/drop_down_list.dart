// import 'package:flutter/material.dart';
// import 'package:producer_family_app/components/containers/container_app.dart';
// import 'package:producer_family_app/style/size_config.dart';
// import 'package:producer_family_app/style/style_colors.dart';
// import 'package:producer_family_app/style/style_text.dart';
//
// class DropDownListCatego extends StatefulWidget {
//   String? valueChoose;
//   final List listItem;
//
//   DropDownListCatego({required this.valueChoose, required this.listItem});
//   @override
//   _DropDownListCategoState createState() => _DropDownListCategoState();
// }
//
// class _DropDownListCategoState extends State<DropDownListCatego> {
//   @override
//   Widget build(BuildContext context) {
//     // return GetX<getCategoriesFamilyGetx>(
//     // builder: (getCategoriesFamilyGetx controller) {
//     //   List  listItem=[
//     //     controller.categoriesFamily
//     //   ];
//     //   final Value = widget.valueChoose == "1"
//     //       ? controller.categoriesFamily[43]
//     //       : controller.categoriesFamily[0];
//
//     return SizedBox(
//       width: SizeConfig.scaleWidth(370),
//       child: ContainerApp(
//         child: Padding(
//           padding: EdgeInsets.only(left: wSpace, right: wSpace),
//           child: DropdownButton(
//             dropdownColor: Colors.white,
//             elevation: 2,
//             underline: const SizedBox(),
//             style: TextStyle(
//               fontFamily: "ElMessiri",
//               color: kSpecialColor,
//             ),
//             icon: const Icon(Icons.arrow_drop_down_sharp),
//             iconSize: fIcon,
//             isExpanded: true,
//             value: widget.valueChoose,
//             onChanged: (newValue) {
//               setState(() {
//                 widget.valueChoose = newValue.toString();
//               });
//             },
//             items: widget.listItem.map((valueItem) {
//               return DropdownMenuItem(
//                 value: valueItem,
//                 child: StyleText(valueItem),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DropDownListDuration extends StatefulWidget {
//   // Drop_down_list_duration({this.valueChoose="day"});
//
//   @override
//   _DropDownListDurationState createState() => _DropDownListDurationState();
// }
//
// class _DropDownListDurationState extends State<DropDownListDuration> {
//   String? valueChoose = 'day';
//   List listItem = [
//     "day",
//     "minute",
//     "hour",
//     // AppLocalizations.of(context)!.h,
//     // AppLocalizations.of(context)!.m,
//     // AppLocalizations.of(context)!.d,
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return ContainerApp(
//       child: Padding(
//         padding: EdgeInsets.only(left: wSpace, right: wSpace),
//         child: DropdownButton(
//           dropdownColor: Colors.white,
//           elevation: 2,
//           underline: const SizedBox(),
//           style: TextStyle(
//             fontFamily: "ElMessiri",
//             color: kSpecialColor,
//           ),
//           icon: const Icon(Icons.arrow_drop_down_sharp),
//           iconSize: fIcon,
//           isExpanded: true,
//           value: valueChoose,
//           onChanged: (newValue) {
//             setState(() {
//               valueChoose = newValue.toString();
//             });
//           },
//           items: listItem.map<DropdownMenuItem<String>>((valueItem) {
//             return DropdownMenuItem(
//                 value: valueItem, child: StyleText(valueItem));
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
