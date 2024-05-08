import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/cart_screen.dart';
import 'package:producer_family_app/screens/public_screens/map_screen.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

class CodeLoginScreen extends StatefulWidget {
  final int userId;
  final int productQu;
  final String? phone;
  final bool back;
  final bool main;
  final IconData? icon;
  final IconData? iconBack;

  const CodeLoginScreen({
    required this.phone,
    this.userId = 0,
    this.back = false,
    this.main = false,
    this.productQu = 0,
    this.icon,
    this.iconBack = Icons.arrow_back,
  });

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
    _codeNumber.dispose();
    timer!.cancel();

    startTimer();
    startTimerAgain();
    super.dispose();
  }

  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          seconds--;
        });
        if (seconds == 0) timer!.cancel();
      }
    });
  }

  void startTimerAgain() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
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
      appBar: appBarWhite(
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
                  color: kSpecialColor,
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
                  prefixIcon: const Icon(Icons.code),
                ),
                SizedBox(
                  height: hSpaceLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          String? firebaseToken =
                              await FirebaseMessaging.instance.getToken();

                          if (seconds == 0) {
                            bool sendAgain = await LoginAndProfileController()
                                .userRegisterController(
                              context,
                              firebaseToken: firebaseToken!,
                              phone: widget.phone,
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
                          textColor: seconds == 0 ? kConfirm : kSpecialColor,
                        )),
                    StyleText(
                      "    ( $seconds:0 )",
                      textColor: kSpecialColor,
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
    helper(
        context: context,
        message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
        error: true);
    return false;
  }

  Future login() async {
    String? firebaseToken = await FirebaseMessaging.instance.getToken();

    bool status = await LoginAndProfileController().activeCodeUserController(
      phone: widget.phone!,
      code: _codeNumber.text,
      firebaseToken: firebaseToken!,
      context: context,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );
    if (status) {
      String fileName5 = "getProfileController.json";
      var dir5 = await getTemporaryDirectory();
      File file5 = File("${dir5.path}/$fileName5");
      if (file5.existsSync()) file5.deleteSync(recursive: true);

      // getProfileGetx controller = Get.put(getProfileGetx());

      await SharedPreferencesController().saveLoggedInUser();
      widget.productQu == 0
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MapScreen(
                  user: true,
                ),
              ))
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(
                  userId: widget.userId,
                ),
              ),
            );
    }
  }
}
