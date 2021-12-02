import 'package:flutter/material.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';


ListTile ListTileInfo(
    BuildContext context, {
      required String title,
      IconData? icon1 = Icons.navigate_next_outlined,
      IconData? icon2,
      Widget? widget,
      required Function onTap,
    }) {
  return ListTile(
    // dense: true,
subtitle: widget,
    hoverColor: kSpecialColor,
    horizontalTitleGap: 0,

    focusColor: kSecondaryColor,
    minVerticalPadding: 5,
    onTap: () {
onTap();

    },
    title: StyleText(title,textColor: kSecondaryColor,
    ),
    trailing: Icon(
      icon1,
      size: fIcon,
      color: kSecondaryColor,
    ),
    leading: Icon(
      icon2,
      size: fIcon,
      color: kSecondaryColor,
    ),
    contentPadding: EdgeInsets.only(
      left: 10,
      right: 10
    ),

  );
}