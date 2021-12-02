import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/provider_gmail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

class loggedInWithApple extends StatefulWidget {
  @override
  State<loggedInWithApple> createState() => _loggedInWithAppleState();
}

class _loggedInWithAppleState extends State<loggedInWithApple> {

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
            }
            // else if (snapshot.hasData) {
            //   return LoggedInWidget();
            // }

            else {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  width: SizeConfig.scaleWidth(360),
                  height: SizeConfig.scaleWidth(50),
                  padding: EdgeInsets.all(4),
                  child: OutlineButton.icon(
                      label: StyleText(
                        AppLocalizations.of(context)!.signupwithapple,
                      ),
                      shape: StadiumBorder(),
                      highlightedBorderColor: kSecondaryColor,
                      borderSide: BorderSide(
                        color: kSecondaryColor,
                      ),
                      textColor: kSecondaryColor,
                      icon: FaIcon(
                        FontAwesomeIcons.apple,
                        color: Colors.grey,
                        size: fIcon,
                      ),
                      onPressed: () async {
                        String?   firebase_token=await FirebaseMessaging.instance.getToken();

                        bool loggedIn = await loginAndProfileController()
                            .userRegisterGoogleController(
                          context,
                          firebase_token: firebase_token!,
                          email: "mohamedabdelateef25250@gmail.com",
                        );

                        if (loggedIn) {

                              await SharedPreferencesController()
                                  .saveLoggedInUser();

                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/mainScreen",
                                  (Route<dynamic> route) => false);

                        }
                      }),
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
          Center(
              child: indicator_nourah_loading()   ),
        ],
      );
}
