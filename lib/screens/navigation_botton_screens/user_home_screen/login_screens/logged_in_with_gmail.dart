import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/provider_gmail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

class loggedInWithGmail extends StatefulWidget {
  @override
  State<loggedInWithGmail> createState() => _loggedInWithGmailState();
}

class _loggedInWithGmailState extends State<loggedInWithGmail> {
  // GoogleSignInAccount? _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

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
                  padding: EdgeInsets.all(4),
                  child: OutlineButton.icon(
                      label: StyleText(
                        AppLocalizations.of(context)!.signupwithgmail,
                      ),
                      shape: StadiumBorder(),
                      highlightedBorderColor: kSecondaryColor,
                      borderSide: BorderSide(
                        color: kSecondaryColor,
                      ),
                      textColor: kSecondaryColor,
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: kRefuse,
                        size: fIcon,
                      ),
                      onPressed: () async {
                         GoogleSignInAccount? _userObj = await _googleSignIn.signIn();


                        _googleSignIn.signIn().then((userData) {
                           setState(() {
                             _userObj = userData;
                           });


                        });
                        if (_userObj != null) {
                       String?   firebase_token=await FirebaseMessaging.instance.getToken();
                    await loginAndProfileController()
                              .userRegisterGoogleController(
                            context,
                            firebase_token:firebase_token! ,
                            language: Localizations.localeOf(context).languageCode=="ar"?"ar":"en",
                            email: _userObj!.email,
                          );
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
              child:  indicator_nourah_loading()  ),
        ],
      );
}
