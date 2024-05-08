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

class InfoProfileDriver extends StatefulWidget {
  @override
  _InfoProfileDriverState createState() => _InfoProfileDriverState();
}

class _InfoProfileDriverState extends State<InfoProfileDriver> {
  late TextEditingController _nameinfo;
  late TextEditingController _phoneNumberinfo;
  late TextEditingController _emailinfo;

  late TextEditingController _password;
  late TextEditingController _newPassword;
  late TextEditingController _confirmNewPassword;

  String available = '1';
  getProfileGetx controller = Get.find();

  @override
  void initState() {
    super.initState();
    managenotificationAction(context);

    _nameinfo = TextEditingController(text: controller.profile["name"] ?? '');
    _phoneNumberinfo =
        TextEditingController(text: controller.profile["phone"] ?? '');
    _emailinfo = TextEditingController(text: controller.profile["email"] ?? '');
    _password = TextEditingController();
    _newPassword = TextEditingController();
    _confirmNewPassword = TextEditingController();
    _nameinfo.addListener(() => setState(() {}));
    _phoneNumberinfo.addListener(() => setState(() {}));
    _emailinfo.addListener(() => setState(() {}));
    _password.addListener(() => setState(() {}));
    _newPassword.addListener(() => setState(() {}));
    _confirmNewPassword.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameinfo.dispose();
    _phoneNumberinfo.dispose();
    _emailinfo.dispose();
    _password.dispose();
    _newPassword.dispose();
    super.dispose();
  }

  PickedFile? _pickedFile;
  CroppedFile? _croppedFile;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  ImagePicker imagePicker = ImagePicker();
  bool progress = false;
  bool done = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.infoTitle,
        onPressed: () {},
      ),
      body: GetX<getProfileGetx>(
        init: getProfileGetx(),
        builder: (getProfileGetx controller) {
          Object? available = controller.profile['available'];
          return controller.isLoading.value
              ? Center(child: indicatorNourahLoading())
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: hPadding,
                      bottom: hPadding,
                      left: wPadding,
                      right: wPadding,
                    ),
                    child: controller.isLoading.value
                        ? Center(child: indicatorNourahLoading())
                        : Form(
                            key: _formKey1,
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
                                      ? FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: CircleAvatar(
                                            backgroundImage:
                                                AssetImage(_croppedFile!.path),
                                            radius: SizeConfig.scaleHeight(75),
                                          ),
                                        )
                                      : ImageCircle(
                                          imageString:
                                              controller.profile["image"] ?? '',
                                          radius: 75,
                                        ),
                                ),
                                SizedBox(
                                  height: hSpaceLarge,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      StyleText(
                                        " ${controller.profile['rate'] ?? 0}",
                                        textAlign: TextAlign.start,
                                        height: 1.5,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: fIconSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: hSpaceLarge,
                                ),
                                StyleField(
                                  controller: _nameinfo,
                                  title: AppLocalizations.of(context)!
                                      .register_driver_name,
                                  prefixIcon: const Icon(Icons.delivery_dining),
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
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  isEmail: true,
                                  isRequired: true,
                                  title:
                                      AppLocalizations.of(context)!.emailinfo,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: hSpaceLarge,
                                ),
                                if (progress != true)
                                  SizedBox(
                                    height: hSpaceLarge,
                                  )
                                else
                                  const SizedBox(),
                                if (progress != true)
                                  StyleButton(
                                    AppLocalizations.of(context)!.saveinfo,
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();

                                      final bool isValidate =
                                          _formKey1.currentState!.validate();
                                      if (isValidate) {
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
                                else
                                  const SizedBox(),
                                if (progress == true || done == true)
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
                                            if (progress == true)
                                              indicatorNourahLoadingSpecial()
                                            else
                                              Column(),
                                            if (done == true)
                                              indicatorNourahDone()
                                            else
                                              Column()
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Column(),
                                dividerApp(height: 50),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.scaleWidth(170),
                                      child: RadioListTile(
                                        title: StyleText(
                                          AppLocalizations.of(context)!
                                              .available,
                                        ),
                                        value: 1,
                                        activeColor: kConfirm,
                                        groupValue: available,
                                        onChanged: (Object? value) async {
                                          setState(() {
                                            value = available;
                                            available = "1";
                                          });

                                          await changeValidity("1");
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
                                              .unavailable,
                                        ),
                                        activeColor: kRefuse,
                                        value: 0,
                                        groupValue: available,
                                        onChanged: (Object? value) async {
                                          // if (value != null) {
                                          setState(() {
                                            value = available;
                                            available = "0";
                                          });

                                          await changeValidity("0");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                dividerApp(height: 50),
                                Form(
                                  key: _formKey2,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: hSpaceLarge,
                                      ),
                                      StyleText(
                                        AppLocalizations.of(context)!
                                            .editPassword,
                                        textColor: kSpecialColor,
                                      ),
                                      SizedBox(
                                        height: hSpaceLarge,
                                      ),
                                      StyleField(
                                        controller: _password,
                                        title: AppLocalizations.of(context)!
                                            .password,
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
                                          Icons.confirmation_num_outlined,
                                        ),
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
                                    final bool isValidate =
                                        _formKey2.currentState!.validate();
                                    if (isValidate) {
                                      await performChangePassword();
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: hSpaceLargev,
                                ),
                              ],
                            ),
                          ),
                  ),
                );
        },
      ),
    );
  }

  Future pickImage() async {
    _pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
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
            lockAspectRatio: false,
          ),
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

  Future changeValidity(available) async {
    await controller.changeValidity(
      context: context,
      available: available,
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
      error: true,
    );
    return false;
  }

  Future changePassword() async {
    await LoginAndProfileController().changePasswordController(
      context,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      password: _newPassword.text,
      oldPassword: _password.text,
    );
    return true;
  }

  Future updateProfile() async {
    await controller.updateProfile(
      context: context,
      path2: _croppedFile != null ? _croppedFile!.path : null,
      path1: null,
      notes: "",
      ennotes: "",
      lat: Provider.of<LatNotiferDriver>(context, listen: false).latDriver,
      lng: Provider.of<LongNotiferDriver>(context, listen: false).longDriver,
      address: Provider.of<stringNotiferDriver>(context, listen: false)
          .addressDriver,
      name: _nameinfo.text,
      email: _emailinfo.text,
      phone: _phoneNumberinfo.text,
      minimum_order: '',
      uploadEvent: (bool status) {
        return true;
      },
    );
  }
}
