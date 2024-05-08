import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

class EditProducts extends StatefulWidget {
  final int index;
  const EditProducts({this.index = 0});
  @override
  _EditProductsState createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  GetProductsFamilyGetx controller = Get.find();
  GetMainCategoriesFamilyGetx controller2 =
      Get.put(GetMainCategoriesFamilyGetx());

  bool progress = false;
  bool done = false;
  String? valueChooseOffer;
  String? valueChooseDuration;

  String? offerUnit;
  String? unit;
  int categoryId = 1000;
  late TextEditingController _arabicdes;
  late TextEditingController _englishdes;
  late TextEditingController offerDuration;

  late TextEditingController name;
  late TextEditingController nameEn;
  late TextEditingController price;
  late TextEditingController _fromController;
  late TextEditingController _toController;
  late TextEditingController thePriceAfter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!mounted) {
    } else {
      setState(() {
        offerUnit = controller.productsFamily[widget.index].offerDurationUnit;
        unit = controller.productsFamily[widget.index].durationUnit;
      });
    }
    name = TextEditingController(
        text: controller.productsFamily[widget.index].arname);
    nameEn = TextEditingController(
        text: controller.productsFamily[widget.index].enname);
    price = TextEditingController(
        text: "${controller.productsFamily[widget.index].price}");
    _fromController = TextEditingController(
        text: "${controller.productsFamily[widget.index].durationFrom}");
    _toController = TextEditingController(
        text: "${controller.productsFamily[widget.index].durationTo}");
    thePriceAfter = TextEditingController(
        text:
            "${controller.productsFamily[widget.index].offerPrice != 0 ? controller.productsFamily[widget.index].offerPrice : ""}");
    _arabicdes = TextEditingController(
        text: controller.productsFamily[widget.index].ardesc);
    _englishdes = TextEditingController(
        text: controller.productsFamily[widget.index].endesc);
    offerDuration = TextEditingController(
        text:
            "${controller.productsFamily[widget.index].offerDuration != 0 ? controller.productsFamily[widget.index].offerDuration : ""}");

    name.addListener(() => setState(() {}));
    nameEn.addListener(() => setState(() {}));
    _fromController.addListener(() => setState(() {}));
    _toController.addListener(() => setState(() {}));
    thePriceAfter.addListener(() => setState(() {}));
    _arabicdes.addListener(() => setState(() {}));
    _englishdes.addListener(() => setState(() {}));
    offerDuration.addListener(() => setState(() {}));
    price.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    nameEn.dispose();
    offerDuration.dispose();
    _fromController.dispose();
    thePriceAfter.dispose();
    _toController.dispose();
    super.dispose();
  }

  PickedFile? _pickedFile1;
  CroppedFile? _croppedFile1;
  final _formKey = GlobalKey<FormState>();

  ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    categoryId = GetProductsFamilyGetx.to.productsFamily[widget.index].category;
    String unit2 = unit != null || unit != ""
        ? unit == "h"
            ? AppLocalizations.of(context)!.hour
            : unit == "m"
                ? AppLocalizations.of(context)!.minute
                : AppLocalizations.of(context)!.day
        : "";
    String offerUnit2 = offerUnit != null || offerUnit != ""
        ? offerUnit == "h"
            ? AppLocalizations.of(context)!.hour
            : offerUnit == "m"
                ? AppLocalizations.of(context)!.minute
                : offerUnit == "d"
                    ? AppLocalizations.of(context)!.day
                    : ""
        : "";

    List listItem = [
      AppLocalizations.of(context)!.day,
      AppLocalizations.of(context)!.minute,
      AppLocalizations.of(context)!.hour,
      "",
    ];
    List listItemOffer = [
      AppLocalizations.of(context)!.day,
      AppLocalizations.of(context)!.hour,
      "",
    ];

    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.edit,
        onPressed: () {},
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: wSpace,
          end: wSpace,
          top: hPadding,
          bottom: hPadding,
        ),
        child: GetX<GetProductsFamilyGetx>(
            init: GetProductsFamilyGetx(
                language: Localizations.localeOf(context).languageCode == "ar"
                    ? "ar"
                    : "en"),
            builder: (GetProductsFamilyGetx controller) {
              return SingleChildScrollView(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                                width: SizeConfig.scaleWidth(360),
                                height: SizeConfig.scaleHeight(50),
                                child: StyleButton(
                                  AppLocalizations.of(context)!
                                      .productSubCategory,
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                SizeConfig.scaleHeight(
                                                    borderRadius),
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
                                                        height: SizeConfig
                                                            .scaleHeight(200),
                                                        child: GetX<
                                                                GetCategoriesFamilyGetx>(
                                                            init:
                                                                GetCategoriesFamilyGetx(),
                                                            builder:
                                                                (GetCategoriesFamilyGetx
                                                                    controller) {
                                                              return controller
                                                                      .isLoading
                                                                      .value
                                                                  ? Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              SizeConfig.scaleHeight(200),
                                                                        ),
                                                                        const Center(
                                                                            child:
                                                                                CircularProgressIndicator.adaptive()),
                                                                      ],
                                                                    )
                                                                  : controller
                                                                          .categoriesFamily
                                                                          .isNotEmpty
                                                                      ? SizedBox(
                                                                          width:
                                                                              SizeConfig.scaleWidth(250),
                                                                          child: ListView.builder(
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              itemCount: controller.categoriesFamily.length,
                                                                              itemBuilder: (context, index) {
                                                                                return Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: SizeConfig.scaleWidth(200),
                                                                                      child: RadioListTile(
                                                                                        title: Localizations.localeOf(context).languageCode == "ar"
                                                                                            ? StyleText(
                                                                                                controller.categoriesFamily[index].arname != "" ? controller.categoriesFamily[index].arname : controller.categoriesFamily[index].enname,
                                                                                              )
                                                                                            : StyleText(
                                                                                                controller.categoriesFamily[index].enname != "" ? controller.categoriesFamily[index].enname : controller.categoriesFamily[index].arname,
                                                                                              ),
                                                                                        activeColor: kConfirm,
                                                                                        dense: true,
                                                                                        value: categoryId,
                                                                                        groupValue: controller.categoriesFamily[index].id,
                                                                                        onChanged: (int? value) {
                                                                                          if (mounted) {
                                                                                            setState(() {
                                                                                              categoryId = controller.categoriesFamily[index].id!;

                                                                                              print(GetProductsFamilyGetx.to.productsFamily[widget.index].category);
                                                                                            });
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
                                                                          AppLocalizations.of(context)!
                                                                              .thereIsnoCategories,
                                                                          height:
                                                                              0);
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
                              hintText: controller
                                  .productsFamily[widget.index].arname,
                              controller: name,
                              prefixIcon:
                                  const Icon(Icons.drive_file_rename_outline),
                              // isRequired: true,
                            ),
                            SizedBox(
                              height: hSpace,
                            ),
                            StyleField(
                              title:
                                  "*  product name (${AppLocalizations.of(context)!.optional})",
                              controller: nameEn,
                              prefixIcon:
                                  const Icon(Icons.drive_file_rename_outline),
                            ),
                            dividerApp(height: hSpaceLargevv),
                            SizedBox(
                              width: double.infinity,
                              child: StyleText(
                                AppLocalizations.of(context)!.productImages,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await pickImage1();
                              },
                              child: _croppedFile1 != null
                                  ? FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            AssetImage(_croppedFile1!.path),
                                        radius: SizeConfig.scaleTextFont(70),
                                      ),
                                    )
                                  : ImageCircle(
                                      imageString: controller
                                                  .productsFamily[widget.index]
                                                  .images!
                                                  .length ==
                                              1
                                          ? controller
                                              .productsFamily[widget.index]
                                              .images![0]
                                              .image
                                          : "",
                                      radius: 70,
                                    ),
                            ),
                            dividerApp(height: hSpaceLargevv),
                            SizedBox(
                              height: SizeConfig.scaleHeight(150),
                              child: StyleField(
                                controller: _arabicdes,
                                title: AppLocalizations.of(context)!
                                    .arabicDescription,
                                prefixIcon: const Icon(Icons.event_note),
                                maxLines: 5,
                                // isRequired: true,
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
                              title:
                                  "      ${AppLocalizations.of(context)!.price}",
                              prefixIcon:
                                  const Icon(Icons.price_change_outlined),
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
                                    title:
                                        "  ${AppLocalizations.of(context)!.from}",
                                  ),
                                ),
                                SizedBox(
                                  width: wSpace,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: StyleField(
                                    keyboardType: TextInputType.number,
                                    title:
                                        "  ${AppLocalizations.of(context)!.to}",
                                    controller: _toController,
                                    // isRequired: true,
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
                                            value: valueChooseDuration ?? unit2,
                                            onChanged: (newValue) {
                                              if (!mounted) {
                                              } else {
                                                setState(() {
                                                  valueChooseDuration =
                                                      newValue.toString();
                                                });
                                              }
                                            },
                                            items: listItem
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: StyleField(
                                            title:
                                                "* ${AppLocalizations.of(context)!.offerDuration}",
                                            keyboardType: TextInputType.number,
                                            controller: offerDuration,
                                            prefixIcon: const Icon(
                                                Icons.lock_clock_outlined),
                                            // onPressedClose: (){
                                            //   offerDuration.text="0";
                                            // },
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
                                                      left: wSpace,
                                                      right: wSpace),
                                                  child: DropdownButton<String>(
                                                    dropdownColor: Colors.white,
                                                    elevation: 1,
                                                    underline: const SizedBox(),
                                                    style: TextStyle(
                                                      fontFamily: "ElMessiri",
                                                      color: kSpecialColor,
                                                    ),
                                                    icon: const Icon(Icons
                                                        .arrow_drop_down_sharp),
                                                    iconSize: fIcon,
                                                    isExpanded: true,
                                                    value: valueChooseOffer ??
                                                        offerUnit2,
                                                    onChanged: (newValue) {
                                                      if (!mounted) {
                                                      } else {
                                                        setState(() {
                                                          valueChooseOffer =
                                                              newValue
                                                                  .toString();
                                                        });
                                                      }
                                                    },
                                                    items: listItemOffer.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (valueItem) {
                                                      return DropdownMenuItem(
                                                          value: valueItem,
                                                          child: StyleText(
                                                              valueItem));
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
                                      prefixIcon: const Icon(
                                          Icons.price_change_outlined),
                                      controller: thePriceAfter,
                                      // onPressedClose: (){
                                      //   thePriceAfter.text="0";
                                      // },
                                    ),
                                    SizedBox(
                                      height: hSpace,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            progress != true
                                ? dividerApp(height: hSpaceLargevv)
                                : const SizedBox(),
                            progress != true
                                ? StyleButton(
                                    AppLocalizations.of(context)!.saveinfo,
                                    backgroundColor: kConfirm,
                                    sideColor: kConfirm, onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    await editProduct(
                                        productId: controller
                                            .productsFamily[widget.index].id);
                                  })
                                : const SizedBox(),
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
                                              done == true
                                                  ? indicatorNourahDone()
                                                  : Column(),
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
              );
            }),
      ),
    );
  }

  Future pickImage1() async {
    _pickedFile1 = await imagePicker.getImage(source: ImageSource.gallery);
    if (_pickedFile1 != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile1!.path,
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 70,
        maxWidth:SizeConfig.scaleWidth(410).toInt(),
        maxHeight:SizeConfig.scaleHeight(200).toInt(),
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
      setState(() {
        _croppedFile1 = croppedFile;
      });
    }
  }

  Future editProduct({required int productId}) async {
    String unitDuration = valueChooseDuration != null
        ? valueChooseDuration == AppLocalizations.of(context)!.hour
            ? 'h'
            : valueChooseDuration == AppLocalizations.of(context)!.day
                ? "d"
                : "m"
        : controller.productsFamily[widget.index].durationUnit;

    String unitOfferDuration = valueChooseOffer != null
        ? valueChooseOffer == AppLocalizations.of(context)!.hour
            ? 'h'
            : valueChooseOffer == AppLocalizations.of(context)!.day
                ? "d"
                : "m"
        : controller.productsFamily[widget.index].offerDurationUnit;

    if (price.text.isEmpty ||
        _fromController.text.isEmpty ||
        _toController.text.isEmpty ||
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
      setState(() {
        progress = true;
        done = false;
      });
      {
        print('brand  ${controller2.mainCategoriesFamily[0].id}');
        offerDuration.text != "" &&
                thePriceAfter.text != "" &&
                thePriceAfter.text.isNotEmpty &&
                offerDuration.text.isNotEmpty
            ? int.parse(thePriceAfter.text) < int.parse(price.text) &&
                    int.parse(offerDuration.text) != 0 &&
                    int.parse(thePriceAfter.text) != 0
                ? await controller.editProduct(context,
                    language:
                        Localizations.localeOf(context).languageCode == "ar"
                            ? "ar"
                            : "en",
                    productId: productId,
                    imageId: _croppedFile1 != null
                        ? controller
                                .productsFamily[widget.index].images!.isNotEmpty
                            ? controller
                                .productsFamily[widget.index].images![0].id
                            : 0
                        : 1000,
                    path1: _croppedFile1 != null ? _croppedFile1!.path : null,
                    ardesc: _arabicdes.text,
                    arname: name.text,
                    category: categoryId != 1000
                        ? categoryId
                        : controller.productsFamily[widget.index].category,
                    durationFrom: int.parse(_fromController.text),
                    durationTo: int.parse(_toController.text),
                    durationUnit: unitDuration,
                    enname: nameEn.text,
                    price: int.parse(price.text),
                    endesc: _englishdes.text,
                    brand: controller2.mainCategoriesFamily[0].id,
                    offerDurationUnit: unitOfferDuration,
                    offerDuration: int.parse(offerDuration.text),
                    offerPrice: double.parse(thePriceAfter.text),
                    offerStatus: int.parse("1"), uploadEvent: (bool status) {
                    if (status) {
                      correctData();
                    }
                  })
                : errorData()
            : await controller.editProductWithouSale(context,
                language: Localizations.localeOf(context).languageCode == "ar"
                    ? "ar"
                    : "en",
                productId: productId,
                imageId: _croppedFile1 != null
                    ? controller.productsFamily[widget.index].images!.isNotEmpty
                        ? controller.productsFamily[widget.index].images![0].id
                        : 0
                    : 1000,
                path1: _croppedFile1 != null ? _croppedFile1!.path : null,
                ardesc: _arabicdes.text,
                arname: name.text,
                category: categoryId != 1000
                    ? categoryId
                    : controller.productsFamily[widget.index].category,
                durationFrom: int.parse(_fromController.text),
                durationTo: int.parse(_toController.text),
                durationUnit: unitDuration,
                enname: nameEn.text,
                price: int.parse(price.text),
                endesc: _englishdes.text,
                brand: controller2.mainCategoriesFamily[0].id,
                uploadEvent: (bool status) {
                if (status) {
                  correctData();
                }
              });
      }
    }
  }

  void errorData() {
    helper(
        context: context,
        message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
        error: true);
    setState(() {
      progress = false;
    });
  }

  void correctData() {
    setState(() {
      progress = false;
      done = true;
    });
  }
}
