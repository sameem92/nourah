import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  GetProductsFamilyGetx controller = Get.find();
  GetMainCategoriesFamilyGetx controller2 =
      Get.put(GetMainCategoriesFamilyGetx());
  bool progress = false;
  bool done = false;
  late TextEditingController _arabicdes;
  late TextEditingController _englishdes;
  late TextEditingController name;
  late TextEditingController nameEn;
  late TextEditingController _fromController;
  late TextEditingController _toController;
  late TextEditingController thePriceAfter;
  late TextEditingController price;
  late TextEditingController offerDuration;
  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    price = TextEditingController();
    nameEn = TextEditingController();
    _fromController = TextEditingController();
    _toController = TextEditingController();
    thePriceAfter = TextEditingController();
    _arabicdes = TextEditingController();
    _englishdes = TextEditingController();
    offerDuration = TextEditingController();
    _arabicdes.addListener(() => setState(() {}));
    price.addListener(() => setState(() {}));
    _englishdes.addListener(() => setState(() {}));
    name.addListener(() => setState(() {}));
    nameEn.addListener(() => setState(() {}));
    _fromController.addListener(() => setState(() {}));
    _toController.addListener(() => setState(() {}));
    offerDuration.addListener(() => setState(() {}));
    thePriceAfter.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    name.dispose();
    offerDuration.dispose();
    price.dispose();
    nameEn.dispose();
    _fromController.dispose();
    thePriceAfter.dispose();
    _toController.dispose();
    super.dispose();
  }

  PickedFile? _pickedFile1;
  CroppedFile? _croppedFile1;
  ImagePicker imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  String? valueChooseDuration;
  String? valueChooseOffer;

  int categoryId = 1000;
  @override
  Widget build(BuildContext context) {
    List listItem = [
      AppLocalizations.of(context)!.day,
      AppLocalizations.of(context)!.minute,
      AppLocalizations.of(context)!.hour,
    ];
    List listItemOffer = [
      AppLocalizations.of(context)!.day,
      AppLocalizations.of(context)!.hour,
    ];
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: wSpace,
        end: wSpace,
        top: hPadding,
        bottom: hPadding,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: StyleText(
                  AppLocalizations.of(context)!.categoriesFirst,
                  fontWeight: FontWeight.w300,
                  fontSize: 17,
                  height: 1.3,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: hSpaceSmall,
              ),
              SizedBox(
                  width: SizeConfig.scaleWidth(360),
                  height: SizeConfig.scaleHeight(50),
                  child: StyleButton(
                    AppLocalizations.of(context)!.productSubCategory,
                    backgroundColor: kSpecialColor,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return AlertDialog(
                                scrollable: true,
                                backgroundColor: Colors.white,
                                titlePadding: EdgeInsets.zero,
                                actionsPadding: EdgeInsets.zero,
                                buttonPadding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                  SizeConfig.scaleHeight(borderRadius),
                                )),
                                content: Padding(
                                  padding: EdgeInsets.only(
                                    left: wPadding,
                                    right: wPadding,
                                    top: hPadding,
                                    bottom: hPadding,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(200),
                                          child: GetX<GetCategoriesFamilyGetx>(
                                              init: GetCategoriesFamilyGetx(),
                                              builder: (GetCategoriesFamilyGetx
                                                  controller) {
                                                return controller
                                                        .isLoading.value
                                                    ? Column(
                                                        children: [
                                                          SizedBox(
                                                            height: SizeConfig
                                                                .scaleHeight(
                                                                    200),
                                                          ),
                                                          const Center(
                                                              child: CircularProgressIndicator
                                                                  .adaptive()),
                                                        ],
                                                      )
                                                    : controller
                                                            .categoriesFamily
                                                            .isNotEmpty
                                                        ? SizedBox(
                                                            width: SizeConfig
                                                                .scaleWidth(
                                                                    250),
                                                            child: ListView
                                                                .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    scrollDirection:
                                                                        Axis
                                                                            .vertical,
                                                                    itemCount: controller
                                                                        .categoriesFamily
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                SizeConfig.scaleWidth(200),
                                                                            child:
                                                                                RadioListTile(
                                                                              title: Localizations.localeOf(context).languageCode == "ar"
                                                                                  ? StyleText(
                                                                                      controller.categoriesFamily[index].arname != "" ? controller.categoriesFamily[index].arname : controller.categoriesFamily[index].enname,
                                                                                    )
                                                                                  : StyleText(
                                                                                      controller.categoriesFamily[index].enname != "" ? controller.categoriesFamily[index].enname : controller.categoriesFamily[index].arname,
                                                                                    ),
                                                                              activeColor: kConfirm,
                                                                              dense: true,
                                                                              value: done != true ? categoryId : 1000,
                                                                              groupValue: controller.categoriesFamily[index].id,
                                                                              onChanged: (int? value) {
                                                                                if (mounted) {
                                                                                  setState(() {
                                                                                    categoryId = controller.categoriesFamily[index].id!;
                                                                                    print(categoryId);
                                                                                  });
                                                                                  setState(() {});
                                                                                }
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    }),
                                                          )
                                                        : noContent(
                                                            context,
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .thereIsnoCategories,
                                                            height: 0);
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                          });
                    },
                  )),
              SizedBox(
                height: hSpace,
              ),
              StyleField(
                title: "اسم المنتج",
                controller: name,
                prefixIcon: const Icon(Icons.drive_file_rename_outline),
                // isRequired: true,
              ),
              SizedBox(
                height: hSpace,
              ),
              StyleField(
                title:
                    "*  product name (${AppLocalizations.of(context)!.optional})",
                controller: nameEn,
                prefixIcon: const Icon(Icons.drive_file_rename_outline),
              ),
              dividerApp(height: hSpaceLargevv),
              SizedBox(
                width: double.infinity,
                child: StyleText(
                  AppLocalizations.of(context)!.productImages,
                  // fontSize: fLarge,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: hSpace,
              ),
              GestureDetector(
                onTap: () async {
                  await pickImage1();
                },
                child: Container(
                    alignment: Alignment.center,
                    child: _croppedFile1 != null
                        ? FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(_croppedFile1!.path),
                              radius: 70,
                            ),
                          )
                        : const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/cover.jpeg'),
                            radius: 70,
                          )),
              ),
              dividerApp(height: hSpaceLargevv),
              SizedBox(
                height: SizeConfig.scaleHeight(150),
                child: StyleField(
                  controller: _arabicdes,
                  title: AppLocalizations.of(context)!.arabicDescription,
                  prefixIcon: const Icon(Icons.event_note),
                  // isRequired: true,
                  maxLines: 5,
                  padding: 20,
                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(20),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(150),
                child: StyleField(
                  controller: _englishdes,
                  title:
                      "* ${AppLocalizations.of(context)!.englishDescription} (${AppLocalizations.of(context)!.optional})",
                  prefixIcon: const Icon(Icons.event_note),
                  padding: 20,
                  maxLines: 5,
                ),
              ),
              dividerApp(height: hSpaceLargevv),
              StyleField(
                title: "      ${AppLocalizations.of(context)!.price}",
                prefixIcon: const Icon(Icons.price_change_outlined),
                suffixText: AppLocalizations.of(context)!.reyal,
                // isRequired: true,
                keyboardType: TextInputType.number,
                controller: price,
              ),
              dividerApp(height: hSpaceLargevv),
              SizedBox(
                width: double.infinity,
                child: StyleText(
                  AppLocalizations.of(context)!.processingTime,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: hSpace,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: StyleField(
                      keyboardType: TextInputType.number,
                      controller: _fromController,
                      // isRequired: true,
                      title: "  ${AppLocalizations.of(context)!.from}",
                    ),
                  ),
                  SizedBox(
                    width: wSpace,
                  ),
                  Expanded(
                    flex: 2,
                    child: StyleField(
                      keyboardType: TextInputType.number,
                      title: "  ${AppLocalizations.of(context)!.to}",
                      // isRequired: true,
                      controller: _toController,
                    ),
                  ),
                  SizedBox(
                    width: wSpace,
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                        height: SizeConfig.scaleWidth(58),
                        child: ContainerApp(
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: wSpace, right: wSpace),
                            child: DropdownButton<String>(
                              dropdownColor: Colors.white,
                              elevation: 1,
                              underline: const SizedBox(),
                              style: TextStyle(
                                fontFamily: "ElMessiri",
                                color: kSpecialColor,
                              ),
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              iconSize: fIcon,
                              isExpanded: true,
                              value: valueChooseDuration,
                              onChanged: (newValue) {
                                if (!mounted) {
                                } else {
                                  setState(() {
                                    valueChooseDuration = newValue.toString();
                                  });
                                }
                              },
                              items: listItem
                                  .map<DropdownMenuItem<String>>((valueItem) {
                                return DropdownMenuItem(
                                    value: valueItem,
                                    child: StyleText(valueItem));
                              }).toList(),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              dividerApp(height: hSpaceLargevv),
              ContainerApp(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            StyleText(
                              "*  ${AppLocalizations.of(context)!.addOffer}            ",
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.start,
                            ),
                            StyleText(
                              "(${AppLocalizations.of(context)!.optional})                ",
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.start,
                              textColor: kSpecialColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: hSpace,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 4,
                                child: StyleField(
                                  title:
                                      "* ${AppLocalizations.of(context)!.offerDuration}",
                                  keyboardType: TextInputType.number,
                                  controller: offerDuration,
                                  prefixIcon:
                                      const Icon(Icons.lock_clock_outlined),
                                ),
                              ),
                              SizedBox(
                                width: wSpace,
                              ),
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                    height: SizeConfig.scaleWidth(58),
                                    child: ContainerApp(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: wSpace, right: wSpace),
                                        child: DropdownButton<String>(
                                          dropdownColor: Colors.white,
                                          elevation: 1,
                                          underline: const SizedBox(),
                                          style: TextStyle(
                                            fontFamily: "ElMessiri",
                                            color: kSpecialColor,
                                          ),
                                          icon: const Icon(
                                              Icons.arrow_drop_down_sharp),
                                          iconSize: fIcon,
                                          isExpanded: true,
                                          value: valueChooseOffer,
                                          onChanged: (newValue) {
                                            if (!mounted) {
                                            } else {
                                              setState(() {
                                                valueChooseOffer =
                                                    newValue.toString();
                                              });
                                            }
                                          },
                                          items: listItemOffer
                                              .map<DropdownMenuItem<String>>(
                                                  (valueItem) {
                                            return DropdownMenuItem(
                                                value: valueItem,
                                                child: StyleText(valueItem));
                                          }).toList(),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: hSpace,
                          ),
                          StyleField(
                            title:
                                "* ${AppLocalizations.of(context)!.thePriceAfter}",
                            width: SizeConfig.scaleWidth(380),
                            keyboardType: TextInputType.number,
                            prefixIcon: const Icon(Icons.price_change_outlined),
                            controller: thePriceAfter,
                          ),
                          SizedBox(
                            height: hSpace,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              progress != true
                  ? dividerApp(height: hSpaceLargevv)
                  : const SizedBox(),
              Row(
                children: [
                  progress != true
                      ? Expanded(
                          flex: 2,
                          child: StyleButton(
                              AppLocalizations.of(context)!.saveinfo,
                              backgroundColor: kConfirm,
                              sideColor: kConfirm, onPressed: () async {
                            await addProduct();
                            FocusScope.of(context).unfocus();
                          }),
                        )
                      : const SizedBox(),
                  SizedBox(
                    width: wSpace,
                  ),
                  Expanded(
                    child: StyleButton(
                        AppLocalizations.of(context)!.emptyFields,
                        backgroundColor: kGrey,
                        sideColor: kConfirm, onPressed: () async {
                      reloadData();
                    }),
                  )
                ],
              ),
              SizedBox(
                height: hSpace,
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
                                done == true ? indicatorNourahDone() : Column(),
                              ],
                            )),
                        SizedBox(
                          height: hSpaceLarge,
                        ),
                      ],
                    )
                  : Column()
            ],
          ),
        ),
      ),
    );
  }

  Future pickImage1() async {
    _pickedFile1 = await imagePicker.getImage(source: ImageSource.gallery);
    if (_pickedFile1 != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile1!.path,
        cropStyle: CropStyle.rectangle,
        maxWidth:SizeConfig.scaleWidth(410).toInt(),
        maxHeight:SizeConfig.scaleHeight(200).toInt(),

        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 70,
        aspectRatio: const CropAspectRatio(ratioX: 410, ratioY: 200),
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
          _croppedFile1 = croppedFile;
        });
      }
    }
  }

  Future addProduct() async {
    print("$categoryId   categoryId");
    if (_croppedFile1 == null) {
      helper(
          context: context,
          message: AppLocalizations.of(context)!.pleaseEnterImage,
          error: true);
    } else if (price.text.isEmpty ||
        _fromController.text.isEmpty ||
        _toController.text.isEmpty ||
        categoryId == 1000 ||
        valueChooseDuration == null ||
        _arabicdes.text.isEmpty ||
        name.text.isEmpty ||
        int.parse(_fromController.text) >= int.parse(_toController.text) ||
        int.parse(_fromController.text) == 0 ||
        int.parse(_toController.text) == 0 ||
        int.parse(price.text) == 0) {
      helper(
          context: context,
          message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
          error: true);
    } else {
      if (!mounted) {
      } else {
        setState(() {
          progress = true;
          done = false;
        });
      }
      {
        thePriceAfter.text.isNotEmpty &&
                offerDuration.text.isNotEmpty &&
                offerDuration.text.isNotEmpty
            ? int.parse(thePriceAfter.text) < int.parse(price.text) &&
                    int.parse(offerDuration.text) != 0 &&
                    int.parse(thePriceAfter.text) != 0
                ? controller.addProduct(
                    context,
                    brand: controller2.mainCategoriesFamily[0].id,
                    path1: _croppedFile1 != null ? _croppedFile1!.path : null,
                    ardesc: _arabicdes.text,
                    arname: name.text,
                    category: categoryId,
                    durationFrom: int.parse(_fromController.text),
                    durationTo: int.parse(_toController.text),
                    durationUnit: valueChooseDuration ==
                            AppLocalizations.of(context)!.hour
                        ? 'h'
                        : valueChooseDuration ==
                                AppLocalizations.of(context)!.minute
                            ? "m"
                            : valueChooseDuration ==
                                    AppLocalizations.of(context)!.day
                                ? "d"
                                : "",
                    enname: nameEn.text,
                    price: int.parse(price.text),
                    endesc: _englishdes.text,
                    offerDurationUnit:
                        valueChooseOffer == AppLocalizations.of(context)!.hour
                            ? 'h'
                            : valueChooseOffer ==
                                    AppLocalizations.of(context)!.minute
                                ? "m"
                                : "d",
                    offerDuration: int.parse(offerDuration.text),
                    offerPrice: int.parse(thePriceAfter.text),
                    offerStatus: int.parse("1"),
                    uploadEvent: (bool status) {
                      correctData();
                    },
                  )
                : errorData()
            : controller.addProductWithoutSale(
                context,
                brand: controller2.mainCategoriesFamily[0].id,
                path1: _croppedFile1 != null ? _croppedFile1!.path : null,
                ardesc: _arabicdes.text,
                arname: name.text,
                category: categoryId,
                durationFrom: int.parse(_fromController.text),
                durationTo: int.parse(_toController.text),
                durationUnit:
                    valueChooseDuration == AppLocalizations.of(context)!.hour
                        ? 'h'
                        : valueChooseDuration ==
                                AppLocalizations.of(context)!.minute
                            ? "m"
                            : "d",
                enname: nameEn.text,
                price: int.parse(price.text),
                endesc: _englishdes.text,
                uploadEvent: (bool status) {
                  correctData();
                },
              );
      }
    }
  }

  void clearContent() {
    FocusScope.of(context).unfocus();
    name.clear();
    price.clear();
    nameEn.clear();
    _fromController.clear();
    _toController.clear();
    thePriceAfter.clear();
    _arabicdes.clear();
    _englishdes.clear();
    offerDuration.clear();
  }

  void errorData() {
    helper(
        context: context,
        message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
        error: true);
    if (!mounted) {
    } else {
      setState(() {
        progress = false;
      });
    }
  }

  void correctData() {
    setState(() {
      progress = false;
      done = true;

      // _pickedFile1 = null;
      // categoryId = 1000;
      // clearContent();
    });
  }

  void reloadData() {
    setState(() {
      _croppedFile1 = null;
      categoryId = 1000;
      clearContent();
    });
  }
}

