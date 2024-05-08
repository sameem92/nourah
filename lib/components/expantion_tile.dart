import 'package:flutter/material.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

//**********************************************************************

class MainExpantion extends StatelessWidget {
  final String mainTitle;
  final Widget column;
  final bool initiallyExpanded;

  MainExpantion(
      {required this.mainTitle,
      required this.column,
      this.initiallyExpanded = false});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      backgroundColor: Colors.grey[200],
      title: StyleText(
        mainTitle,
      ),
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: wSpaceLarge,
            right: wSpaceLarge,
            top: hSpaceLarge,
            bottom: hSpaceLarge,
          ),
          child: column,
        ),
      ],
    );
  }
}
//**********************************************************************

class SubExpantion extends StatelessWidget {
  final String title;
  final String subject;

  const SubExpantion({required this.title, required this.subject});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: StyleText(
        title,
        height: 2,
      ),
      children: [
        Column(
          children: [
            StyleText(
              subject,
              maxLines: 10,
              height: 2,
              textColor: kSpecialColor,
            ),
            SizedBox(
              height: hSpaceLarge,
            )
          ],
        ),
      ],
    );
  }
}

//**********************************************************************
