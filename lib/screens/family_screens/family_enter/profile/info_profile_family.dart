import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

class InfoProfileFamily extends StatefulWidget {
  @override
  _InfoProfileFamilyState createState() => _InfoProfileFamilyState();
}

class _InfoProfileFamilyState extends State<InfoProfileFamily> {
  late TextEditingController _nameinfo;
  late TextEditingController _phoneNumberinfo;
  late TextEditingController _emailinfo;
  late TextEditingController _arabicDescription;
  late TextEditingController _englishDescription;
  late TextEditingController _password;
  late TextEditingController _newPassword;
  late TextEditingController _theminimumorder;
  late TextEditingController _confirmNewPassword;
  String available = '1';
  @override
  void initState() {
    super.initState();
    managenotificationAction(context);

    _nameinfo = TextEditingController(
      text: controller.profile["name"] ?? "",
    );
    _phoneNumberinfo =
        TextEditingController(text: controller.profile["phone"] ?? "");
    _emailinfo = TextEditingController(
      text: controller.profile["email"] ?? "",
    );
    _arabicDescription = TextEditingController(
      text: controller.profile["notes"] ?? "",
    );
    _englishDescription = TextEditingController(
      text: controller.profile["ennotes"] ?? "",
    );
    _password = TextEditingController();
    _theminimumorder = TextEditingController(
      text: controller.profile["minimum_order"] ?? "",
    );
    _newPassword = TextEditingController();
    _confirmNewPassword = TextEditingController();

    _nameinfo.addListener(() => setState(() {}));
    _phoneNumberinfo.addListener(() => setState(() {}));
    _emailinfo.addListener(() => setState(() {}));
    _arabicDescription.addListener(() => setState(() {}));
    _englishDescription.addListener(() => setState(() {}));
    _password.addListener(() => setState(() {}));
    _newPassword.addListener(() => setState(() {}));
    _confirmNewPassword.addListener(() => setState(() {}));
    _theminimumorder.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameinfo.dispose();
    _phoneNumberinfo.dispose();
    _theminimumorder.dispose();
    _emailinfo.dispose();
    _arabicDescription.dispose();
    _englishDescription.dispose();
    _password.dispose();
    _newPassword.dispose();

    _confirmNewPassword.dispose();
    super.dispose();
  }

  bool progress = false;
  bool done = false;
  getProfileGetx controller = Get.find();

  CroppedFile? _croppedFile2;
  CroppedFile? _croppedFile1;

