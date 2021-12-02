import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/cart_screen.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CodeLoginScreen extends StatefulWidget {
  String id;
  int totalPrice;
  int productId;
  int productQu;
  String productName;
  String productImage;
  final String? phone;
  bool back;
  bool main;
  IconData? icon;
  IconData? iconBack;

  CodeLoginScreen(
      {required this.phone,
      this.id = "",
      this.back = false,
      this.main = false,
      this.icon = null,
      this.iconBack = Icons.arrow_back,
      this.productName = "",
      this.productImage = "",
      this.totalPrice = 0,
      this.productId = 0,
      this.productQu = 0});

  @override
  _CodeLoginScreenState createState() => _CodeLoginScreenState();
}

class _CodeLoginScreenState extends State<CodeLoginScreen> {
  late TextEditingController _codeNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    _codeNumber = TextEditingController();
    _codeNumber.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _codeNumber.dispose();
    timer!.cancel();

    startTimer();
    startTimerAgain();
  }

  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          seconds--;
        });
        if (seconds == 0) timer!.cancel();
      }
    });
  }

  void startTimerAgain() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          seconds--;
        });
        if (seconds == 0) timer!.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWhite(
        context,
        back: widget.back,
        main: widget.main,
        icon: widget.icon,
        iconBack: widget.iconBack,
        title: AppLocalizations.of(context)!.verifyfromaccount,
        onPressed: () {},
      ),
      body: Padding(
        padding: EdgeInsets.all(
          SizeConfig.scaleHeight(10),
        ),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: hSpace,
                ),
                Icon(
                  Icons.perm_contact_calendar,
                  size: SizeConfig.scaleHeight(200),
                  color: kSecondaryColor,
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(30),
                ),
                StyleText(
                  AppLocalizations.of(context)!.pleaseenterthesendcode,
                  maxLines: 2,
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(100),
                ),
                StyleField(
                  title: AppLocalizations.of(context)!.codenumber,
                  controller: _codeNumber,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(Icons.code),
                ),
                SizedBox(
                  height: hSpaceLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          String? firebase_token =
                              await FirebaseMessaging.instance.getToken();

                          if (seconds == 0) {
                            bool sendAgain = await loginAndProfileController()
                                .userRegisterController(
                              context,
                              firebase_token: firebase_token!,
                              phone: "${widget.phone}",
                              language: Localizations.localeOf(context)
                                          .languageCode ==
                                      "ar"
                                  ? "ar"
                                  : "en",
                            );

                            if (sendAgain) {
                              if (mounted) {
                                setState(() {
                                  seconds = 100;
                                });
                                startTimerAgain();
                              }
                            }
                          } else {
                            null;
                          }
                        },
                        child: StyleText(
                          AppLocalizations.of(context)!
                              .sendTheVerificationCodeAgain,
                          textColor: seconds == 0 ? kConfirm : kSecondaryColor,
                        )),
                    StyleText(
                      "    ( ${seconds}:0 )",
                      textColor: kSecondaryColor,
                      maxLines: 2,
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(100),
                ),
                StyleButton(
                  AppLocalizations.of(context)!.verifyfromaccount,
                  width: SizeConfig.scaleWidth(230),
                  onPressed: () async {
                    await performCode();
                    FocusScope.of(context).unfocus();
                    timer!.cancel();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future performCode() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_codeNumber.text.isNotEmpty) {
      return true;
    }
    Helper(
        context: context,
        message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
        error: true);
    return false;
  }

  Future login() async {
    String? firebase_token = await FirebaseMessaging.instance.getToken();

    bool status = await loginAndProfileController().activeCodeUserController(
      phone: widget.phone!,
      code: _codeNumber.text,
      firebase_token: firebase_token!,
      context: context,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );
    if (status) {
      await SharedPreferencesController().saveLoggedInUser();
      widget.totalPrice == 0 && widget.productQu == 0
          ? Navigator.pushNamedAndRemoveUntil(
              context, "/mainScreen", (Route<dynamic> route) => false)
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(
                  totalPrice: widget.totalPrice,
                  id: widget.id,
                  productQu: widget.productQu,
                  productId: widget.productId,
                  productName: widget.productName,
                  productImage: widget.productImage,
                ),
              ),
            );
    }
  }
}
