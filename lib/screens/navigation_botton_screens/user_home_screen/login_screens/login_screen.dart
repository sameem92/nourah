import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/public_screens/map_screen.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../cart_screen.dart';
import 'code_login_screen.dart';
import 'logged_in_with_gmail.dart';

class LoginScreen extends StatefulWidget {
  final int userId;
  final int productQu;
  final bool back;
  final bool main;
  final IconData? icon;
  final IconData? iconBack;

  const LoginScreen(
      {this.productQu = 0,
      this.back = false,
      this.main = false,
      this.icon,
      this.iconBack = Icons.arrow_back,
      this.userId = 0});

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
    _phoneNumber.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.verifyfromaccount,
        onPressed: () {},
        back: widget.back,
        main: widget.main,
        icon: widget.icon,
        iconBack: widget.iconBack,
      ),
      body: GetX<GetNetworkGetx>(
          init: GetNetworkGetx(),
          builder: (GetNetworkGetx network) {
            return network.connectionType.value == 0
                ? Column(
                    children: [
                      noContent(
                          context, AppLocalizations.of(context)!.noInternet),
                      SizedBox(
                        height: SizeConfig.scaleHeight(30),
                      ),
                      StyleButton(AppLocalizations.of(context)!.refresh,
                          sideColor: kSpecialColor,
                          backgroundColor: kSpecialColor, onPressed: () async {
                        await network.refreshData();
                      })
                    ],
                  )
                : Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: wPadding,
                      end: wPadding,
                      top: hPadding,
                      bottom: hPadding,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Form(
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
                                color: kSpecialColor,
                              ),
                              StyleText(
                                AppLocalizations.of(context)!
                                    .explainverifyfromaccount,
                                maxLines: 5,
                                width: SizeConfig.scaleWidth(300),
                                height: 2,
                              ),
                              SizedBox(
                                height: hSpaceLargev,
                              ),
                              // SizedBox(
                              //   height: SizeConfig.scaleWidth(90),
                              //   child: StyleField(
                              //     title: AppLocalizations.of(context)!
                              //         .register_family_number,
                              //     suffixText: "00966",
                              //     padding: 0,
                              //     keyboardType: TextInputType.number,
                              //     isPhone: true,
                              //     isRequired: true,
                              //     controller: _phoneNumber,
                              //     prefixIcon:
                              //     Icon(Icons.phone_android_outlined),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: hSpaceLarge,
                              // ),
                              // StyleButton(
                              //   AppLocalizations.of(context)!.next,
                              //   onPressed: () async {
                              //     bool isValidate =
                              //     _formKey.currentState!.validate();
                              //     if (isValidate) {
                              //       await performLogin();
                              //       FocusScope.of(context).unfocus();
                              //     }
                              //   },
                              // ),
                              SizedBox(
                                height: hSpaceLargevv,
                              ),
                              SizedBox(
                                  height: SizeConfig.scaleWidth(60),
                                  child: LoggedInWithGmail(
                                    productQu: widget.productQu,
                                    userId: widget.userId,
                                  )),
                              SizedBox(
                                height: hSpaceLarge,
                              ),
                              if (Platform.isIOS)
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: SizeConfig.scaleWidth(360),
                                    height: SizeConfig.scaleWidth(50),

                                    padding: const EdgeInsets.all(4),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        {
                                          {
                                            // await FlutterSecureStorage().deleteAll();
                                            String fileName5 =
                                                "getProfileController.json";
                                            var dir5 =
                                                await getTemporaryDirectory();
                                            File file5 =
                                                File("${dir5.path}/$fileName5");
                                            if (file5.existsSync()) {
                                              file5.deleteSync(recursive: true);
                                            }

                                            final email =
                                                await const FlutterSecureStorage()
                                                    .read(key: "email");
                                            // print(email);
                                            if (email != null) {
                                              String? firebaseToken =
                                                  await FirebaseMessaging
                                                      .instance
                                                      .getToken();
                                              bool logIn =
                                                  await LoginAndProfileController()
                                                      .userRegisterGoogleController(
                                                context,
                                                firebaseToken: firebaseToken!,
                                                language:
                                                    Localizations.localeOf(
                                                                    context)
                                                                .languageCode ==
                                                            "ar"
                                                        ? "ar"
                                                        : "en",
                                                email: email,
                                                type: "apple",
                                                saveLoggedInUserAppleBool: true,
                                              );
                                              if (logIn == true) {
                                                // getProfileGetx controller =
                                                Get.put(getProfileGetx());
                                                widget.productQu == 0
                                                    ? Navigator.of(context)
                                                        .pushReplacement(
                                                            // context,
                                                            MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MapScreen(
                                                          user: true,
                                                        ),
                                                      ))
                                                    : Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CartScreen(
                                                            userId:
                                                                widget.userId,
                                                          ),
                                                        ));
                                              }
                                            } else {
                                              logInApple();
                                            }
                                          }
                                        }
                                      },
                                      child: FittedBox(
                                        child: Row(
                                          children: [


                                            StyleText(
                                              // AppLocalizations.of(context)!
                                              //     .signupwithapple,
                                              "Sign in with Apple",
                                              textColor: Colors.grey.shade700,
                                              fontSize: 20,
                                            ),
                                            SizedBox(
                                              width: wSpace,
                                            ),
                                            FaIcon(
                                              FontAwesomeIcons.apple,
                                              color: Colors.grey.shade600,
                                              size: fIcon,
                                            ),
                                          ],
                                        ),
                                        // child: StyleText(
                                        //   AppLocalizations.of(context)!.signupwithgmail,
                                        //   textColor:
                                        //   kSpecialColor,
                                        //   fontSize: 20,
                                        //
                                        // ),
                                      ),
                                      autofocus: true,
                                      style: TextButton.styleFrom(
                                        primary: kSpecialColor,
                                        backgroundColor: kBackgroundColor,
                                        elevation: SizeConfig.scaleHeight(1),
                                        onSurface:
                                            kSpecialColor.withOpacity(0.38),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                          borderRadius,
                                        )),
                                        side: BorderSide(
                                          color: kSpecialColor,
                                          width: 0,
                                        ),
                                      ),
                                    ),

