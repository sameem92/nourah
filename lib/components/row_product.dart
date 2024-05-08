import 'package:flutter/material.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

class RowProduct extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final bool notFirst;

  RowProduct({
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    this.notFirst = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: hSpace,
        bottom: hSpaceSmall,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: StyleText(
                  text1,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 3,
                child: StyleText(
                  text2,
                ),
              ),
              Expanded(
                flex: 3,
                child: StyleText(
                  text3,
                ),
              ),
              Expanded(
                flex: 3,
                child: StyleText(
                  text4,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          if (notFirst == true)
            SizedBox(
              height: hSpace,
            ),
          if (notFirst == true)
            dividerApp(
              height: 0,
            ),
        ],
      ),
    );
  }
}

class RowProductTitle extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  final Color textColor = const Color(0xFF6F615D);
  final Color textColor2 = const Color(0xFF6F615D);
  final bool notFirst;

  const RowProductTitle(
      {required this.text1,
      textColor,
      required this.text2,
      this.notFirst = true,
      required this.text3,
      required this.text4,
      this.text5 = '',
      this.text6 = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: hSpace,
        bottom: hSpaceSmall,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: StyleText(
                  text1,
                  textAlign: TextAlign.center,
                  textColor: textColor,
                  maxLines: 2,
                ),
              ),
              Expanded(
                flex: 2,
                child: StyleText(
                  text2,
                  textColor: textColor2,
                  maxLines: 2,
                ),
              ),
              Expanded(
                flex: 2,
                child: StyleText(
                  text3,
                  textColor: textColor,
                  maxLines: 2,
                ),
              ),
              Expanded(
                flex: 2,
                child: StyleText(
                  text4,
                  textColor: textColor,
                  maxLines: 2,
                ),
              ),
              if (text5 != "")
                Expanded(
                  flex: 2,
                  child: StyleText(
                    text5,
                    textColor: textColor,
                    maxLines: 2,
                  ),
                )
              else
                Column(),
              if (text6 != "")
                Expanded(
                  flex: 2,
                  child: StyleText(
                    text6,
                    textColor: textColor,
                    maxLines: 2,
                  ),
                )
              else
                Column(),
            ],
          ),
          if (notFirst == true)
            SizedBox(
              height: hSpace,
            ),
          if (notFirst == true)
            dividerApp(
              height: 0,
            ),
        ],
      ),
    );
  }
}
