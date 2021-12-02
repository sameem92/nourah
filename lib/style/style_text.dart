import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';

class StyleText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  // final String fontFamily1;
  // final String fontFamily2;
  final FontWeight fontWeight;
  final int maxLines;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? width;
  final double height;
  final double? height2;
  final TextDecoration? textDecoration;
  final TextAlign textAlign;

  StyleText(this.text,
      {this.textColor = kTextColor,
      this.fontSize = 18,
      this.fontWeight = FontWeight.w400,
      this.maxLines = 1,
      // this.fontFamily1 = "Almarai",
      // this.fontFamily2 = "Almarai",
      this.letterSpacing,
      this.wordSpacing,
      this.width,
      this.height = 1,
      this.height2, this.textDecoration, this.textAlign=TextAlign.center});
  @override
  Widget build(BuildContext context) {

    return SizedBox(

      width: width,
      // height: height2,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,

        style: TextStyle(
          height: SizeConfig.scaleWidth(height),
          color: textColor,
          decoration: textDecoration,
          fontSize: SizeConfig.scaleTextFont(fontSize),
          fontWeight: fontWeight,
          fontFamily:"ElMessiri",
              // Intl.getCurrentLocale() == "ar" ? fontFamily1 : fontFamily2,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
        ),
      ),
    );
  }
}
