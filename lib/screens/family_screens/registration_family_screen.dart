import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/public_screens/login_screen.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RegistrationFamilyScreen extends StatefulWidget {
  @override
  _RegistrationFamilyScreenState createState() =>
      _RegistrationFamilyScreenState();
}

class _RegistrationFamilyScreenState extends State<RegistrationFamilyScreen> {
  late TextEditingController _familyName;

  late TextEditingController _familyPhone;

  late TextEditingController _familyEmail;
  late TextEditingController _familycategory;


  int choiceIndex = 0;
  List<String> _selectedCategories = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _familyName = TextEditingController();
    _familyPhone = TextEditingController();
    _familyEmail = TextEditingController();
    _familycategory = TextEditingController();
    _familyName.addListener(() => setState(() {}));
    _familyPhone.addListener(() => setState(() {}));
    _familyEmail.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _familyEmail.dispose();
    _familyName.dispose();
    _familyPhone.dispose();
    _familycategory.dispose();
  }

  bool read = false;

  bool readBool = false;
  var _formKey = GlobalKey<FormState>();

  bool categoryEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWhite(
        context,
        title: AppLocalizations.of(context)!.register_title,
        onPressed: () {},
      ),
      body:Padding(
          padding: EdgeInsetsDirectional.only(
            start: wPadding,
            end: wPadding,
            top: hPadding,
            bottom: hPadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: hSpace,
                ),
                StyleField(
                  title: AppLocalizations.of(context)!.register_family_name,
                  controller: _familyName,
                  prefixIcon: Icon(Icons.family_restroom),
                  isRequired: true,
                ),
                SizedBox(
                  height: hSpace,
                ),
                StyleField(
                  title: AppLocalizations.of(context)!.register_family_number,
                  controller: _familyPhone,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(Icons.phone_android_outlined),
                  isRequired: true,
                  isPhone: true,
                ),
                SizedBox(
                  height: hSpace,
                ),
                StyleField(
                  title: AppLocalizations.of(context)!.register_family_email,
                  controller: _familyEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email_outlined),
                  isRequired: true,
                  isEmail: true,
                ),
               Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.scaleWidth(10),
                    right: SizeConfig.scaleWidth(10),
                  ),
                  child: GetX<CategoriesGetX>(
                    builder: (CategoriesGetX controller) {
                      return Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        children: controller.categories.value.map((e) {
                          return ChoiceChip(
                            label: StyleText(
                              Localizations.localeOf(context).languageCode ==
                                      "ar"
                                  ? "${e.arname}"
                                  : "${e.enname}",
                              textColor: kBackgroundColor,
                            ),
                            elevation: 1,
                            onSelected: (bool isSelected) => setState(() {
                              e.selected = isSelected;
                              isSelected
                                  ? _selectedCategories.add(e.id.toString())
                                  : _selectedCategories.remove(e.id.toString());
                            }),
                            selected: e.selected,
                            selectedColor: kSpecialColor.withOpacity(.9),
                            backgroundColor: kSecondaryColor.withOpacity(.9),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                categoryEmpty == true
                    ? StyleText(
                        AppLocalizations.of(context)!
                            .pleaseChooseOneCategoryForYourProductArea,
                        textColor: kRefuse,
                        fontSize: fSmall,
                      )
                    : Column(),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
activeColor: kSpecialColor,
                        side: BorderSide(style: BorderStyle.solid,color: kSecondaryColor),
                        value: read,
                        onChanged: (value) {
                          setState(() {
                            read = value!;
                          });
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
                        fontSize: fSmall,
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

                      setState(() {
                        if (_selectedCategories.isEmpty) {
                          categoryEmpty = true;
                        } else {
                          categoryEmpty = false;
                        }
                      });

                      print(_selectedCategories);
                    });
                    bool isValidate = _formKey.currentState!.validate();
                    if (isValidate) {
                      await performRegister();
                    }
                  },
                ),
                SizedBox(
                  height: hSpaceLarge,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StyleText(
                        AppLocalizations.of(context)!.haveAnAccount,
                      ),
                      SizedBox(
                        width: wSpace,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogInScreen(driver: false,),
                                ));
                          },
                          child: StyleText(
                            AppLocalizations.of(context)!.signIn,
                            textColor: kSpecialColor,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: hSpaceLarge,
                ),
              ],
            ),
          ),
        ),

    );
  }

  Future performRegister() async {
    if (checkData()) {
      await Register();
    }
  }

  bool checkData() {
    if (_familyPhone.text.isNotEmpty &&
        _familyName.text.isNotEmpty &&
        _familyEmail.text.isNotEmpty &&
        read != false &&
        _selectedCategories.length != 0) {
      return true;
    }

    Helper(
        context: context,
        message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
        error: true);
    return false;
  }

  Future Register() async {
    await loginAndProfileController().registerFamilyController(
        context: context,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
        lat: Provider.of<LatNotiferUser>(context, listen: false).latUser,
        phone: _familyPhone.text,
        address:
            Provider.of<stringNotiferUser>(context, listen: false).addressUser,
        categories: _selectedCategories,
        email: _familyEmail.text,
        lng: Provider.of<LongNotiferUser>(context, listen: false).longUser,
        name: _familyName.text);
  }
}
