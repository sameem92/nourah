import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/cart_screen.dart';
import 'package:producer_family_app/screens/public_screens/map_screen.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/provider_gmail.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

class LoggedInWithGmail extends StatefulWidget {
  final int userId;
  final int productQu;
  const LoggedInWithGmail({
    this.userId = 0,
    this.productQu = 0,
  });
  @override
  State<LoggedInWithGmail> createState() => _LoggedInWithGmailState();
}

class _LoggedInWithGmailState extends State<LoggedInWithGmail> {
  final _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);

            if (provider.isSigningIn) {
              return buildLoading();
            } else {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  width: SizeConfig.scaleWidth(360),
                  height: SizeConfig.scaleWidth(50),
                  padding: const EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () async {
                      {
                        {
                          String fileName5 = "getProfileController.json";
                          var dir5 = await getTemporaryDirectory();
                          File file5 = File("${dir5.path}/$fileName5");
                          if (file5.existsSync()) {
                            file5.deleteSync(recursive: true);
                          }

                          GoogleSignInAccount? userObj =
                              await _googleSignIn.signIn();
                          _googleSignIn.signIn().then((userData) {
                            setState(() {
                              userObj = userData;
                            });
                          });
                          if (userObj != null) {
                            String? firebaseToken =
                                await FirebaseMessaging.instance.getToken();

                            // print("firebaseToken $firebaseToken");
                            bool logIn = await LoginAndProfileController()
                                .userRegisterGoogleController(
                              context,
                              type: "google",
                              saveLoggedInUserGoogleBool: true,
                              firebaseToken: firebaseToken!,
                              language: Localizations.localeOf(context)
                                          .languageCode ==
                                      "ar"
                                  ? "ar"
                                  : "en",
                              email: userObj!.email,
                            );
                            if (logIn == true && userObj != null) {
                              getProfileGetx controller =
                                  Get.put(getProfileGetx());
                              await controller.updateNameProfile(
                                name: userObj!.displayName ?? "",
                                context: context,
                              );
                              widget.productQu == 0
                                  ? Navigator.of(context).pushReplacement(
                                      // context,
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
                            } else {
                              _googleSignIn.signOut();
                            }
                          }
                        }
                      }
                    },
                    child: FittedBox(
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.google,
                            color: kRefuse,
                            size: fIcon,
                          ),
                          SizedBox(
                            width: wSpace,
                          ),
                          StyleText(
                            AppLocalizations.of(context)!.signupwithgmail,
                            textColor: kSpecialColor,
                            fontSize: 20,
                          ),
                        ],
                      ),
                    ),
                    autofocus: true,
                    style: TextButton.styleFrom(
                      backgroundColor: kBackgroundColor,
                      elevation: SizeConfig.scaleHeight(1),
                      primary: kSpecialColor,
                      onSurface: kSpecialColor,
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
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: indicatorNourahLoading()),
        ],
      );
}
