import 'package:flutter/material.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';




class rowProduct extends StatelessWidget {
   String text1 ="";
   String text2 ="";
   String text3 ="";
    String text4 ="";
    bool notFirst =true;


  rowProduct({required this.text1, required this.text2, required this.text3, required this.text4,
    this.notFirst=true});

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
          if(notFirst == true)
SizedBox(height: hSpace,),
          if(notFirst == true)

            divider_app(
            height: 0,
          ),

        ],
      ),
    );
  }
}
class rowProductTitle extends StatelessWidget {
  String text1 ="";
  String text2 ="";
  String text3 ="";
  String text4 ="";
  Color textColor=Color(0xFF6F615D) ;
bool notFirst =true;


  rowProductTitle({required this.text1,textColor, required this.text2,this.notFirst=true,required this.text3,required this.text4});

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
                ),
              ),
              Expanded(
                flex: 2,
                child: StyleText(
                  text2,
                  textColor: textColor,

                ),
              ),
              Expanded(
                flex: 2,
                child: StyleText(
                  text3,
                  textColor: textColor,

                ),
              ),
              Expanded(
                flex: 2,
                child: StyleText(
                  text4,
                  textColor: textColor,

                ),
              ),
            ],
          ),
          if(notFirst == true)
            SizedBox(height: hSpace,),
          if(notFirst == true)

            divider_app(
              height: 0,
            ),

        ],
      ),
    );
  }
}
