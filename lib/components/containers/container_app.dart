import 'package:flutter/material.dart';
import 'package:producer_family_app/style/style_colors.dart';

class ContainerApp extends StatelessWidget {
  final Widget? child;
  final Color? colorContainer;
  ContainerApp({
    this.child,
    this.colorContainer = Colors.white,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(
        // start: wCard - 1,
        // end: wCard,
        // top: hCard,
        // bottom: hCard,
      ),
      margin: EdgeInsets.only(
        bottom: hCardMar,
        top: hCardMar,
        // left: wCardMar,
        // right: wCardMar,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          boxShadow: [
            BoxShadow(
                color: kGrey.withOpacity(.1), blurRadius:2, spreadRadius: 2)
          ],
          color: colorContainer),
      child: child,
    );
  }
}