// print("offerDuration : ${offerDuration.text}");
// print("thePriceAfter : ${thePriceAfter.text}");
// print("brand : ${controller2.mainCategoriesFamily[0].id}");
// print("path1 : ${ _pickedFile1 != null ? _pickedFile1!.path : null}");
// print("ardesc : ${_arabicdes.text}");
// print("arname : ${name.text}");
// print("duration_from : ${int.parse(_fromController.text)}");
// print("duration_to : ${int.parse(_toController.text)}");
// print("categoryId : ${categoryId}");
// print("price : ${int.parse(price.text)}");
// print("enname : ${nameEn.text}");
// print("valueChooseDuration : ${valueChooseDuration}");
// print("Durationunit : ${valueChooseDuration == AppLocalizations.of(context)!.hour
//     ? 'h'
//     : valueChooseDuration ==
//     AppLocalizations.of(context)!.minute
//     ? "m"
//     : valueChooseDuration ==
//     AppLocalizations.of(context)!.day
//     ? "d"
//     : ""}");
// print("endesc : ${_englishdes.text}");
// print("offer_duration_unit : ${valueChooseOffer ==
//     AppLocalizations.of(context)!.hour
//     ? 'h'
//     : valueChooseOffer == AppLocalizations.of(context)!.minute
//     ? "m"
//     : "d"}");
// print("offer_duration : ${int.parse(offerDuration.text)}");
// setState(() {
//               progress = false;
//               done = true;
//             });
