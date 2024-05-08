import 'package:flutter/material.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

class StyleButton extends StatelessWidget {
  final double width;
  final String text;
  final Color textColor;
  final Color? backgroundColor;
  final Color? sideColor;
  final double sideWidth;
  final double height;
  final Function onPressed;
  final double elevation;
  final double fontSize;
  final double heightText;
  final IconData? iconName;
  final Color? iconColor;
  final double? widthText;
  double? sizeIcon = fIconSmall;

  StyleButton(
    this.text, {
    this.width = 250,
    this.widthText,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.sideColor,
    this.height = 40,
    this.sideWidth = 2,
    required this.onPressed,
    this.elevation = 1,
    this.fontSize = 20,
    this.heightText = 1,
    this.iconName,
    this.iconColor,
    this.sizeIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.scaleWidth(40),
      width: SizeConfig.scaleWidth(width),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: FittedBox(
          child: StyleText(
            text,
            textColor: textColor == Colors.white
                ? Colors.white
                : textColor.withOpacity(.8),
            fontSize: fontSize,
            height: heightText,
            width: widthText,
          ),
        ),
        autofocus: true,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? kSpecialColor,
          elevation: SizeConfig.scaleHeight(1),
          primary: kSpecialColor,
          onSurface: kSpecialColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            borderRadius,
          )),
          side: BorderSide(
            color: sideColor != null ? sideColor! : kSpecialColor,
            width: 0,
          ),
        ),
      ),
    );
  }
}
