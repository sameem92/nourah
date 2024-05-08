import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/public_screens/recreate_password_screen.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final bool driver;
  const ForgetPasswordScreen({this.driver = false});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // managenotificationAction(context);
    _email = TextEditingController();
    _email.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // managenotificationAction(context);

    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.recoveryyourpassword,
        onPressed: () {},
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.scaleWidth(30),
          right: SizeConfig.scaleWidth(30),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: wPadding,
            end: wPadding,
            top: hPadding,
            bottom: hPadding,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.scaleHeight(170),
                    ),
                    StyleText(
                      AppLocalizations.of(context)!.forgetYourPassword,
                      textColor: kSpecialColor,
                    ),
                    SizedBox(
                      height: hSpaceLarge,
                    ),
                    StyleText(
                      AppLocalizations.of(context)!.enterEmail,
                    ),
                    SizedBox(
                      height: hSpaceLargevv,
                    ),
                    StyleField(
                      title:
                          AppLocalizations.of(context)!.register_family_email,
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined),
                      isRequired: true,
                      isEmail: true,
                    ),
                    SizedBox(
                      height: hSpaceLargevv,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StyleButton(AppLocalizations.of(context)!.send,
                            onPressed: () async {
                          bool isValidate = _formKey.currentState!.validate();
                          if (isValidate) {
                            await performForgetPassword();
                          }
                        }),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(50),
                    ),
                    StyleText(
                      AppLocalizations.of(context)!
                          .pleasecheckyouremailtogetthecode,
                      maxLines: 4,
                      height: 1.8,
                      textColor: kSpecialColor,
                      letterSpacing: SizeConfig.scaleWidth(4),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future performForgetPassword() async {
    if (checkData()) {
      sendCode();
    }
  }

  bool checkData() {
    if (_email.text.isNotEmpty) {
      return true;
    }
    helper(
        context: context,
        message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
        error: true);
    return false;
  }

  Future sendCode() async {
    bool status = await LoginAndProfileController().forgetpasswordController(
      context,
      email: _email.text,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );

    if (status) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => RecreatePasswordScreen(
                  email: _email.text,
                  driver: widget.driver,
                )),
      );
    }
  }
}
