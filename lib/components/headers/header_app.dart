import 'package:flutter/material.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';



Column header_app(BuildContext context,{required String title}) {
  return Column(
    children: [
      SizedBox(
        height: hheader,
      ),
      StyleText(
      title,

        textColor: kSpecialColor,
        fontSize: SizeConfig.scaleWidth(30),
      ),
      Stack(
        children: [
          divider_app(),
          Divider(
            color: kSpecialColor,
            height: SizeConfig.scaleHeight(20),
            thickness: SizeConfig.scaleHeight(2),
            endIndent:SizeConfig.scaleWidth(125),
            indent:SizeConfig.scaleWidth(125),
          ),
        ],
      ),
    ],
  );
}
