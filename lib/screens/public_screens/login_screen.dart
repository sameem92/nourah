import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/public_screens/forget_password_screen.dart';
import 'package:producer_family_app/screens/public_screens/map_screen.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

class LogInScreen extends StatefulWidget {
  bool driver;

  LogInScreen({this.driver = false});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late TextEditingController _password;
  late TextEditingController _email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _password = TextEditingController();
    _email = TextEditingController();
    _email.addListener(() => setState(() {}));
    _password.addListener(() => setState(() {}));
    Get.delete<CategoriesGetX>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite(context,
          title: AppLocalizations.of(context)!.signIn,
          onPressed: () {},
          main: true),
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.scaleWidth(30),
          right: SizeConfig.scaleWidth(30),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: SizeConfig.scaleHeight(170),
              ),
              StyleText(
                AppLocalizations.of(context)!.hellosigninfamily,
                textColor: kSpecialColor,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(50),
              ),
              StyleText(AppLocalizations.of(context)!.enterPassAndEmail),
              SizedBox(
                height: SizeConfig.scaleHeight(50),
              ),
              StyleField(
                title: AppLocalizations.of(context)!.register_family_email,
                controller: _email,
                prefixIcon: Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
                isRequired: true,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(20),
              ),
              StyleField(
                title: AppLocalizations.of(context)!.password,
                controller: _password,
                obscureText: true,
                prefixIcon: Icon(Icons.password_sharp),
                isRequired: true,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen(
                                driver: widget.driver,
                              ),
                            ));
                      },
                      child: StyleText(
                        AppLocalizations.of(context)!.forgetYourPassword,
                        textColor: kSpecialColor,
                      )),
                ],
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(30),
              ),
              StyleButton(
                AppLocalizations.of(context)!.signIn,
                onPressed: () async {
                  // bool isValidate = _formKey.currentState!.validate();
                  // if (isValidate) {
                  // print('login0');
                  await performLogin();
                  // FocusScope.of(context).unfocus();
                  // }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future performLogin() async {
    // print('login1');
    if (checkData()) {
      await login();
      // print('sasas');
    }
  }

  bool checkData() {
    // print('login2');
    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
      return true;
    } else {
      helper(
          context: context,
          message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
          error: true);
      return false;
    }
  }

  Future login() async {
    // print('login3');
    String? firebaseToken = await FirebaseMessaging.instance.getToken();

    bool loggedIn = await LoginAndProfileController().loginController(
      context,
      firebaseToken: firebaseToken!,
      loginType: widget.driver == true ? 'delivery' : 'family',
      email: _email.text,
      password: _password.text,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );

    if (loggedIn) {
      Get.delete(force: true);

      String fileName5 = "getProfileController.json";
      var dir5 = await getTemporaryDirectory();
      File file5 = new File(dir5.path + "/" + fileName5);
      if (file5.existsSync()) file5.deleteSync(recursive: true);
      widget.driver == true
          ? await SharedPreferencesController().saveLogiInDriver()
          : await SharedPreferencesController().saveLogiInFamily();
      widget.driver == true
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MapScreen(
                        driver: true,
                      )),
              (Route<dynamic> route) => false)
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MapScreen(
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
