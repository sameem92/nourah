import 'package:flutter/material.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

void showDialoge(
  context, {
  required String message1,
  required String message2,
  Widget? message3,
  required Icon iconMeassge,
  required String button1,
  required String button2,
  required Color colorButton1,
  required Color colorButton2,
  required Function onPressed,
  double height = 270,
}) {
  showDialog(
      context: context,
    // useRootNavigator: false,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          content: Padding(
            padding: EdgeInsets.only(
              left: wPadding,
              right: wPadding,
              top: hPadding,
              bottom: hPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                iconMeassge,
                SizedBox(
                  height: hSpaceSmall,
                ),
                StyleText(
                  message1,
                  fontSize: fLargev,
                ),
                SizedBox(
                  height: hSpace,
                ),
                StyleText(
                  message2,
                  maxLines: 4,
                  height: 1.7,
                ),
                message3!, dividerApp(),
                // Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: StyleButton(
                        button1,
                        backgroundColor: colorButton1,
                        sideColor: colorButton1,
                        onPressed: () {
                          onPressed();
                        },
                      ),
                    ),
                    SizedBox(
                      width: wSpace,
                    ),
                    Expanded(
                      child: StyleButton(
                        button2,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: colorButton2,
                        sideColor: colorButton2,
                        // width: SizeConfig.scaleWidth(130),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },);
}

void imageDialoge(context, {required String imageProduct}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,

          elevation: 200,
          content: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  SizeConfig.scaleHeight(borderRadius),
                ),
                boxShadow: [
                  BoxShadow(
                      color: kGrey.withOpacity(.1),
                      blurRadius: 2,
                      spreadRadius: 4,)
                ],
                color: Colors.transparent,),
            width: SizeConfig.scaleWidth(400),
            height: SizeConfig.scaleHeight(400),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: ImageContainer(
              imageProduct,
            ),
          ),
        );
      },);
}