  PickedFile? _pickedFile2;
  PickedFile? _pickedFile1;
  ImagePicker imagePicker = ImagePicker();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.familyInfo,
        onPressed: () {},
      ),
      body: GetX<getProfileGetx>(builder: (getProfileGetx controller) {
        return SingleChildScrollView(
          child: Form(
            child: controller.isLoading.value
                ? Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.scaleHeight(400),
                      ),
                      Center(child: indicatorNourahLoading()),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: SizeConfig.scaleHeight(240),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: SizeConfig.scaleHeight(200),
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: () async {
                                  await pickImage1();
                                },
                                child: _croppedFile1 != null
                                    ? Image.file(File(_croppedFile1!.path),
                                        width: double.infinity,
                                        fit: BoxFit.cover)
                                    : controller.profile["cover_image"] != null
                                        ? ImageContainer(
                                            controller.profile["cover_image"] ??
                                                "")
                                        : Image.asset(
                                            'assets/images/cover.jpeg',
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 0,
                              start: 0,
                              end: 0,
                              child: Container(
                                height: SizeConfig.scaleHeight(140),
                                width: SizeConfig.scaleWidth(130),
                                decoration: const BoxDecoration(
                                  color: kBackgroundColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              bottom: SizeConfig.scaleHeight(10),
                              start: 0,
                              end: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  await pickImage2();
                                },
                                child: _croppedFile2 != null
                                    ? FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: CircleAvatar(
                                            foregroundImage:
                                                AssetImage(_croppedFile2!.path),
                                            radius:
                                                SizeConfig.scaleTextFont(60)),
                                      )
                                    : controller.profile["image"] != null
                                        ? ImageCircle(
                                            imageString:
                                                controller.profile["image"] ??
                                                    '',
                                            radius: 60,
                                          )
                                        : Image.asset(
                                            'assets/images/cover.jpeg',
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: hSpaceLarge,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: wPadding,
                          end: wPadding,
                          top: hPadding,
                          bottom: hPadding,
                        ),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey1,
                              child: Column(
                                children: [
                                  StyleField(
                                    title: AppLocalizations.of(context)!
                                        .register_family_name,
                                    controller: _nameinfo,
                                    prefixIcon:
                                        const Icon(Icons.family_restroom),
                                    isRequired: true,
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  StyleField(
                                    controller: _phoneNumberinfo,
                                    prefixIcon: const Icon(Icons.phone_android),
                                    title: AppLocalizations.of(context)!
                                        .labephoneNumberinfo,
                                    keyboardType: TextInputType.phone,
                                    isRequired: true,
                                    isPhone: true,
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  StyleField(
                                    controller: _emailinfo,
                                    prefixIcon:
                                        const Icon(Icons.email_outlined),
                                    title:
                                        AppLocalizations.of(context)!.emailinfo,
                                    keyboardType: TextInputType.emailAddress,
                                    isRequired: true,
                                    isEmail: true,
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(170),
                                    child: StyleField(
                                      controller: _arabicDescription,
                                      hintText:
                                          controller.profile["notes"] ?? "",
                                      prefixIcon: const Icon(Icons.event_note),
                                      title: AppLocalizations.of(context)!
                                          .arabicDescription,
                                      maxLines: 10,
                                      height: SizeConfig.scaleHeight(200),
                                    ),
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  SizedBox(
                                    height: SizeConfig.scaleHeight(170),
                                    child: StyleField(
                                      controller: _englishDescription,
                                      prefixIcon:
                                          const Icon(Icons.event_note_outlined),
                                      title: AppLocalizations.of(context)!
                                          .englishDescription,
                                      maxLines: 10,
                                      height: SizeConfig.scaleHeight(200),
                                    ),
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  StyleField(
                                    controller: _theminimumorder,
                                    keyboardType: TextInputType.number,
                                    // suffixText: AppLocalizations.of(context)!.reyal,
                                    prefixIcon:
                                        const Icon(Icons.event_note_outlined),
                                    title: AppLocalizations.of(context)!
                                        .theminimumorder,
                                    // isRequired: true,
                                  ),
                                  progress != true
                                      ? SizedBox(
                                          height: hSpaceLarge,
                                        )
                                      : const SizedBox(),
                                  progress != true
                                      ? StyleButton(
                                          AppLocalizations.of(context)!
                                              .saveinfo,
                                          onPressed: () async {
                                            FocusScope.of(context).unfocus();
                                            bool isValidate = _formKey1
                                                .currentState!
                                                .validate();
                                            {
                                              if (isValidate) {
                                                if (!mounted) {
                                                } else {
                                                  setState(() {
                                                    progress = true;
                                                    done = false;
                                                  });
                                                }
                                                await updateProfile();
                                                if (updateProfile() == true) {
                                                  setState(() {
                                                    progress = false;
                                                    done = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    progress = false;
                                                  });
                                                }

                                                // Navigator.pop(context);
                                              }
                                            }
                                          },
                                        )
                                      : const SizedBox(),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: hSpace,
                                      ),
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
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            dividerApp(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: SizeConfig.scaleWidth(170),
                                  child: RadioListTile(
                                    title: StyleText(
                                        AppLocalizations.of(context)!
                                            .available),
                                    value: 1,
                                    activeColor: kConfirm,
                                    groupValue: controller.profile['available'],
                                    onChanged: (Object? value) async {
                                      if (mounted) {
                                        setState(() {
                                          value =
                                              controller.profile['available'];
                                          available = "1";
                                        });
                                      }
                                      if (mounted) {
                                        await changeValidity();
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: wSpace,
                                ),
                                SizedBox(
                                  width: SizeConfig.scaleWidth(200),
                                  child: RadioListTile(
                                      title: StyleText(
                                          AppLocalizations.of(context)!
                                              .unavailable),
                                      activeColor: kRefuse,
                                      value: 0,
                                      groupValue:
                                          controller.profile['available'],
                                      onChanged: (Object? value) async {
                                        if (mounted) {
                                          setState(() {
                                            value =
                                                controller.profile['available'];
                                            available = "0";
                                          });
                                        }
                                        if (mounted) {
                                          await changeValidity();
                                        }
                                      }),
                                ),
                              ],
                            ),
                            dividerApp(),
                            Form(
                              key: _formKey2,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  StyleText(
                                    AppLocalizations.of(context)!.editPassword,
                                    textColor: kSpecialColor,
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  StyleField(
                                    controller: _password,
                                    title:
                                        AppLocalizations.of(context)!.password,
                                    prefixIcon:
                                        const Icon(Icons.password_sharp),
                                    obscureText: true,
                                    isRequired: true,
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  StyleField(
                                    controller: _newPassword,
                                    title: AppLocalizations.of(context)!
                                        .newPassword,
                                    prefixIcon: const Icon(Icons.password),
                                    obscureText: true,
                                    isRequired: true,
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  StyleField(
                                    controller: _confirmNewPassword,
                                    title: AppLocalizations.of(context)!
                                        .confirmNewPassword,
                                    prefixIcon: const Icon(
                                        Icons.confirmation_num_outlined),
                                    obscureText: true,
                                    isRequired: true,
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                ],
                              ),
                            ),
                            StyleButton(
                              AppLocalizations.of(context)!.saveinfo,
                              onPressed: () async {
                                bool isValidate =
                                    _formKey2.currentState!.validate();
                                if (isValidate) {
                                  await performChangePassword();
                                  FocusScope.of(context).unfocus();
                                }
                              },
                            ),
                            SizedBox(
                              height: hSpaceLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      }),
    );
  }

  Future performChangePassword() async {
    if (checkData()) {
      await changePassword();
    }
  }

  bool checkData() {
    if (_newPassword.text.isNotEmpty &&
        _password.text.isNotEmpty &&
        _confirmNewPassword.text.isNotEmpty &&
        _confirmNewPassword.text == _newPassword.text) {
      return true;
    }
    helper(
        context: context,
        message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
        error: true);
    return false;
  }

  Future changePassword() async {
    await LoginAndProfileController().changePasswordController(context,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
        password: _newPassword.text,
        oldPassword: _password.text);
    return true;
  }

  Future changeValidity() async {
    await controller.changeValidity(
      context: context,
      available: available,
    );
  }

  Future pickImage2() async {
    _pickedFile2 = await imagePicker.getImage(source: ImageSource.gallery);
    if (_pickedFile2 != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile2!.path,
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 70,
        aspectRatio: const CropAspectRatio(ratioX: 60, ratioY: 60),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: kSpecialColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioLockDimensionSwapEnabled: true,
            aspectRatioLockEnabled: true,
            rotateButtonsHidden: true,
            rotateClockwiseButtonHidden: true,
          ),
        ],
      );
      if (!mounted) {
      } else {
        setState(() {
          _croppedFile2 = croppedFile;
        });
      }
    }
  }

  Future pickImage1() async {
    _pickedFile1 = await imagePicker.getImage(source: ImageSource.gallery);
    if (_pickedFile1 != null) if (mounted) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile1!.path,
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 1.3),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: kSpecialColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioLockDimensionSwapEnabled: true,
            aspectRatioLockEnabled: true,
            rotateButtonsHidden: true,
            rotateClockwiseButtonHidden: true,
          ),
        ],
      );
      setState(() {
        _croppedFile1 = croppedFile;
      });
    }
  }

  Future updateProfile() async {
    await controller.updateProfile(
        context: context,
        path2: _croppedFile2 != null ? _croppedFile2!.path : null,
        path1: _croppedFile1 != null ? _croppedFile1!.path : null,
        notes: _arabicDescription.text,
        ennotes: _englishDescription.text,
        lat: Provider.of<LatNotiferFamily>(context, listen: false).latFamily,
        lng: Provider.of<LongNotiferFamily>(context, listen: false).longFamily,
        address: Provider.of<stringNotiferFamily>(context, listen: false)
            .addressFamily,
        minimum_order: _theminimumorder.text,
        name: _nameinfo.text,
        email: _emailinfo.text,
        phone: _phoneNumberinfo.text,
        uploadEvent: (bool status) {
          return true;
        });
  }
}
