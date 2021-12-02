import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/drop_down_list.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/family_controller/products_family_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Add extends StatefulWidget {

  @override
  _AddState createState() => _AddState();
}
class _AddState extends State<Add> {
  getProductsFamilyGetx controller = Get.find();

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
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    offerDuration.dispose();
    price.dispose();
    nameEn.dispose();
    _fromController.dispose();
    thePriceAfter.dispose();
    _toController.dispose();
  }
  PickedFile? _pickedFile2;
  PickedFile? _pickedFile1;
  ImagePicker imagePicker = ImagePicker();
  var _formKey=GlobalKey<FormState>();


  String? valueChooseDuration ;
  String? valueChooseOffer ;

int categoryId=1000;
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
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: wPadding,
        end: wPadding,
        top: hPadding,
        bottom: hPadding,
      ),
      child: SingleChildScrollView(
        child: Form(
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
                                                           SizedBox(height:SizeConfig.scaleHeight(200),),
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
                  // fontSize: fLarge,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: hSpaceLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await pickImage1();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        child: _pickedFile1 != null
                            ? CircleAvatar(
                                backgroundImage: AssetImage(_pickedFile1!.path),
                                radius: 70,
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/cover.jpeg'),
                                radius: 70,
                              )),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await pickImage2();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        child: _pickedFile2 != null
                            ? CircleAvatar(
                                backgroundImage: AssetImage(_pickedFile2!.path),
                                radius: 70,
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/cover.jpeg'),
                                radius: 70,
                              )),
                  ),
                ],
              ),
              divider_app(height: hSpaceLargevv),
              SizedBox(
                height: SizeConfig.scaleHeight(150),
                child: StyleField(
                  controller: _arabicdes,
                  title: AppLocalizations.of(context)!.arabicDescription,
                  prefixIcon: Icon(Icons.event_note),
                  isRequired: true,
                  maxLines: 5,
                  padding: 20,
                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(20),
              ), SizedBox(
              height: SizeConfig.scaleHeight(150),
              child:  StyleField(
                controller: _englishdes,
                title: "* ${AppLocalizations.of(context)!.englishDescription}",
                prefixIcon: Icon(Icons.event_note),
                padding: 20,
                maxLines: 5,
              ),),
              divider_app(height: hSpaceLargevv),
              StyleField(
                title: "      ${AppLocalizations.of(context)!.price}",
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
                        isRequired: true,
                        controller: _toController,
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
                  "*  ${AppLocalizations.of(context)!.addOffer}         (${AppLocalizations.of(context)!.optional})                ",
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 4,

                          child: StyleField(
                            title: "* ${AppLocalizations.of(context)!.offerDuration}",
                            keyboardType: TextInputType.number,
                            controller: offerDuration,
                            prefixIcon: Icon(Icons.lock_clock_outlined),
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
                      title: "* ${AppLocalizations.of(context)!.thePriceAfter}",
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
                    sideColor: kConfirm,
                    onPressed: () async {
                      // bool   isValidate=  _formKey.currentState!.validate() ;
                    // if(isValidate){
                      await addProduct();
                      FocusScope.of(context).unfocus();}

                    // },
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



  Future addProduct() async {

    if (_pickedFile1 == null && _pickedFile2 == null) {
      Helper(context: context, message: AppLocalizations.of(context)!.pleaseEnterImage, error: true);
    }else if(price.text.isEmpty ||
        _fromController.text.isEmpty ||
        _toController.text.isEmpty ||
        categoryId==1000||valueChooseDuration==null||
        _arabicdes.text.isEmpty ||
        name.text.isEmpty){

      Helper(context: context, message: AppLocalizations.of(context)!.pleaseEnterCorrectData, error: true);


    }else {
      setState(() {
        progress = true;
        done = false;
      });
      {
        controller.addProduct(context,
            path2:_pickedFile2 !=null ?_pickedFile2!.path:null,
            path1:_pickedFile1 !=null ?_pickedFile1!.path:null,
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
            offer_price: thePriceAfter.text, uploadEvent: (bool status)
        { setState(() {
          progress = false;
          done = true;
        });

        }, );}}

          }
        }
