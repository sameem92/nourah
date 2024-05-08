import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

import 'map_screen.dart';

class RecreatePasswordScreen extends StatefulWidget {
  final bool driver;
  final String email;
  const RecreatePasswordScreen({required this.email, this.driver = false});
  @override
  _RecreatePasswordScreenState createState() => _RecreatePasswordScreenState();
}

class _RecreatePasswordScreenState extends State<RecreatePasswordScreen> {
  late TextEditingController _code;
  late TextEditingController _password;
  late TextEditingController _confirmPassword;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // managenotificationAction(context);
    _code = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _code.addListener(() => setState(() {}));

    _password.addListener(() => setState(() {}));

    _confirmPassword.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _code.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.rewritepassswordtitle,
        onPressed: () {},
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.scaleHeight(150),
                    ),
                    StyleText(
                      AppLocalizations.of(context)!.rewritepassswordtitle,
                      textColor: kSpecialColor,
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(40),
                    ),
                    StyleField(
                      title: AppLocalizations.of(context)!.codefromemail,
                      controller: _code,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: hSpaceLarge,
                    ),
                    StyleField(
                      title: AppLocalizations.of(context)!.password,
                      controller: _password,
                      obscureText: true,
                      isRequired: true,
                      prefixIcon: const Icon(Icons.password_sharp),
                    ),
                    SizedBox(
                      height: hSpaceLarge,
                    ),
                    StyleField(
                      title: AppLocalizations.of(context)!.rewritepasssword,
                      controller: _confirmPassword,
                      obscureText: true,
                      isRequired: true,
                      prefixIcon: const Icon(Icons.password_sharp),
                    ),
                    SizedBox(
                      height: hSpaceLargevv,
                    ),
                    StyleButton(
                      AppLocalizations.of(context)!.signIn,
                      onPressed: () async {
                        bool isValidate = _formKey.currentState!.validate();
                        if (isValidate) {
                          await performResetPassword();
                        }
                      },
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future performResetPassword() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    if (widget.email.isNotEmpty &&
        _password.text == _confirmPassword.text &&
        _code.text.isNotEmpty) {
      return true;
    }
    helper(context: context, message: "تأكد من البيانات", error: true);
    return false;
  }

  Future resetPassword() async {
    bool resetIt = await LoginAndProfileController().activeCodeController(
      context,
      email: widget.email,
      code: _code.text,
      password: _password.text,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );
    if (resetIt) {
      await FirebaseMessaging.instance.getToken();

      String fileName5 = "getProfileController.json";
      var dir5 = await getTemporaryDirectory();
      File file5 = File("${dir5.path}/$fileName5");
      if (file5.existsSync()) file5.deleteSync(recursive: true);
      widget.driver == true
          ? await SharedPreferencesController().saveLogiInDriver()
          : await SharedPreferencesController().saveLogiInFamily();
      widget.driver == true
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const MapScreen(
                        driver: true,
                      )),
              (Route<dynamic> route) => false)
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const MapScreen(
                        family: true,
                      )),
              (Route<dynamic> route) => false);
      // print(
      //     "saveLogiInDriver::${SharedPreferencesController().isLoggedInDriver}");
      // print(
      //     "saveLogiInFamily::${SharedPreferencesController().isLoggedInFamily}");
    }
  }
}
