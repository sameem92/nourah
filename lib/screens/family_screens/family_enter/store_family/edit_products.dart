import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/components/drop_down_list.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

class EditProducts extends StatefulWidget {
  int index;
  EditProducts({this.index = 0});
  @override
  _EditProductsState createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  getProductsFamilyGetx controller = Get.find();
  bool progress = false;
  bool done = false;
  String? valueChooseOffer ;
  String? valueChooseDuration ;





  int categoryId=1000;
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
    // valueChooseDuration=controller.productsFamily[widget.index].durationUnit!=null || controller.productsFamily[widget.index].durationUnit!="" ||controller.productsFamily[widget.index].durationUnit.isNotEmpty ?controller.productsFamily[widget.index].durationUnit=="h"?AppLocalizations.of(context)!.hour:controller.productsFamily[widget.index].durationUnit=="m"?AppLocalizations.of(context)!.minute:AppLocalizations.of(context)!.day:"";
    // valueChooseOffer=controller.productsFamily[widget.index].offerDurationUnit=="h"?AppLocalizations.of(context)!.hour:controller.productsFamily[widget.index].offerDurationUnit=="m"?AppLocalizations.of(context)!.minute:AppLocalizations.of(context)!.day;
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
        text: "${controller.productsFamily[widget.index].offerPrice}");
    _arabicdes = TextEditingController(
        text: "${controller.productsFamily[widget.index].ardesc}");
    _englishdes = TextEditingController(
        text: "${controller.productsFamily[widget.index].endesc}");
    offerDuration = TextEditingController(
        text: "${controller.productsFamily[widget.index].offerDuration}");

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
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    price.dispose();
    nameEn.dispose();
    offerDuration.dispose();
    _fromController.dispose();
    thePriceAfter.dispose();
    _toController.dispose();
  }

  PickedFile? _pickedFile2;
  PickedFile? _pickedFile1;
  var _formKey = GlobalKey<FormState>();

  ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    List listItem = [
      // "يوم",
      // "دقيقة",
      // "ساعة",
      AppLocalizations.of(context)!.day,
      AppLocalizations.of(context)!.minute,
      AppLocalizations.of(context)!.hour,
    ];
    return Scaffold(
      appBar: AppBarWhite(
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
        child: GetX<getProductsFamilyGetx>(
          init: getProductsFamilyGetx(language: Localizations.localeOf(context).languageCode == "ar"
              ? "ar"
              : "en"),
            builder: (getProductsFamilyGetx controller) {
              return SingleChildScrollView(
                child: controller.isLoading.value
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                                width: SizeConfig.scaleWidth(360),
                                height:  SizeConfig.scaleHeight(50),
                                child:
                                StyleButton(AppLocalizations.of(context)!.productCategory,
                                  backgroundColor: kSpecialColor,onPressed: (){
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder: (context,setState){
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
                                                        child:
                                                        GetX<getCategoriesFamilyGetx>(
                                                            init: getCategoriesFamilyGetx(),
                                                            builder: (getCategoriesFamilyGetx controller) {
                                                              return
                                                                controller.isLoading.value
                                                                    ? Column(
                                                                  children: [
                                                                    SizedBox(height: SizeConfig.scaleHeight(200),),
                                                                    Center(child: CircularProgressIndicator.adaptive()),
                                                                  ],
                                                                )
                                                                    : controller.categoriesFamily.length != 0
                                                                    ?
                                                                SizedBox(
                                                                  width: SizeConfig.scaleWidth(250),
                                                                  child: ListView.builder(
                                                                      shrinkWrap: true,
                                                                      scrollDirection: Axis.vertical,
                                                                      itemCount: controller.categoriesFamily.length,
                                                                      itemBuilder: (context, index) {
                                                                        return
                                                                          Row(
                                                                            children: [
                                                                              SizedBox(
                                                                                width: SizeConfig.scaleWidth(200),
                                                                                child: RadioListTile(
                                                                                  title:
                                                                                  Localizations.localeOf(context).languageCode=="ar"?
                                                                                  StyleText(controller
                                                                                      .categoriesFamily[index]
                                                                                      .arname!=""?
                                                                                  '${controller.categoriesFamily[index].arname}':"${controller.categoriesFamily[index].enname}",
                                                                                  )
                                                                                      :   StyleText(controller
                                                                                      .categoriesFamily[index]
                                                                                      .enname!=""?
                                                                                  '${controller.categoriesFamily[index].enname}':"${controller.categoriesFamily[index].arname}",
                                                                                  ),

                                                                                  activeColor: kConfirm,
                                                                                  dense: true,

                                                                                  value: categoryId,
                                                                                  groupValue: controller.categoriesFamily[index].id,

                                                                                  onChanged: (int? value) {



                                                                                    if (mounted) {
                                                                                      setState(() {
                                                                                        categoryId=controller.categoriesFamily[index].id!;
                                                                                        print(categoryId);
                                                                                      });
                                                                                      setState(() {

                                                                                      });
                                                                                    }
                                                                                  },
                                                                                ),
                                                                              ),

                                                                            ],
                                                                          );
                                                                      }),
                                                                )
                                                                    : noContent(context,
                                                                    AppLocalizations.of(context)!.thereIsnoCategories,
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
                                  },)

                            ),

                            SizedBox(
                              height: hSpace,
                            ),
                            StyleField(
                              title: "اسم المنتج",
                              hintText: controller
                                  .productsFamily[widget.index].arname,
                              controller: name,
                              prefixIcon: Icon(Icons.drive_file_rename_outline),
                              isRequired: true,
                            ),
                            SizedBox(
                              height: hSpace,
                            ),
                            StyleField(
                              title: "*  product name",
                              controller: nameEn,
                              prefixIcon: Icon(Icons.drive_file_rename_outline),
                            ),
                            divider_app(height: hSpaceLargevv),
                            SizedBox(
                              width: double.infinity,
                              child: StyleText(
                                AppLocalizations.of(context)!.productImages,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: hSpace,
                            ),

                            SizedBox(
                              width: double.infinity,
                              height: SizeConfig.scaleHeight(150),
                              child:
                                    Row(
                                            children: [

                                              Expanded(

                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await pickImage1();
                                                  },
                                                  child:
                                                    _pickedFile1 != null
                                                        ? CircleAvatar(

                                                            backgroundImage:
                                                                AssetImage(
                                                                    _pickedFile1!
                                                                        .path),

                                                            radius: SizeConfig.scaleTextFont(70),
                                                          )
                                                        :
                                                    image_circle(
                                                         imageString:
                                                         controller
                                                             .productsFamily[
                                                         widget.index]
                                                             .images!.length !=0
                                                             ?
                                                         controller
                                                                .productsFamily[
                                                                    widget.index]
                                                                .images![0]
                                                                .image
                                                         :"",
                                                            radius: 70,
                                                          ),
                                                  ),
                                              ),

                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await pickImage2();
                                                  },
                                                  child:
                                                  _pickedFile2 != null
                                                      ? CircleAvatar(

                                                    backgroundImage:
                                                    AssetImage(
                                                        _pickedFile2!
                                                            .path),

                                                    radius: SizeConfig.scaleTextFont(70),
                                                  )
                                                      :
                                                  controller.productsFamily[widget.index]
                                                              .images!.length !=
                                                          1 ?  image_circle(
                                                    imageString:
                                                    controller
                                                        .productsFamily[
                                                    widget.index]
                                                        .images!.length ==2
                                                        ?
                                                    controller
                                                        .productsFamily[
                                                    widget.index]
                                                        .images![1]
                                                        .image:"",
                                                    radius: 70,
                                                  ):CircleAvatar(

                                                    backgroundImage:
                                                    AssetImage(
                                                        'assets/images/cover.jpeg'),

                                                    radius: SizeConfig.scaleTextFont(70),
                                                  )
                                                ),
                                              ),

                            ],
                                    ),
                            ),

                            divider_app(height: hSpaceLargevv),
                            SizedBox(
                              height: SizeConfig.scaleHeight(150),
                              child: StyleField(
                                controller: _arabicdes,
                                title: AppLocalizations.of(context)!
                                    .arabicDescription,
                                prefixIcon: Icon(Icons.event_note),
                                maxLines: 5,
                                isRequired: true,
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
                                    "* ${AppLocalizations.of(context)!.englishDescription}",
                                prefixIcon: Icon(Icons.event_note),
                                padding: 20,
                                maxLines: 5,
                              ),
                            ),
                            divider_app(height: hSpaceLargevv),
                            StyleField(
                              title:
                                  "      ${AppLocalizations.of(context)!.price}",
                              prefixIcon: Icon(Icons.price_change_outlined),
                              suffixText: AppLocalizations.of(context)!.reyal,
                              isRequired: true,
                              keyboardType: TextInputType.number,
                              controller: price,
                            ),
                            divider_app(height: hSpaceLargevv),
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
                                    isRequired: true,
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
                                    isRequired: true,
                                  ),
                                ),
                                SizedBox(
                                  width: wSpace,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                      height: SizeConfig.scaleWidth(60),
                                      child: ContainerApp(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: wSpace, right: wSpace),
                                          child: DropdownButton<String>(

                                            dropdownColor: Colors.white,
                                            elevation:1,
                                            underline: SizedBox(),
                                            style: TextStyle(
                                              fontFamily: "ElMessiri",
                                              color: kPrimaryColor,
                                            ),
                                            icon: Icon(Icons.arrow_drop_down_sharp),
                                            iconSize: fIcon,
                                            isExpanded: true,
                                            value:valueChooseDuration,
                                            onChanged: (newValue) {
                                              setState(() {
                                                this.valueChooseDuration = newValue.toString();
                                              });

                                            },
                                            items:listItem.map<DropdownMenuItem<String>>((valueItem) {
                                              return DropdownMenuItem(

                                                  value: valueItem, child: StyleText(valueItem));
                                            }).toList(),
                                          ),
                                        ),

                                      )),
                                ),
                              ],
                            ),
                            divider_app(height: hSpaceLargevv),
                            SizedBox(
                              width: double.infinity,
                              child: StyleText(
                                "*  ${AppLocalizations.of(context)!.addOffer}    (${AppLocalizations.of(context)!.optional})                ",
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: hSpace,
                            ),
                            Column(
                              children: [
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
                                        prefixIcon:
                                            Icon(Icons.lock_clock_outlined),
                                      ),
                                    ),
                                    SizedBox(
                                      width: wSpace,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                          height: SizeConfig.scaleWidth(60),
                                          child: ContainerApp(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: wSpace, right: wSpace),
                                              child: DropdownButton<String>(

                                                dropdownColor: Colors.white,
                                                elevation: 1,
                                                underline: SizedBox(),
                                                style: TextStyle(
                                                  fontFamily: "ElMessiri",
                                                  color: kPrimaryColor,
                                                ),
                                                icon: Icon(Icons.arrow_drop_down_sharp),
                                                iconSize: fIcon,
                                                isExpanded: true,
                                                value:valueChooseOffer,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    this.valueChooseOffer = newValue.toString();
                                                  });

                                                },
                                                items:listItem.map<DropdownMenuItem<String>>((valueItem) {
                                                  return DropdownMenuItem(

                                                      value: valueItem, child: StyleText(valueItem));
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
                                  prefixIcon: Icon(Icons.price_change_outlined),
                                  controller: thePriceAfter,
                                ),
                                SizedBox(
                                  height: hSpace,
                                ),
                                divider_app(height: hSpaceLargevv),
                                StyleButton(
                                    AppLocalizations.of(context)!.saveinfo,
                                    backgroundColor: kConfirm,
                                    sideColor: kConfirm, onPressed: () async {
                                      FocusScope.of(context).unfocus();
                                  await editProduct(
                                      product_id:
                                          controller.productsFamily[widget.index].id);

                                }

                                    ),
                                SizedBox(
                                  height: hSpace,
                                ),
                                progress == true||done == true
                                    ?  Column(
                                  children: [
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
                                                : Column(),

                                          ],
                                        )),
                                    SizedBox(
                                      height: hSpaceLarge,
                                    ),
                                  ],
                                ):Column()


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

  Future pickImage1() async {
    _pickedFile1 = await imagePicker.getImage(source: ImageSource.gallery);
    if (_pickedFile1 != null) setState(() {});
  }

  Future pickImage2() async {
    _pickedFile2 = await imagePicker.getImage(source: ImageSource.gallery);
    if (_pickedFile2 != null) setState(() {});
  }

  Future editProduct({required int product_id }) async {
    if  (price.text.isEmpty ||
        _fromController.text.isEmpty ||
        _toController.text.isEmpty ||
        _arabicdes.text.isEmpty ||valueChooseDuration==null||
        name.text.isEmpty) {
      Helper(
          context: context,
          message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
          error: true);
    } else {

      setState(() {
        progress = true;
        done = false;
      });
      {


          await  controller.editProduct(
            context,
language:  Localizations.localeOf(context).languageCode == "ar"
     ? "ar"
     : "en",
            product_id: product_id,
            image_id:controller.productsFamily[widget.index].images!.length==1?
                "${controller.productsFamily[widget.index].images![0].id}":controller.productsFamily[widget.index].images!.length!=0?"${controller.productsFamily[widget.index].images![0].id},${controller.productsFamily[widget.index].images![1].id}":"",
            path2: _pickedFile2 != null ? _pickedFile2!.path : null,
            path1: _pickedFile1 != null ? _pickedFile1!.path : null,
            ardesc: _arabicdes.text,
            arname: name.text,
              category: categoryId,
            duration_from: _fromController.text,
            duration_to: _toController.text,
              duration_unit:  valueChooseDuration==AppLocalizations.of(context)!.hour ?'h':valueChooseDuration==AppLocalizations.of(context)!.minute?"m":"d",
              enname: nameEn.text,
            price: price.text,
            endesc: _englishdes.text,
              offer_duration_unit: valueChooseOffer==AppLocalizations.of(context)!.hour ?'h':valueChooseOffer==AppLocalizations.of(context)!.minute?"m":"d",
              offer_duration: offerDuration.text,


            offer_price: thePriceAfter.text,
              uploadEvent: (bool status) {
          if (status) {
            setState(() {
              progress = false;
              done = true;
              Navigator.pop(context, );
            });
          }
        });
      }
    }
  }
}
