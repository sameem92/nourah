import 'package:flutter/material.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';

class ContainerApp extends StatelessWidget {
  Widget? child;

  ContainerApp({
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: wCard - 1,
        end: wCard,
        top: hCard,
        bottom: hCard,
      ),
      margin: EdgeInsets.only(
        bottom: hCardMar,
        top: hCardMar,
        left: wCardMar,
        right: wCardMar,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          boxShadow: [
            BoxShadow(
                color: kSecondaryColor.withOpacity(.1),
                blurRadius: 2,
                spreadRadius: 1)
          ],
          color: Colors.white),
      child: child,
    );
  }
}
