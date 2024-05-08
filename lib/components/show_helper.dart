import 'package:flutter/material.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

void helper({
  required BuildContext context,
  required String message,
  bool error = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: StyleText(
        message,
        height: 1.3,
        textColor: kBackgroundColor,
        maxLines: 2,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: error ? kSpecialColor : kConfirm,
      elevation: 1,
    ),
  );
}