//                                 StyleButton(
//                                   AppLocalizations.of(context)!
//                                             .signupwithapple,
//                                     textColor:kGrey ,
// sideColor: kGrey,
// backgroundColor: kBackgroundColor,
//                                 onPressed: ()async{
//                                   {
//                                     // await FlutterSecureStorage().deleteAll();
//                                     String fileName5 =
//                                         "getProfileController.json";
//                                     var dir5 =
//                                         await getTemporaryDirectory();
//                                     File file5 = new File(
//                                         dir5.path + "/" + fileName5);
//                                     if (file5.existsSync())
//                                       file5.deleteSync(recursive: true);
//
//                                     final email =
//                                         await FlutterSecureStorage()
//                                         .read(key: "email");
//                                     print(email);
//                                     if (email != null) {
//                                       String? firebaseToken =
//                                           await FirebaseMessaging.instance
//                                           .getToken();
//                                       bool logIn = await loginAndProfileController()
//                                           .userRegisterGoogleController(
//                                         context,
//                                         firebase_token: firebaseToken!,
//                                         language: Localizations
//                                             .localeOf(
//                                             context)
//                                             .languageCode ==
//                                             "ar"
//                                             ? "ar"
//                                             : "en",
//                                         email: email,
//                                         type: "apple",
//                                         saveLoggedInUserAppleBool: true,
//
//                                       );
//                                       if (logIn == true ) {
//                                         getProfileGetx controller =
//                                         Get.put(getProfileGetx());
//                                         widget.productQu == 0
//                                             ? Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   MapScreen(
//                                                     user: true,
//                                                   ),
//                                             ))
//                                             : Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   CartScreen(
//                                                     userId: widget.userId,
//                                                   ),
//                                             ));
//                                       }
//                                     }else {
//                                       logInApple();
//                                     }
//                                   }
//                                 },),

                                    // ElevatedButton.icon(
                                    //     label: StyleText(
                                    //       AppLocalizations.of(context)!
                                    //           .signupwithapple,
                                    //       textColor:kSpecialColor ,
                                    //
                                    //     ),
                                    //
                                    //
                                    //     // shape: StadiumBorder(),
                                    //     // highlightedBorderColor: kSpecialColor,
                                    //     // borderSide: BorderSide(
                                    //     //   color: kSpecialColor,
                                    //     // ),
                                    //     // textColor: kSpecialColor,
                                    //     icon: FaIcon(
                                    //       FontAwesomeIcons.apple,
                                    //       color: Colors.grey,
                                    //       size: fIcon,
                                    //     ),
                                    //
                                    //     onPressed: () async {
                                    //       // await FlutterSecureStorage().deleteAll();
                                    //       String fileName5 =
                                    //           "getProfileController.json";
                                    //       var dir5 =
                                    //       await getTemporaryDirectory();
                                    //       File file5 = new File(
                                    //           dir5.path + "/" + fileName5);
                                    //       if (file5.existsSync())
                                    //         file5.deleteSync(recursive: true);
                                    //
                                    //       final email =
                                    //       await FlutterSecureStorage()
                                    //           .read(key: "email");
                                    //       print(email);
                                    //       if (email != null) {
                                    //         String? firebaseToken =
                                    //         await FirebaseMessaging.instance
                                    //             .getToken();
                                    //         bool logIn = await loginAndProfileController()
                                    //             .userRegisterGoogleController(
                                    //           context,
                                    //           firebase_token: firebaseToken!,
                                    //           language: Localizations
                                    //               .localeOf(
                                    //               context)
                                    //               .languageCode ==
                                    //               "ar"
                                    //               ? "ar"
                                    //               : "en",
                                    //           email: email,
                                    //           type: "apple",
                                    //           saveLoggedInUserAppleBool: true,
                                    //
                                    //         );
                                    //         if (logIn == true ) {
                                    //           getProfileGetx controller =
                                    //           Get.put(getProfileGetx());
                                    //           widget.productQu == 0
                                    //               ? Navigator.pushReplacement(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     MapScreen(
                                    //                       user: true,
                                    //                     ),
                                    //               ))
                                    //               : Navigator.pushReplacement(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     CartScreen(
                                    //                       userId: widget.userId,
                                    //                     ),
                                    //               ));
                                    //         }
                                    //       }else {
                                    //         logInApple();
                                    //       }
                                    //     }),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }

  Future performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_phoneNumber.text.isNotEmpty) {
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

    bool loggedIn = await LoginAndProfileController().userRegisterController(
      context,
      firebaseToken: firebaseToken!,
      phone: _phoneNumber.text,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );

    if (loggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CodeLoginScreen(
            phone: _phoneNumber.text,
            userId: widget.userId,
            main: false,
            productQu: widget.productQu,
          ),
        ),
      );
    }
  }

  void logInApple() async {
    final AuthorizationResult result = await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    // final result = await SignInWithApple.getAppleIDCredential(
    //   scopes: [
    //     AppleIDAuthorizationScopes.email,
    //     AppleIDAuthorizationScopes.fullName,
    //   ],
    // );

    await const FlutterSecureStorage().write(key: "email", value: result.credential!.email);

    final email = await const FlutterSecureStorage().read(key: "email");

    // print("email${result.credential!.email}");
    String? firebaseToken = await FirebaseMessaging.instance.getToken();
    bool logIn = await LoginAndProfileController().userRegisterGoogleController(
      context,
      type: "apple",
      firebaseToken: firebaseToken!,
      saveLoggedInUserAppleBool: true,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      email: email,
    );
    // print("logIn $logIn");
    if (logIn == true && result.credential!.email != null) {
      getProfileGetx controller = Get.put(getProfileGetx());
      await controller.updateNameProfile(
        name: "${result.credential!.fullName!.givenName ?? ""} ${result.credential!.fullName!.familyName ?? ""}",
        context: context,
      );

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
              ));
    }
  }
}
