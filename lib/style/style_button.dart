import 'package:flutter/material.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StyleButton extends StatelessWidget {
  final double width;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color sideColor;
  final double sideWidth;
  final double height;
  final Function onPressed;
  final double elevation;
  final double fontSize;
  final double heightText;
  final IconData? iconName;
  final Color? iconColor;
  double? sizeIcon = fIconSmall;

  StyleButton(
    this.text, {
    this.width = 250,
    this.textColor = Colors.white,
    this.backgroundColor = kSecondaryColorButtom,
    this.sideColor = kSecondaryColorButtom,
    this.height = 40,
    this.sideWidth = 2,
    required this.onPressed,
    this.elevation = 1,
    this.fontSize = 18,
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
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconName != null)
              Icon(
                iconName,
                color: iconColor,
                size: sizeIcon,
              ),
            StyleText(
              text,
              textColor:textColor==Colors.white?Colors.white: textColor.withOpacity(.8),
              fontSize: fontSize,
              height: heightText,

            ),
          ],
        ),

        autofocus: true,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor.withOpacity(.7),
          elevation: SizeConfig.scaleHeight(elevation),
          primary: kSpecialColor.withOpacity(.8),
          onSurface: kSpecialColor.withOpacity(.8),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            borderRadius,
          )),
          side: BorderSide(
            color: sideColor.withOpacity(0),
            width: borderWidth,
          ),
        ),
      ),
    );
  }
}

