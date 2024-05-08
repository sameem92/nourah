import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/public_screens/login_screen.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

class RegistrationDeliveryScreen extends StatefulWidget {
  @override
  State<RegistrationDeliveryScreen> createState() =>
      _RegistrationDeliveryScreenState();
}

class _RegistrationDeliveryScreenState
    extends State<RegistrationDeliveryScreen> {
  late TextEditingController registerFamilyNumber = TextEditingController();
  late TextEditingController registerDriverName = TextEditingController();
  late TextEditingController licenseNumber = TextEditingController();
  late TextEditingController emailInfo = TextEditingController();
  late TextEditingController idnumber = TextEditingController();
  late TextEditingController city = TextEditingController();

  @override
  void initState() {
    super.initState();

    registerFamilyNumber = TextEditingController();
    registerDriverName = TextEditingController();
    licenseNumber = TextEditingController();
    idnumber = TextEditingController();
    city = TextEditingController();
    emailInfo = TextEditingController();

    registerFamilyNumber.addListener(() => setState(() {}));
    licenseNumber.addListener(() => setState(() {}));
    city.addListener(() => setState(() {}));
    registerDriverName.addListener(() => setState(() {}));
    idnumber.addListener(() => setState(() {}));
    emailInfo.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    registerFamilyNumber.dispose();
    registerDriverName.dispose();
    idnumber.dispose();
    city.dispose();
    emailInfo.dispose();
    licenseNumber.dispose();
    super.dispose();
  }

  bool progress = false;
  bool done = false;

  bool read = false;
  bool imageBool = false;
  bool readBool = false;
  final _formKey = GlobalKey<FormState>();
  bool imageEmpty = false;
  PickedFile? _pickedFile;
  ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.signupdriver,
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: wPadding,
              end: wPadding,
              top: hSpaceLargevv,
              bottom: hSpace,
            ),
            child: Column(
              children: [
                StyleField(
                  title: AppLocalizations.of(context)!.register_driver_name,
                  controller: registerDriverName,
                  prefixIcon: const Icon(Icons.delivery_dining),
                  isRequired: true,
                ),
                SizedBox(
                  height: hSpace,
                ),
                StyleField(
                  prefixIcon: const Icon(Icons.phone_android_outlined),
                  title: AppLocalizations.of(context)!.register_family_number,
                  controller: registerFamilyNumber,
                  keyboardType: TextInputType.number,
                  isRequired: true,
                  isPhone: true,
                ),
                SizedBox(
                  height: hSpace,
                ),
                StyleField(
                  title: AppLocalizations.of(context)!.emailinfo,
                  controller: emailInfo,
                  prefixIcon: const Icon(Icons.email_outlined),
                  keyboardType: TextInputType.emailAddress,
                  isEmail: true,
                  isRequired: true,
                ),
                // SizedBox(
                //   height: hSpace,
                // ),
                // StyleField(
                //   title: AppLocalizations.of(context)!.idnumber,
                //   controller: idnumber,
                //   prefixIcon: const Icon(Icons.person_pin_outlined),
                //   isRequired: true,
                //   keyboardType: TextInputType.number,
                // ),
                // SizedBox(
                //   height: hSpace,
                // ),
                // StyleField(
                //   title: AppLocalizations.of(context)!.licenseNumber,
                //   controller: licenseNumber,
                //   prefixIcon: const Icon(Icons.drive_eta_outlined),
                //   keyboardType: TextInputType.number,
                //   isRequired: true,
                // ),
                SizedBox(
                  height: hSpaceLargev,
                ),
                // StyleText(
                //   AppLocalizations.of(context)!.personalImage,
                // ),
                SizedBox(
                  height: hSpaceLargevv,
                ),

                SizedBox(
                  height: hSpace,
                ),
                SizedBox(
                  height: hSpaceLarge,
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(190),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                        activeColor: kSpecialColor,
                        side: BorderSide(
                            style: BorderStyle.solid, color: kSpecialColor),
                        value: read,
                        onChanged: (value) {
                          if (!mounted) {
                          } else {
                            setState(() {
                              read = value!;
                            });
                          }
                        }),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/termsScreen');
                        },
                        child: StyleText(
                          AppLocalizations.of(context)!.termsandcondions,
                          textColor: kSpecialColor,
                        )),
                  ],
                ),
                readBool == true
                    ? StyleText(
                        AppLocalizations.of(context)!
                            .pleaseAcceptOurTermsAndCondions,
                        textColor: kRefuse,
                      )
                    : Column(),
                SizedBox(
                  height: hSpace,
                ),
                StyleButton(
                  AppLocalizations.of(context)!.create,
                  onPressed: () async {
                    setState(() {
                      if (read == false) {
                        readBool = true;
                      } else {
                        readBool = false;
                      }
                      if (_pickedFile == null) {
                        imageBool = true;
                      } else {
                        imageBool = false;
                      }
                    });

                    bool isValidate = _formKey.currentState!.validate();
                    if (isValidate) {
                      await registerDriver();
                    }
                  },
                ),
                SizedBox(
                  height: hSpaceLargev,
                ),
                progress == true || done == true
                    ? Column(
                        children: [
                          SizedBox(
                              height: SizeConfig.scaleHeight(50),
                              width: SizeConfig.scaleWidth(50),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  progress == true
                                      ? indicatorNourahLoadingSpecial()
                                      : Column(),
                                  done == true
                                      ? indicatorNourahDone()
                                      : Column()
                                ],
                              )),
                          SizedBox(
                            height: hSpaceLargev,
                          ),
                        ],
                      )
                    : Column(),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StyleText(
                        AppLocalizations.of(context)!.haveAnAccount,
                      ),
                      SizedBox(
                        width: wSpaceLarge,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInScreen(
                                          driver: true,
                                        )),
                                (Route<dynamic> route) => false);
                          },
                          child: StyleText(
                            AppLocalizations.of(context)!.signIn,
                            textColor: kSpecialColor,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: hSpaceLargev,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickImage() async {
    _pickedFile = (await imagePicker.pickImage(source: ImageSource.gallery))
        as PickedFile?;
    if (_pickedFile != null) setState(() {});
  }

  Future registerDriver() async {
    if (
        // _pickedFile != null &&
        //     city.text.isNotEmpty &&
        emailInfo.text.isNotEmpty &&
            // idnumber.text.isNotEmpty &&
            // licenseNumber.text.isNotEmpty &&
            read != false &&
            // _pickedFile!.path != null &&
            registerDriverName.text.isNotEmpty &&
            registerFamilyNumber.text.isNotEmpty) {
      setState(() {
        progress = true;
        done = false;
      });
      // Helper(
      //     context: context,
      //     message: AppLocalizations.of(context)!.dataIsBeingModified,
      //     error: true);

      LoginAndProfileController().registerController(context,
          // path: _pickedFile!.path,
          lat:
              "${Provider.of<LongNotiferUser>(context, listen: false).longUser}",
          lng: "${Provider.of<LatNotiferUser>(context, listen: false).latUser}",
          phone: registerFamilyNumber.text,
          idnumber: idnumber.text,
          licenseNumber: licenseNumber.text,
          address: Provider.of<stringNotiferUser>(context, listen: false)
              .addressUser,
          // city: city.text,
          email: emailInfo.text,
          language: Localizations.localeOf(context).languageCode == "ar"
              ? "ar"
              : "en",
          name: registerDriverName.text, uploadEvent: (bool status) {
        setState(() {
          progress = false;
          done = true;
        });
      });
    } else {
      helper(
          context: context,
          message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
          error: true);
    }
  }
}
