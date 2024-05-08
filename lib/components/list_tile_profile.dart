import 'package:flutter/material.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';


Column listTileInfo(
    BuildContext context, {
      required String title,
      IconData? icon1 = Icons.navigate_next_outlined,
      IconData? icon2,
      Widget? widget,
      required Function onTap,
    }) {
  return Column(
    children: [
      Expanded(
        flex:3,
        child: ListTile(


          subtitle: widget,
          hoverColor: kSpecialColor,
          horizontalTitleGap: 0,
dense: true,
          focusColor: kSpecialColor,
          selectedTileColor: kSpecialColor,
          minVerticalPadding: 5,
          onTap: () {
onTap();

          },
          title: StyleText(title,textColor: kTextColor,
          ),
          trailing: Icon(
            icon1,
            size: fIcon,
            color: kSpecialColor,
          ),
          leading: Icon(
            icon2,
            size: fIcon,
            color: kSpecialColor,
          ),
          contentPadding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),

        ),
      ),

// Expanded(flex: 2,child: SizedBox(height: 100,)),
      Expanded(child: dividerApp(height: 0)),

    ],
  );
}
