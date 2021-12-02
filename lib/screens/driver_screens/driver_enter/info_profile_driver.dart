import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  getProfileGetx cont = Get.find();

  @override
  void initState() {
    super.initState();
    _nameinfo = TextEditingController(text: cont.profile["name"] ?? '');
    _phoneNumberinfo = TextEditingController(text: cont.profile["phone"] ?? '');
    _emailinfo = TextEditingController(text: cont.profile["email"] ?? '');
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
    super.dispose();
    _nameinfo.dispose();
    _phoneNumberinfo.dispose();
    _emailinfo.dispose();

    _password.dispose();
    _newPassword.dispose();
  }

  PickedFile? _pickedFile;
  var _formKey1 = GlobalKey<FormState>();
  var _formKey2 = GlobalKey<FormState>();

  ImagePicker imagePicker = ImagePicker();
  bool progress = false;
  bool done = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWhite(
        context,
        title: AppLocalizations.of(context)!.infoTitle,
        onPressed: () {},
      ),
      body: GetX<getProfileGetx>(
          init: getProfileGetx(),
          builder: (getProfileGetx controller) {
            Object? _available = controller.profile['available'];
            return controller.isLoading.value
                ? Center(child: indicator_nourah_loading())
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: hPadding,
                        bottom: hPadding,
                        left: wPadding,
                        right: wPadding,
                      ),
                      child: controller.isLoading.value
                          ? Center(child: indicator_nourah_loading())
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
                                    child: _pickedFile != null
                                        ? CircleAvatar(
                                            backgroundImage:
                                                AssetImage(_pickedFile!.path),
                                            radius: SizeConfig.scaleHeight(75),
                                          )
                                        : image_circle(
                                           imageString:  controller.profile["image"] ?? '',
                                            radius: 75),
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  StyleField(
                                    controller: _nameinfo,
                                    title: AppLocalizations.of(context)!
                                        .register_driver_name,
                                    prefixIcon: Icon(Icons.delivery_dining),
                                    isRequired: true,
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  StyleField(
                                    controller: _phoneNumberinfo,
                                    prefixIcon: Icon(Icons.phone_android),
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
                                    prefixIcon: Icon(Icons.email_outlined),
                                    isEmail: true,
                                    isRequired: true,
                                    title:
                                        AppLocalizations.of(context)!.emailinfo,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  StyleButton(
                                    AppLocalizations.of(context)!.saveinfo,
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();

                                      bool isValidate =
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
                                        });}
                                    },
                                  ),
                                  progress == true || done == true
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: hSpace,
                                            ),
                                            SizedBox(
                                                height:
                                                    SizeConfig.scaleHeight(50),
                                                width:
                                                    SizeConfig.scaleWidth(50),
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    progress == true
                                                        ? indicator_nourah_loading()
                                                        : Column(),
                                                    done == true
                                                        ? indicator_nourah_done()
                                                        : Column()
                                                  ],
                                                )),

                                          ],
                                        )
                                      : Column(),
                                  divider_app(height: 50),
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
                                          groupValue: _available,
                                          onChanged: (Object? value) {
                                            setState(() {
                                              value = _available;
                                              available = "1";
                                            });
                                            setState(() async {
                                              await changeValidity();
                                            });
                                            setState(() {});
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
                                            groupValue: _available,
                                            onChanged: (Object? value) {
                                              // if (value != null) {
                                              setState(() {
                                                value = _available;
                                                available = "0";
                                              });
                                              setState(() async {
                                                await changeValidity();
                                              });
                                              setState(() {});
                                            }),
                                      ),
                                    ],
                                  ),
                                  divider_app(height: 50),
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
                                              Icon(Icons.password_sharp),
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
                                          prefixIcon: Icon(Icons.password),
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
                                          prefixIcon: Icon(
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
                                    height: hSpaceLargev,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  );
          }),
    );
  }

  Future pickImage() async {
    _pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) setState(() {});
  }

  Future changeValidity() async {

    await cont.changeValidity(
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
    Helper(
        context: context,
        message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
        error: true);
    return false;
  }

  Future changePassword() async {
    Helper(
        context: context,
        message: AppLocalizations.of(context)!.dataIsBeingModified,
        error: true);

    await loginAndProfileController().changePasswordController(context,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
        password: _newPassword.text,
        oldPassword: _password.text);
    return true;
  }

  Future updateProfile() async {

   await cont.updateProfile(context: context,
        path2:_pickedFile !=null ?_pickedFile!.path:null,
        path1:_pickedFile !=null ?_pickedFile!.path:null,
        notes: "",
        ennotes: "",
        name: _nameinfo.text,
        email: _emailinfo.text,
        phone: _phoneNumberinfo.text,
        uploadEvent: (bool status) { return true; }, minimum_order: '');
  }
}
