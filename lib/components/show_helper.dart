import 'package:flutter/material.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:url_launcher/url_launcher.dart';

void Helper(
    {required BuildContext context,
    required String message,
    bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: StyleText(
      message,
      height: 1,
      textColor: kBackgroundColor,
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: error ? kSpecialColor.withOpacity(.8) : kConfirm,
    elevation: 1,
  ));
}

void launchURL(_url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
