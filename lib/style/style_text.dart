import 'package:flutter/material.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';

class StyleText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;

  final FontWeight fontWeight;
  final int maxLines;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? width;
  final double height;
  final double? height2;
  final TextDecoration? textDecoration;
  final TextAlign textAlign;

  const StyleText(this.text,
      {this.textColor = kTextColor,
      this.fontSize = 19,
      this.fontWeight = FontWeight.w400,
      this.maxLines = 2,
        this.letterSpacing,
      this.wordSpacing,
      this.width,
      this.height = 1,
      this.height2, this.textDecoration, this.textAlign=TextAlign.center,});
  @override
  Widget build(BuildContext context) {

    return SizedBox(

      width: width,
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
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
        ),
      ),
    );
  }
}
