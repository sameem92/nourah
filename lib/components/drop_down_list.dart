
import 'package:flutter/material.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class Drop_down_list_catego extends StatefulWidget {
  String valueChoose;
  List listItem;

  Drop_down_list_catego({required this.valueChoose, required this.listItem});
  @override
  _Drop_down_list_categoState createState() => _Drop_down_list_categoState();
}

class _Drop_down_list_categoState extends State<Drop_down_list_catego> {
  @override
  Widget build(BuildContext context) {
    // return GetX<getCategoriesFamilyGetx>(
    // builder: (getCategoriesFamilyGetx controller) {
    //   List  listItem=[
    //     controller.categoriesFamily
    //   ];
    //   final Value = widget.valueChoose == "1"
    //       ? controller.categoriesFamily[43]
    //       : controller.categoriesFamily[0];

    return SizedBox(
      width: SizeConfig.scaleWidth(370),
      child: ContainerApp(
        child: Padding(
          padding: EdgeInsets.only(left: wSpace, right: wSpace),
          child: DropdownButton(
            dropdownColor: Colors.white,
            elevation: 2,
            underline: SizedBox(),
            style: TextStyle(
              fontFamily: "ElMessiri",
              color: kPrimaryColor,
            ),
            icon: Icon(Icons.arrow_drop_down_sharp),
            iconSize: fIcon,
            isExpanded: true,
            value: widget.valueChoose,
            onChanged: (newValue) {
              setState(() {
                widget.valueChoose = newValue.toString();
              });
            },
            items: widget.listItem.map((valueItem) {
              return DropdownMenuItem(
                  value: valueItem, child: StyleText(valueItem));
            }).toList(),
          ),
        ),
      ),
    );
  }
}



class Drop_down_list_duration extends StatefulWidget {


  // Drop_down_list_duration({this.valueChoose="day"});

  @override
  _Drop_down_list_durationState createState() =>
      _Drop_down_list_durationState();
}

class _Drop_down_list_durationState extends State<Drop_down_list_duration> {
  String? valueChoose='day' ;
  List listItem = [
    "day",
    "minute",
    "hour",
    // AppLocalizations.of(context)!.h,
    // AppLocalizations.of(context)!.m,
    // AppLocalizations.of(context)!.d,
  ];
  @override
  Widget build(BuildContext context) {
    return
      ContainerApp(
        child: Padding(
          padding: EdgeInsets.only(left: wSpace, right: wSpace),
          child: DropdownButton(

            dropdownColor: Colors.white,
            elevation: 2,
            underline: SizedBox(),
            style: TextStyle(
              fontFamily: "ElMessiri",
              color: kPrimaryColor,
            ),
            icon: Icon(Icons.arrow_drop_down_sharp),
            iconSize: fIcon,
            isExpanded: true,
            value:valueChoose,
            onChanged: (newValue) {
              setState(() {
             valueChoose = newValue.toString();
              });
            },
            items:listItem.map<DropdownMenuItem<String>>((valueItem) {
              return DropdownMenuItem(

                  value: valueItem, child: StyleText(valueItem));
            }).toList(),
          ),
        ),

    );
  }
}
