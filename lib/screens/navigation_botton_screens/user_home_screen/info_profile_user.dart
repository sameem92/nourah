import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

class InfoProfileUser extends StatefulWidget {
  @override
  _InfoProfileUserState createState() => _InfoProfileUserState();
}

class _InfoProfileUserState extends State<InfoProfileUser> {
  late TextEditingController _nameinfo;
  late TextEditingController _phoneNumberinfo;
  late TextEditingController _emailinfo;
  final _formKey = GlobalKey<FormState>();
  bool progress = false;
  bool done = false;

  getProfileGetx controller = Get.find();
  bool indicatorBool = false;
  PickedFile? _pickedFile;
  CroppedFile? _croppedFile;
  ImagePicker imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();

    _nameinfo = TextEditingController(text: controller.profile['name'] ?? '');
    _phoneNumberinfo =
        TextEditingController(text: controller.profile['phone'] ?? "");
    _emailinfo = TextEditingController(text: controller.profile['email'] ?? '');

    _nameinfo.addListener(() => setState(() {}));
    _phoneNumberinfo.addListener(() => setState(() {}));
    _emailinfo.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameinfo.dispose();
    _phoneNumberinfo.dispose();
    _emailinfo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.infoTitle,
        onPressed: () {},
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: wPadding,
          right: wPadding,
          top: hPadding,
          bottom: hSpaceLargevv,
        ),
        child: GetX<getProfileGetx>(builder: (getProfileGetx controller) {
          return controller.isLoading.value
              ? Center(child: indicatorNourahLoading())
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: hSpace,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await pickImage();
                          },
                          child: _croppedFile != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      AssetImage(_croppedFile!.path),
                                  radius: 75,
                                )
                              : ImageCircle(
                                  imageString:
                                      controller.profile["image"] ?? '',
                                  radius: 75,
                                ),
                        ),
                        SizedBox(
                          height: hSpaceLargev,
                        ),
                        StyleField(
                          controller: _nameinfo,
                          title: AppLocalizations.of(context)!.labelnameinfo,
                          prefixIcon: const Icon(Icons.person),
                          isRequired: true,
                        ),
                        SizedBox(
                          height: hSpace,
                        ),
                        StyleField(
                          controller: _phoneNumberinfo,
                          title:
                              AppLocalizations.of(context)!.labephoneNumberinfo,
                          prefixIcon: const Icon(Icons.phone_android_outlined),
                          keyboardType: TextInputType.phone,
                          isRequired: true,
                          isPhone: true,
                        ),
                        SizedBox(
                          height: hSpace,
                        ),
                        StyleField(
                          controller: _emailinfo,
                          title: AppLocalizations.of(context)!.emailinfo,
                          prefixIcon: const Icon(Icons.email_outlined),
                          keyboardType: TextInputType.emailAddress,
                          isEmail: true,
                          isRequired: true,
                        ),
                        progress != true
                            ? SizedBox(
                                height: hSpaceLargevv,
                              )
                            : const SizedBox(),
                        progress != true
                            ? StyleButton(
                                AppLocalizations.of(context)!.saveinfo,
                                onPressed: () async {
                                  bool isValidate =
                                      _formKey.currentState!.validate();
                                  if (isValidate) {
                                    FocusScope.of(context).unfocus();

                                    setState(() {
                                      progress = true;
                                      done = false;
                                    });
                                    await updateProfile();
                                    setState(() {
                                      progress = false;
                                      done = true;
                                    });
                                  }
                                },
                              )
                            : const SizedBox(),
                        Column(
                          children: [
                            SizedBox(
                              height: hSpaceLargevv,
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
                        dividerApp(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: fIcon,
                                  color: kSpecialColor,
                                ),
                                SizedBox(
                                  width: wSpace,
                                ),
                                StyleText(
                                  AppLocalizations.of(context)!.walletInfo,
                                ),
                              ],
                            ),
                            StyleText(
                              "${controller.profile['credit'] ?? "0"}  ${AppLocalizations.of(context)!.reyal}    ",
                              textColor: kSpecialColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }

  Future pickImage() async {
    _pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
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
      setState(() {
        _croppedFile = croppedFile;
      });
    }
  }

  Future updateProfile() async {
    await controller.updateProfile(
        path2: _croppedFile != null ? _croppedFile!.path : null,
        path1: _croppedFile != null ? _croppedFile!.path : null,
        notes: "",
        ennotes: "",
        name: _nameinfo.text,
        email: _emailinfo.text,
        lat: Provider.of<LatNotiferUser>(context, listen: false).latUser,
        lng: Provider.of<LongNotiferUser>(context, listen: false).longUser,
        address:
            Provider.of<stringNotiferUser>(context, listen: false).addressUser,
        phone: _phoneNumberinfo.text,
        uploadEvent: (bool status) {
          if (status) {}
        },
        context: context,
        minimum_order: '');
  }
}
