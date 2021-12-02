import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/login_screens/code_login_screen.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'logged_in_with_gmail.dart';
import 'login_in_with_apple.dart';

class LoginScreen extends StatefulWidget {

  String id;
  int totalPrice;
  int price;
  int productId;
  int productQu;
  String productName;
  String productImage;
  bool back;
  bool main;
  IconData? icon;
  IconData? iconBack;

  LoginScreen({this.back=false,this.main=false,this.icon=null,this.iconBack=Icons.arrow_back,this.price=0,this.id="",this.productName="",this.productImage="", this.totalPrice=0, this.productId=0, this.productQu=0});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 late TextEditingController _phoneNumber;
  String loginTypePhone = 'phone';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneNumber = TextEditingController();
    _phoneNumber.addListener(() => setState(() {}));

  }

  @override
  void dispose() {
    super.dispose();
    _phoneNumber.dispose();
  }
 var _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(

      appBar: AppBarWhite(
        context,
        title: AppLocalizations.of(context)!.verifyfromaccount ,onPressed: (){},
        back: widget.back,
        main: widget.main,
        icon: widget.icon,
        iconBack: widget.iconBack,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: wPadding,
          end: wPadding,
          top: hPadding,
          bottom: hPadding,
        ),
        child: SizedBox(
          width: double.infinity,
          child:   Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      SizedBox(
                        height: hSpace,
                      ),
                      Icon(
                        Icons.perm_contact_calendar,
                        size: SizeConfig.scaleTextFont(150),
                        color: kSecondaryColor,
                      ),
                      StyleText(
                        AppLocalizations.of(context)!.explainverifyfromaccount,
                        maxLines: 5,
                        width: SizeConfig.scaleWidth(300),
                        height: 2,
                      ),
                      SizedBox(
                        height: hSpaceLargev,
                      ),
                       SizedBox(
                         height: SizeConfig.scaleWidth(90),
                         child: StyleField(
                            title: AppLocalizations.of(context)!.register_family_number,
                            suffixText: "00966",
                            padding: 0,

                            keyboardType: TextInputType.number,
                            isPhone: true,
                            isRequired: true,
                            controller: _phoneNumber,
                            prefixIcon: Icon(Icons.phone_android_outlined),
                          ),
                       ),


                      SizedBox(
                        height: hSpaceLarge,
                      ),

                      StyleButton(
                        AppLocalizations.of(context)!.next,
                        onPressed: ()async{
                   bool   isValidate=  _formKey.currentState!.validate() ;
                        if(isValidate)
                         { await  performLogin();
                          FocusScope.of(context).unfocus();}

                        },
                      ),
                    SizedBox(height: hSpaceLargevv,),
                    SizedBox(height: SizeConfig.scaleWidth(60),child:
                       loggedInWithGmail()),

                      SizedBox(
                        height: hSpaceLarge,
                      ),
                      SizedBox(height: SizeConfig.scaleWidth(60),child: loggedInWithApple()),
                    ],
                  ),
              ),
            ),
          ),
          ),


    );
  }
 Future performLogin() async {
   if (checkData()) {
     await login();
   }
 }

 bool checkData() {
   if (_phoneNumber.text.isNotEmpty  ) {
     return true;
   }
   Helper(context: context, message: AppLocalizations.of(context)!.pleaseEnterCorrectData, error: true);
   return false;
 }

 Future login() async {
   String?   firebase_token=await FirebaseMessaging.instance.getToken();

   bool loggedIn = await loginAndProfileController()
       .userRegisterController(context,firebase_token: firebase_token!, phone: _phoneNumber.text ,
     language: Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en", );


   if (loggedIn) {
     Navigator.pushReplacement(
         context,
         MaterialPageRoute(
         builder: (context) => CodeLoginScreen(phone: _phoneNumber.text,
           totalPrice: widget.totalPrice,
           id: widget.id,
           productQu: widget.productQu,
           productId: widget.productId,
           productName:widget.productName ,
           productImage:widget.productImage ,
           main: true,

     ),),);

   }

 }
}
