import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:producer_family_app/components/list_tile_profile.dart';
import 'package:producer_family_app/screens/public_screens/splash.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  bool user;
  bool driver;
  bool family;

  ProfileScreen({this.user = false, this.family = false, this.driver = false});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoggedInUser = false;
  bool isLoggedInDriver = false;
  bool isLoggedInUserFamily = false;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  final googleSignIn = GoogleSignIn();

  bool _language = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedInUser = SharedPreferencesController().isLoggedInUser;
    isLoggedInDriver = SharedPreferencesController().isLoggedInDriver;
    isLoggedInUserFamily = SharedPreferencesController().isLoggedInFamily;
  }

  getProfileGetx controller = Get.put(getProfileGetx());
  getFamilyPolicyGetx controller2 = Get.put(getFamilyPolicyGetx());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: wPadding,
        right: wPadding,
        top: widget.family == false ? SizeConfig.scaleHeight(55) : hPadding,
        bottom: hPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.family == true)
              ListTileInfo(context,
                  title: AppLocalizations.of(context)!.familyInfo,
                  icon2: Icons.family_restroom, onTap: () {
                Navigator.pushNamed(context, "/infoProfileFamily");
              }),
            if (widget.family == true) divider_app(height: 0),
            if (widget.family == true)
              ListTileInfo(context,
                  title: AppLocalizations.of(context)!.addPolicies,
                  icon2: Icons.local_police_rounded, onTap: () {
                Navigator.pushNamed(context, "/addPolicies");
              }),
            if (widget.driver == true)
              ListTileInfo(context,
                  title: AppLocalizations.of(context)!.infoTitle,
                  icon2: Icons.person, onTap: () {
                Navigator.pushNamed(context, "/infoProfileDriver");
              }),
            if (widget.user == true)
              if (isLoggedInUser == true)
                ListTileInfo(context,
                    title: AppLocalizations.of(context)!.myprofile,
                    icon2: Icons.person_outline, onTap: () {
                  Navigator.pushNamed(context, '/infoProfileUser');
                }),
            if (widget.user == true)
              if (isLoggedInUser == false)
                ListTileInfo(context,
                    title: AppLocalizations.of(context)!.logIn,
                    icon2: Icons.login, onTap: () {
                  Navigator.pushNamed(context, '/loginScreen');
                }),
            divider_app(height: 0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: StyleText(
                    'عربي',
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SwitchListTile(
                      activeColor: Colors.grey,
                      contentPadding: EdgeInsets.all(0),
                      value: _language,
                      onChanged: (
                        bool newValue,
                      ) async {
                        String languageCode =
                            Localizations.localeOf(context).languageCode;
                        if (languageCode == 'ar') {
                          Provider.of<LanguageChangeNotifer>(context,
                                  listen: false)
                              .changeLanguage('en');
                          await SharedPreferencesController()
                              .changeLanguage("en");

                          setState(() {
                            _language = newValue;
                          });
                        } else {
                          Provider.of<LanguageChangeNotifer>(context,
                                  listen: false)
                              .changeLanguage('ar');
                          await SharedPreferencesController()
                              .changeLanguage("ar");

                          setState(() {
                            _language = newValue;
                          });
                        };
                      }),
                ),
                Expanded(
                  flex: 2,
                  child: StyleText(
                    'English',
                  ),
                ),
              ],
            ),
            divider_app(height: 0),
            ListTileInfo(context,
                title: AppLocalizations.of(context)!.faq,
                icon2: Icons.question_answer_outlined, onTap: () {
              Navigator.pushNamed(context, '/faqScreen');
            }),
            divider_app(height: 0),
            ListTileInfo(context,
                title: AppLocalizations.of(context)!.share,
                icon2: Icons.share, onTap: () {
              final String url =
                  "http//path your app on google play or app store ";
              // final RenderBox box =context.findRenderObject();
              Share.share(
                url,
              );

              // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
            }
                // ),
                ),
            divider_app(height: 0),
            ListTileInfo(context,
                title: AppLocalizations.of(context)!.rateApp,
                icon2: Icons.star_rate_outlined, onTap: () {
              const _url = 'https://googlePlay.com';
              // launchURL(_url);
            }),
            divider_app(height: 0),
            ListTileInfo(
              context,
              title: AppLocalizations.of(context)!.contactWithUs,
              icon2: Icons.chat_outlined,
              icon1: null,
              onTap: () {
                // Navigator.pushNamed(context,);
              },
              widget: Column(
                children: [
                  SizedBox(
                    height: hSpaceSmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: hSpaceLargevv,
                        child: GetX<getSocialGetx>(
                            init: getSocialGetx(),
                            builder: (getSocialGetx controller) {
                              return controller.isLoading.value
                                  ? Center(child: indicator_nourah_loading())
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: controller.socials.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    // launchURL(controller.socials[index].link);
                                                  },
                                                  child: image_circle(
                                                    imageString: controller
                                                        .socials[index].icon,
                                                    radius: 40,
                                                  ))
                                            ]);
                                      });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: hSpaceSmall,
            ),
            divider_app(height: 0),
            ListTileInfo(context,
                title: AppLocalizations.of(context)!.emailUs,
                icon2: Icons.attach_email_outlined, onTap: () {
              openEmail();
            }),
            divider_app(height: 0),
            ListTileInfo(context,
                title: AppLocalizations.of(context)!.termsandcondions,
                icon2: Icons.local_police_outlined, onTap: () {
              Navigator.pushNamed(context, '/termsScreen');
            }),
            divider_app(height: 0),
            ListTileInfo(context,
                title: AppLocalizations.of(context)!.info,
                icon2: Icons.info_outline, onTap: () {
              Navigator.pushNamed(context, '/infoScreen');
            }),
            if (isLoggedInUser == true && widget.user == true)
              divider_app(height: 0),
            if (isLoggedInUser == true && widget.user == true)
              ListTileInfo(context,
                  title: AppLocalizations.of(context)!.logout,
                  icon2: Icons.logout, onTap: () async {
                await logout();
              }, icon1: null),
            if (widget.user == true)
              if (isLoggedInUser == false) divider_app(height: 0),
            if (widget.user == true)
              if (isLoggedInUser == false)
                ListTileInfo(
                  context,
                  title: AppLocalizations.of(context)!.signupfamily,
                  icon2: Icons.family_restroom,
                  onTap: () {
                    Navigator.pushNamed(context, '/registrationFamilyScreen');
                  },
                ),
            if (widget.user == true)
              if (isLoggedInUser == false) divider_app(height: 0),
            if (widget.user == true)
              if (isLoggedInUser == false)
                ListTileInfo(
                  context,
                  title: AppLocalizations.of(context)!.signupdriver,
                  onTap: () {
                    Navigator.pushNamed(context, '/registrationDeliveryScreen');
                  },
                  icon2: Icons.delivery_dining,
                ),
            if (widget.driver == true || widget.family == true)
              divider_app(height: 0),
            if (widget.driver == true || widget.family == true)
              ListTileInfo(
                context,
                title: AppLocalizations.of(context)!.logout,
                icon2: Icons.logout,
                onTap: () async {
                  await logout();
                },
              ),
          ],
        ),
      ),
    );
  }

  Future logout() async {
    bool loggeOut = await loginAndProfileController().logoutController(context,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en");
    if (loggeOut) {
      await SharedPreferencesController().logout();
      if (SharedPreferencesController().isLoggedInUserGoogle) {
        await googleSignIn.disconnect();

        _googleSignIn.signOut().then((value) {
          setState(() {
            Navigator.pushReplacementNamed(
              context,
              "/mapScreen",
            );
          });
        });
      }
      Navigator.pushReplacementNamed(
        context,
        "/mapScreen",
      );
    }
  }

  static Future openEmail() async {
    String toEmail = 'protech.co.2019@gmail.com';
    String subject = 'استفسار بخصوص ...';
    String body =
        'اسمي كمستخدم:(        )      ، مرحبا نورة أود الاستفسار عن ...';

    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("No email client found");
    }
  }
}
