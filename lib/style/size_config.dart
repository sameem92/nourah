import 'package:flutter/material.dart';

class SizeConfig {
late   double? _screenWidth;
 late  double? _screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double? textMultiplier;
  static double? imageSizeMultiplier;
  static double? heightMultiplier;
  static double? widthMultiplier;
  static double? deviceRatio;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  late  MediaQueryData? _mediaQueryData;

  void init(BuildContext context) {

    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData!.size.width;
    _screenHeight = _mediaQueryData!.size.height;

    _blockWidth = _screenWidth! / 100;
    _blockHeight = _screenHeight! / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
    deviceRatio = _screenWidth! / _screenHeight!;
  }

  static double scaleTextFont(double fontSize) {
    double scale = fontSize / 9.26;
    return (textMultiplier! * scale);
  }



  static double scaleWidth(double width) {
    double scale = width / 4.28;
    return (widthMultiplier! * scale);
  }

  static double scaleHeight(double height) {
    double scale = height / 9.26;
    return (heightMultiplier! * scale);
  }


}