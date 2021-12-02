import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:form_field_validator/form_field_validator.dart';

class StyleField extends StatefulWidget {
  final String? title;
  final double width;
  final double height;
  final double fontSize;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final int maxLines;
  final bool obscureText;
  final bool isEmail;
  final bool isRequired;
  final bool isPhone;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final int? maxLength;
  final String counter;
  final String? suffixText;
  final String? prefixText;
  // late Function validator;
  final String hintText;
  String initialValue;
  final bool? filled;
  final bool? enabledBorderBool;
  final bool? filledBool;
  final Color colorBackground;
  final Color color;
  final Icon? prefixIcon;
  // final IconButton suffixIcon;
  final Icon? icon;
  late double? padding;
  final Function? onChanged;
  final Function? onSaved;
  final validator;

  StyleField({
    this.title,
    this.maxLines = 1,
    this.width = 370,
    this.height = 40,
    this.keyboardType,
    this.fontSize = 18,
    this.textAlign = TextAlign.center,
    this.obscureText = false,
    this.controller,
    this.maxLength,
    this.counter = '',
    this.filled = false,
    this.enabledBorderBool = true,
    this.filledBool = true,
    this.textDirection,
    this.onChanged,
    this.onSaved,
    this.suffixText,
    this.prefixText,
    this.colorBackground = kBackgroundColor,
    this.prefixIcon,
    this.color = Colors.white,
    this.hintText = "",
    this.initialValue = '',
    this.icon,
    this.padding = 15,
    this.validator,
    this.isEmail = false,
    this.isPhone = false,
    this.isRequired = false,
  });

  @override
  State<StyleField> createState() => _StyleFieldState();
}

class _StyleFieldState extends State<StyleField> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.scaleWidth(360),
      child: TextFormField(

        textInputAction: TextInputAction.done,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        maxLines: widget.maxLines,

        validator: MultiValidator([
          if (widget.isEmail)
            EmailValidator(
                errorText:
                    AppLocalizations.of(context)!.theFormOfEmailIsNotCorrect),
          if (widget.isRequired)
            RequiredValidator(
                errorText: AppLocalizations.of(context)!.theFieldIsRequired),
          if (widget.isPhone)
            MinLengthValidator(10,
                errorText: AppLocalizations.of(context)!
                    .theNumberOfFieldsIsNotLessThan10),
          if (widget.isPhone)
            MaxLengthValidator(15,
                errorText: AppLocalizations.of(context)!
                    .theNumberOfFieldsIsNotMoreThan10,),
        ]),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.center,

        maxLength: widget.maxLength,
        textDirection: Localizations.localeOf(context).languageCode == "ar"
            ? TextDirection.rtl
            : TextDirection.ltr,
        cursorColor:  kSecondaryColor.withOpacity(.8),

        textAlign: TextAlign.center,
        cursorHeight: SizeConfig.scaleTextFont(27),
        style: TextStyle(


            color:  kTextColor,
            fontSize: SizeConfig.scaleTextFont(widget.fontSize),
            // fontWeight: FontWeight.w400,
            fontFamily:"ElMessiri",            overflow: TextOverflow.ellipsis),
        decoration: InputDecoration(
          hintText: widget.hintText,

          labelText:
              widget.controller!.text.isEmpty || widget.controller!.text == ""
                  ? widget.title
                  : "",
          fillColor: Colors.white,

          contentPadding:
              EdgeInsets.only(
                left: SizeConfig.scaleWidth(15),
                right: SizeConfig.scaleWidth(15),
                top: SizeConfig.scaleHeight(5),
                bottom:SizeConfig.scaleHeight(5),
              ),
          isDense: true,
          prefixText: widget.prefixText,
          icon: widget.icon,
          suffixText: widget.suffixText,
          suffixStyle: TextStyle(
              fontFamily:"ElMessiri",
              color: kTextColor,
              fontSize: SizeConfig.scaleWidth(widget.fontSize),
              overflow: TextOverflow.visible),
          prefixIcon: widget.prefixIcon,
          suffixIcon:
              widget.controller!.text.isEmpty || widget.controller!.text == ''
                  ? Text('')
                  : IconButton(padding: EdgeInsets.zero,
                      icon: Icon(Icons.close),
                      onPressed: () {
                        widget.controller!.clear();
                        FocusScope.of(context).unfocus();
                      },
                    ),
          prefixStyle: TextStyle(
              fontFamily:"ElMessiri",
              color: kTextColor,
              fontSize: SizeConfig.scaleWidth(widget.fontSize),
              overflow: TextOverflow.visible),
          hintStyle: TextStyle(

              color:  kTextColor,
              fontSize: SizeConfig.scaleWidth(widget.fontSize),
              fontWeight: FontWeight.w400,
              fontFamily:"ElMessiri",
              overflow: TextOverflow.visible),
          filled:widget.filledBool==true? true:false,
          isCollapsed: false,
          labelStyle: TextStyle(

            color:  kTextColor,
            overflow: TextOverflow.visible,
            fontSize: SizeConfig.scaleWidth(widget.fontSize),
            fontWeight: FontWeight.w400,
            fontFamily:"ElMessiri",
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: kRefuse.withOpacity(.5),
              width: SizeConfig.scaleWidth(1),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              
              color: kSecondaryColor.withOpacity(.5),
              width: SizeConfig.scaleWidth(1),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: kSecondaryColor.withOpacity(.5),
              width: SizeConfig.scaleWidth(1),
            ),
          ),
          // disabledBorder: InputBorder.none,

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: kRefuse.withOpacity(.5),
              width: SizeConfig.scaleWidth(1),
            ),
          ),
          enabledBorder:widget.enabledBorderBool==true? OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: kSecondaryColor.withOpacity(.1),
              width: SizeConfig.scaleWidth(1),
            ),
          ):InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: kSecondaryColor.withOpacity(.5),
              width: SizeConfig.scaleWidth(1),
            ),
          ),
        ),
        autocorrect: false,

        onChanged: (value) {
          widget.onChanged;
        },
        onSaved: (value) {
          widget.onSaved;
        },
        // initialValue:widget.initialValue ,
      ),
    );
    // );
  }
}
