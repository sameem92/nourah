import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/components/list_tile_profile.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/show_dialoge.dart';
import '../../storage/providersAndGetx/home_getx.dart';
import '../navigation_botton_screens/user_home_screen/show/family_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool user;
  final bool driver;
  final bool family;

  const ProfileScreen(
      {this.user = false, this.family = false, this.driver = false});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoggedInUser = false;
  bool isLoggedInDriver = false;
  bool isLoggedInUserFamily = false;
  final _googleSignIn = GoogleSignIn();
  final googleSignIn = GoogleSignIn();

  bool _language = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    managenotificationAction(context);
    // if (widget.family == true) {
    //   getProfileGetx cont = Get.put(getProfileGetx());
    //   Get.put(GetShowFamilyGetX(id: cont.profile['id']));
    // }
    isLoggedInUser = SharedPreferencesController().isLoggedInUser;
    isLoggedInDriver = SharedPreferencesController().isLoggedInDriver;
    isLoggedInUserFamily = SharedPreferencesController().isLoggedInFamily;
    if (SharedPreferencesController().isLoggedInFamily == true ||
        SharedPreferencesController().isLoggedInDriver == true ||
        SharedPreferencesController().isLoggedInUser == true) {
      Get.put(getProfileGetx());
    } else {
      // print('no profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: wPadding,
        right: wPadding,
        top: widget.family == false ? SizeConfig.scaleHeight(55) : hPadding,
        bottom: hPadding,
      ),
      child: GetX<GetNetworkGetx>(
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
                : Column(
                    children: [
                      if (widget.family == true)
                        Expanded(
                          flex: 4,
                          child: listTileInfo(context,
                              title: AppLocalizations.of(context)!.familyInfo,
                              icon2: Icons.family_restroom, onTap: () {
                            Navigator.pushNamed(context, "/infoProfileFamily");
                          }),
                        ),
                      if (widget.family == true)
                        Expanded(
                          flex: 4,
                          child: listTileInfo(context,
                              title: AppLocalizations.of(context)!
                                  .asMustomersMeeMe,
                              icon2: Icons.family_restroom, onTap: () {
                            if (SharedPreferencesController()
                                    .isLoggedInFamily ==
                                true) {
                              getProfileGetx cont = Get.put(getProfileGetx());
                              cont.profile['id'];
                              Get.put(
                                  GetShowFamilyGetX(id: cont.profile['id']));
                              // print(cont.profile['id']);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FamilyProfileScreen(
                                          userId: cont.profile['id'],
                                          justShow: true,
                                        )),
                              );
                            }
                          }),
                        ),
                      if (widget.family == true)
                        Expanded(
                          flex: 4,
                          child: listTileInfo(context,
                              title: AppLocalizations.of(context)!.addPolicies,
                              icon2: Icons.local_police_rounded, onTap: () {
                            Navigator.pushNamed(context, "/addPolicies");
                          }),
                        ),
                      if (widget.driver == true)
                        Expanded(
                          flex: 4,
                          child: listTileInfo(context,
                              title: AppLocalizations.of(context)!.infoTitle,
                              icon2: Icons.person, onTap: () {
                            Navigator.pushNamed(context, "/infoProfileDriver");
                          }),
                        ),
                      if (widget.user == true)
                        if (isLoggedInUser == true)
                          Expanded(
                            flex: 4,
                            child: listTileInfo(context,
                                title: AppLocalizations.of(context)!.myprofile,
                                icon2: Icons.person_outline, onTap: () {
                              Navigator.pushNamed(context, '/infoProfileUser');
                            }),
                          ),
                      if (widget.user == true)
                        if (isLoggedInUser == false)
                          Expanded(
                            flex: 4,
                            child: listTileInfo(context,
                                title: AppLocalizations.of(context)!.logIn,
                                icon2: Icons.login, onTap: () {
                              Navigator.pushNamed(context, '/loginScreen');
                            }),
                          ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Expanded(
                              flex: 2,
                              child: StyleText(
                                'عربي',
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SwitchListTile(
                                  dense: true,
                                  activeColor: kSpecialColor,
                                  contentPadding: const EdgeInsets.all(0),
                                  value: _language,
                                  onChanged: (
                                    bool newValue,
                                  ) async {
                                    String languageCode =
                                        Localizations.localeOf(context)
                                            .languageCode;
                                    if (languageCode == 'ar') {
                                      Provider.of<LanguageChangeNotifer>(
                                              context,
                                              listen: false)
                                          .changeLanguage('en');
                                      await SharedPreferencesController()
                                          .changeLanguage("en");

                                      if (!mounted) {
                                      } else {
                                        setState(() {
                                          _language = newValue;
                                        });
                                      }
                                    } else {
                                      Provider.of<LanguageChangeNotifer>(
                                              context,
                                              listen: false)
                                          .changeLanguage('ar');
                                      await SharedPreferencesController()
                                          .changeLanguage("ar");

                                      if (!mounted) {
                                      } else {
                                        setState(() {
                                          _language = newValue;
                                        });
                                      }
                                    }
                                  }),
                            ),
                            const Expanded(
                              flex: 2,
                              child: StyleText(
                                'English',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: dividerApp(height: 0),
                      ),
                      Expanded(
                        flex: 4,
                        child: listTileInfo(context,
                            title: AppLocalizations.of(context)!.faq,
                            icon2: Icons.question_answer_outlined,
                            onTap: () async {
                          Navigator.pushNamed(context, '/faqScreen');
                          // String?   firebase_token=await FirebaseMessaging.instance.getToken();
// print(firebase_token);
//
//                           showSimpleNotification(
//                           Text("this is a message from simple notification"),
//                           background: kSecondaryColor);
                        }),
                      ),
                      Expanded(
                        flex: 4,
                        child: listTileInfo(context,
                            title: AppLocalizations.of(context)!.share,
                            icon2: Icons.share, onTap: () {
                          // Helper(
                          //     context: context,
                          //     message:"Thank you for sharing" ,
                          //     error: true);
                          final String url = 'https://onelink.to/fvq7gq';
                          // Platform.isIOS?"https://apps.apple.com/il/app/nourah-%D9%86%D9%88%D8%B1%D9%87/id1604129474" :
                          // "https://play.google.com/store/apps/details?id=com.nourah.producer_family_app";
                          // final RenderBox box =context.findRenderObject();
                          Share.share(
                            url,
                          );
                          // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                        }),
                      ),
                      // Expanded(
                      //   flex: 4,
                      //   child: ListTileInfo(context,
                      //       title: AppLocalizations.of(context)!.rateApp,
                      //       icon2: Icons.star_rate_outlined, onTap: () {
                      //
                      //     // const _url = 'https://googlePlay.com';
                      //     // launchURL(_url);
                      //   }),
                      // ),
                      Expanded(
                          flex: 3,
                          child: GetX<GetSocialGetx>(
                              init: GetSocialGetx(),
                              builder: (GetSocialGetx controller) {
                                return controller.isLoading.value
                                    ? Center(child: indicatorNourahLoading())
                                    : ListView.builder(
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: controller.socials.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: wSpace,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    launchURL(controller
                                                        .socials[index].link);
                                                  },
                                                  child: Container(
                                                    child: ImageCircle(
                                                      imageString: controller
                                                          .socials[index].icon,
                                                      radius: 25,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: wSpace,
                                                ),
                                              ]);
                                        });
                              })),

                      Expanded(
                        child: dividerApp(height: 0),
                      ),
                      Expanded(
                        flex: 4,
                        child: listTileInfo(context,
                            title: AppLocalizations.of(context)!.emailUs,
                            icon2: Icons.attach_email_outlined, onTap: () {
                          openEmail(context: context);
                        }),
                      ),
                      Expanded(
                        flex: 4,
                        child: listTileInfo(context,
                            title:
                                AppLocalizations.of(context)!.termsandcondions,
                            icon2: Icons.local_police_outlined, onTap: () {
                          Navigator.pushNamed(context, '/termsScreen');
                        }),
                      ),
                      Expanded(
                        flex: 4,
                        child: listTileInfo(context,
                            title: AppLocalizations.of(context)!.info,
                            icon2: Icons.info_outline, onTap: () {
                          Navigator.pushNamed(context, '/infoScreen');
                        }),
                      ),

                      if (widget.driver == true || widget.family == true)
                        Expanded(
                          flex: 4,
                          child: listTileInfo(context,
                              title:
                                  AppLocalizations.of(context)!.deleteMyAccount,
                              icon2: Icons.delete_outline, onTap: () async {
                            showDialoge(
                              context,
                              message3: Column(),
                              message1:
                                  AppLocalizations.of(context)!.deleteMyAccount,
                              message2: AppLocalizations.of(context)!
                                  .areyousureaboutDeleteYourAccount,
                              iconMeassge: Icon(
                                Icons.warning_amber_outlined,
                                color: kRefuse,
                                size: SizeConfig.scaleTextFont(70),
                              ),
                              button1: AppLocalizations.of(context)!.yes,
                              colorButton1: kRefuse,
                              button2: AppLocalizations.of(context)!.no,
                              colorButton2: kConfirm,
                              onPressed: () async {
                                await deleteAccount();
                                await logout();
                              },
                            );
                          }, icon1: null),
                        ),

                      if (isLoggedInUser == true && widget.user == true)
                        Expanded(
                          flex: 4,
                          child: listTileInfo(
                            context,
                            title:
                                AppLocalizations.of(context)!.deleteMyAccount,
                            icon2: Icons.delete_outline,
                            icon1: null,
                            onTap: () async {
                              showDialoge(
                                context,
                                message3: Column(),
                                message1: AppLocalizations.of(context)!
                                    .deleteMyAccount,
                                message2: AppLocalizations.of(context)!
                                    .areyousureaboutDeleteYourAccount,
                                iconMeassge: Icon(
                                  Icons.warning_amber_outlined,
                                  color: kRefuse,
                                  size: SizeConfig.scaleTextFont(70),
                                ),
                                button1: AppLocalizations.of(context)!.yes,
                                colorButton1: kRefuse,
                                button2: AppLocalizations.of(context)!.no,
                                colorButton2: kConfirm,
                                onPressed: () async {
                                  await deleteAccount();
                                  await logout();
                                },
                              );
                            },
                          ),
                        ),
                      if (isLoggedInUser == true && widget.user == true)
                        Expanded(
                          flex: 4,
                          child: listTileInfo(context,
                              title: AppLocalizations.of(context)!.logout,
                              icon2: Icons.logout, onTap: () async {
                            await logout();
                          }, icon1: null),
                        ),

                      if (widget.user == true)
                        if (isLoggedInUser == false)
                          Expanded(
                            flex: 4,
                            child: listTileInfo(
                              context,
                              title: AppLocalizations.of(context)!.signupfamily,
                              icon2: Icons.family_restroom,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/registrationFamilyScreen');
                              },
                            ),
                          ),
                      if (widget.user == true)
                        if (isLoggedInUser == false)
                          Expanded(
                            flex: 4,
                            child: listTileInfo(
                              context,
                              title: AppLocalizations.of(context)!.signupdriver,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/registrationDeliveryScreen');
                              },
                              icon2: Icons.delivery_dining,
                            ),
                          ),
                      if (widget.driver == true || widget.family == true)
                        Expanded(
                          flex: 4,
                          child: listTileInfo(
                            context,
                            title: AppLocalizations.of(context)!.logout,
                            icon2: Icons.logout,
                            onTap: () async {
                              await logout();
                            },
                          ),
                        ),
                      // Expanded(
                      //   flex: 4,
                      //   child: listTileInfo(
                      //     context,
                      //     title: AppLocalizations.of(context)!.termsandcondions,
                      //     icon2: Icons.logout,
                      //     onTap: () async {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => Chat(
                      //                   orderNo: '1039',
                      //                   // driverId: 235,
                      //                   // userId: 171,
                      //                 )),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  );
          }),
    );
  }

  Future logout() async {
    bool logOut = await LoginAndProfileController().logoutController(context,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en");
    // if (logOut) {
    await SharedPreferencesController().logout();
    Navigator.pushReplacementNamed(
      context,
      "/mapScreen",
    );
    Get.deleteAll(force: true);

    Get.put(GetBannersGetx());

    String fileName5 = "getProfileController.json";
    var dir5 = await getTemporaryDirectory();
    File file5 = File("${dir5.path}/$fileName5");
    if (file5.existsSync()) file5.deleteSync(recursive: true);

    String fileName6 = "getFamilyCategoriesController.json";
    var dir6 = await getTemporaryDirectory();
    File file6 = File("${dir6.path}/$fileName6");
    if (file6.existsSync()) file6.deleteSync(recursive: true);

    if (SharedPreferencesController().isLoggedInUserGoogle) {
      await _googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut().then((value) async {
        await SharedPreferencesController()
            .saveLoggedInUserGoogle(state: false);
      });
    }
    // }
  }

  Future deleteAccount() async {
    await LoginAndProfileController().deleteAcountController(context,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en");
  }

  static Future openEmail({required BuildContext context}) async {
    String toEmail = 'nourahapp22@gmail.com';
    String subject = Localizations.localeOf(context).languageCode == 'ar'
        ? 'استفسار بخصوص ...'
        : 'Inquiry about ...';
    String body = Localizations.localeOf(context).languageCode == 'ar'
        ? 'اسمي:(           )      ، مرحبا نورة أود الاستفسار منكم عن ...'
        : 'My name is:(               )      ، Hello Nourah ...';

    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // print("No email client found");
    }
  }
}

void launchURL(url) async => await canLaunchUrl(Uri.parse(url))
    ? await launchUrl(Uri.parse(url))
    : throw 'Could not launch $url';
