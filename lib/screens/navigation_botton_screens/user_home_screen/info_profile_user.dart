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

class InfoProfileUser extends StatefulWidget {
  @override
  _InfoProfileUserState createState() => _InfoProfileUserState();
}

class _InfoProfileUserState extends State<InfoProfileUser> {
  late TextEditingController _nameinfo;
  late TextEditingController _phoneNumberinfo;
  late TextEditingController _emailinfo;
  var _formKey = GlobalKey<FormState>();
  bool progress = false;
  bool done = false;
  getProfileGetx controller = Get.find();
  bool indicatorBool = false;
  PickedFile? _pickedFile;
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
    super.dispose();
    _nameinfo.dispose();
    _phoneNumberinfo.dispose();
    _emailinfo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWhite(
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
              ? Center(child:  indicator_nourah_loading())
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
                          child: _pickedFile != null
                              ? CircleAvatar(
                                  backgroundImage:
                                      AssetImage(_pickedFile!.path),
                                  radius: 75,
                                )
                              : image_circle(
                              imageString:     controller.profile["image"] ?? '',
                                  radius: 75,
                                ),
                        ),
                        SizedBox(
                          height: hSpaceLargev,
                        ),
                        StyleField(
                          controller: _nameinfo,
                          title: AppLocalizations.of(context)!.labelnameinfo,
                          prefixIcon: Icon(Icons.person),
                          isRequired: true,
                        ),
                        SizedBox(
                          height: hSpace,
                        ),
                        StyleField(
                          controller: _phoneNumberinfo,
                          title:
                              AppLocalizations.of(context)!.labephoneNumberinfo,
                          prefixIcon: Icon(Icons.phone_android_outlined),
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
                          prefixIcon: Icon(Icons.email_outlined),
                          keyboardType: TextInputType.emailAddress,
                          isEmail: true,
                          isRequired: true,
                        ),
                        SizedBox(
                          height: hSpaceLargevv,
                        ),
                        StyleButton(
                          AppLocalizations.of(context)!.saveinfo,
                          onPressed: () async {

                            bool isValidate = _formKey.currentState!.validate();
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
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: hSpaceLargevv,
                            ),
                            SizedBox(
                                height: SizeConfig.scaleHeight(50),
                                width:SizeConfig.scaleWidth(50),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                  progress == true
                                   ? indicator_nourah_loading() : Column(),
                                    done == true
                                        ? indicator_nourah_done()
                                        : Column()
                                  ],
                                ))
                          ],
                        ),
                        divider_app(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: fIconSmall,
                                  color: kSecondaryColor,
                                ),
                                StyleText(
                                  AppLocalizations.of(context)!.walletInfo,
                                ),
                              ],
                            ),
                            StyleText(
                              "${controller.profile['credit'] ?? ""}  ${AppLocalizations.of(context)!.reyal}    ",
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
    if (_pickedFile != null) setState(() {});
  }

  Future updateProfile() async {

  await  controller.updateProfile(
        path2:_pickedFile !=null ?_pickedFile!.path:null,
        path1:_pickedFile !=null ?_pickedFile!.path:null,
        notes: "",
        ennotes: "",
        name: _nameinfo.text,
        email: _emailinfo.text,
        phone: _phoneNumberinfo.text, uploadEvent: (bool status) {
      if (status) {

      }
    }, context: context, minimum_order: '');

  }
}
