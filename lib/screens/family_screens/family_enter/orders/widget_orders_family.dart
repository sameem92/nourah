import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/drop_down_list.dart';
import 'package:producer_family_app/components/row_product.dart';
import 'package:producer_family_app/screens/public_screens/reporting.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

class WidgetOrdersFamily extends StatefulWidget {
  bool end;
  bool current;
  bool waiting;
  int status;

  WidgetOrdersFamily({this.end = false,this.current = false,this.waiting = false, this.status = 0});

  @override
  _WidgetOrdersFamilyState createState() => _WidgetOrdersFamilyState();
}

class _WidgetOrdersFamilyState extends State<WidgetOrdersFamily> {
  late TextEditingController familyNotes;
  late TextEditingController processingTime;
  String? valueChooseDuration ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    familyNotes = TextEditingController();
    processingTime = TextEditingController();
    familyNotes.addListener(() => setState(() {}));
    processingTime.addListener(() => setState(() {}));

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    familyNotes.dispose();
    processingTime.dispose();
  }
  var _formKey=GlobalKey<FormState>();
  getOrderFamilyGetX controller = Get.put(getOrderFamilyGetX());
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
    return GetX<getOrderFamilyGetX>(
      init: getOrderFamilyGetX(
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      ),
      builder: (getOrderFamilyGetX controller) {
        return
          Padding(
          padding: EdgeInsetsDirectional.only(
            start: wPadding,
            end: wPadding,
            top: wPadding,
            bottom: wPadding,
          ),
          child: controller.isLoading.value
              ? Center(
                  child:  indicator_nourah_loading()

          )
              : controller.orders.length != 0
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index) {
                        return controller.orders[index].status == widget.status
                            ? ExpansionTile(
                          tilePadding: EdgeInsets.all(0),
                          title: ContainerApp(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: SizeConfig.scaleHeight(15),
                                bottom: SizeConfig.scaleHeight(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [
                                          StyleText(
                                            "${AppLocalizations.of(context)!.orderNumber}     ",
                                          ),
                                          StyleText(
                                            "${controller.orders[index].orderNo}",textColor: kSpecialColor,textDecoration: TextDecoration.underline,
                                          ),
                                        ],
                                      ),


                                  StyleText(
                                    controller.orders[index].createdAt,
                                  ),
                                  // if(current==true)
                                ],
                              ),
                            ),
                          ),
                          children: [
                            ContainerApp(
                              child: Form(
                                key: _formKey,

                                child: Column(
                                  children: [
                                    rowProductTitle(
                                      notFirst: false,
                                      text1: AppLocalizations.of(context)!.productName,
                                      text2: AppLocalizations.of(context)!.quantity,
                                      text3: AppLocalizations.of(context)!.price,
                                      text4: AppLocalizations.of(context)!.totalPrice,
                                    ),
                                    GetX<getOrderFamilyGetX>(
                                        init: getOrderFamilyGetX(
                                          language:
                                          Localizations.localeOf(context).languageCode == "ar"
                                              ? "ar"
                                              : "en",
                                        ),
                                        builder: (getOrderFamilyGetX controller) {
                                          return controller.isLoading.value
                                              ? Center(
                                            child: indicator_nourah_loading()
                                          )
                                              : controller.orders[index].orderDetails.length!=0?
                                          ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: controller.orders[index].orderDetails.length,
                                              itemBuilder: (context, indexx) {
                                                return rowProductTitle(
                                                  notFirst: false,
                                                  text1: controller
                                                      .orders[index].orderDetails[indexx].productname,
                                                  text2:
                                                  "${controller.orders[index].orderDetails[indexx].qty}",
                                                  text3:
                                                  "${controller.orders[index].orderDetails[indexx].productprice}",
                                                  text4:
                                                  "${controller.orders[index].orderDetails[indexx].total}",
                                                );
                                              })
                                             : Column();
                                        }),
                                    divider_app(height: hSpaceLargevv),
                                    Row(
                                      children: [
                                        StyleText(
                                          "${AppLocalizations.of(context)!.processingTime}  :",
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          width: wSpaceLarge,
                                        ),
                                        StyleText(
                                          "${controller.orders[index].orderDuration}   ${controller.orders[index].orderDurationUnit == "h" ? AppLocalizations.of(context)!.hour : "${controller.orders[index].orderDurationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                          textColor: kSpecialColor,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: hSpaceLarge,
                                    ),
                                    Row(
                                      children: [
                                        StyleText(
                                          "${AppLocalizations.of(context)!.orderCost}  :",
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          width: wSpaceLarge,
                                        ),
                                        StyleText(
                                          "${controller.orders[index].orderCost}   ${AppLocalizations.of(context)!.reyal}",
                                          textColor: kSpecialColor,
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                    divider_app(height: hSpaceLargevv),

                                    if (widget.current == true)
                                      Column(
                                        children: [

                                          SizedBox(
                                              width: double.infinity,
                                              child: StyleText(
                                                AppLocalizations.of(context)!.userNotes,
                                                textAlign: TextAlign.start,
                                              )),
                                          SizedBox(
                                            height: hSpace,
                                          ),
                                          notes(
                                            note: controller.orders[index].clientNotes,
                                          ),
                                          SizedBox(
                                            height: hSpaceLarge,
                                          ),
                                          SizedBox(
                                              width: double.infinity,
                                              child: StyleText(
                                                AppLocalizations.of(context)!.familyNotes,
                                                textAlign: TextAlign.start,
                                              )),
                                          SizedBox(
                                            height: hSpace,
                                          ),
                                          notes(
                                            note: controller.orders[index].familyNotes,
                                          ),
                                          SizedBox(
                                            height: hSpaceLargev,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 6,
                                                child: StyleButton(
                                                  AppLocalizations.of(context)!.chatWithDriver,
                                                  onPressed: () {
                                                    Navigator.pushNamed(context, "/chat");
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: wSpace,
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: StyleButton(
                                                  AppLocalizations.of(context)!.prepared,
                                                  sideColor: kConfirm,
                                                  backgroundColor: kConfirm,
                                                  onPressed: () async {
                                                    await readyOrder(order_id: "${controller.orders[index].id}");
                                                    print("order_id prepared is ${controller.orders[index].id}");
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: wSpace,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: StyleButton(
                                                    AppLocalizations.of(context)!.reporting,
                                                    sideColor: kRefuse,
                                                    backgroundColor: kRefuse, onPressed: () async {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return Reporting(
                                                          driver: true,
                                                          user: true,
                                                          id:"${controller.orders[index].id}",
                                                        );
                                                      },
                                                    ),
                                                  );
                                                  print("order_id reported is ${controller.orders[index].id}");
                                                }),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),


                                    if (widget.end == true)
                                      Column(
                                        children: [
                                          controller.orders[index].familyrate !=null
                                              ? SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: StyleText(
                                                        AppLocalizations.of(context)!.rateorder,
                                                        textAlign: TextAlign.start,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Icon(
                                                        Icons.arrow_forward,
                                                        color: kSecondaryColor,
                                                        size: fIconSmall,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                            size: fIconSmall,
                                                          ),
                                                          StyleText(
                                                            "${controller.orders[index].familyrate}",
                                                            textAlign: TextAlign.start,
                                                            fontSize: fSmall,
                                                            height: 1.6,
                                                            // width: SizeConfig.scaleWidth(30),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: hSpaceLarge,
                                                ),
                                                notes(
                                                  note: "${controller.orders[index].familycomment}",
                                                ),
                                              ],
                                            ),
                                          ):Column(),

                                          SizedBox(
                                            height: hSpaceLarge,
                                          ),
                                          if (controller.orders[index].familyrate == null)
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                StyleButton(
                                                  AppLocalizations.of(context)!.rateMe,
                                                  sideColor: kSpecialColor,
                                                  backgroundColor: kSpecialColor,
                                                  onPressed: () async {
                                                    await rateMeOrder(order_id: "${controller.orders[index].id}");
                                                  },
                                                ),
                                              ],
                                            )
                                        ],
                                      ),
                                    if (widget.waiting == true)
                                      Column(
                                        children: [

                                          SizedBox(
                                              width: double.infinity,
                                              child: StyleText(
                                                AppLocalizations.of(context)!.userNotes,
                                                textAlign: TextAlign.start,
                                              )),
                                          SizedBox(
                                            height: hSpace,
                                          ),
                                          notes(
                                            note: controller.orders[index].clientNotes,
                                          ),
                                          SizedBox(
                                            height: hSpaceLarge,
                                          ),
                                          SizedBox(
                                            height: SizeConfig.scaleHeight(150),
                                            width: SizeConfig.scaleWidth(350),

                                            child: StyleField(
                                              title: AppLocalizations.of(context)!.familyNotes,
                                              controller: familyNotes,
                                              width: double.infinity,

                                              maxLines: 10,
                                            ),
                                          ),
                                          divider_app(height: hSpaceLargevv),

                                          SizedBox(
                                            width: SizeConfig.scaleWidth(350),

                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child:  StyleField(
                                                    title:
                                                    "   ${AppLocalizations.of(context)!.processingTime}",
                                                    keyboardType: TextInputType.number,
                                                    controller: processingTime,
                                                    isRequired: true,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: wSpace,
                                                ),
                                                Expanded(
                                                  flex: 1,
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
                                          ),
                                          SizedBox(
                                            height: hSpaceLargev,
                                          ),
                                          StyleButton(
                                            AppLocalizations.of(context)!.submit,
                                            onPressed: () async {
                                              bool   isValidate=  _formKey.currentState!.validate() ;
                                              if(isValidate)
                                              {  await requestOrder(order_id: "${controller.orders[index].id}");}

                                             
                                            },
                                            sideColor: kConfirm,
                                            backgroundColor: kConfirm,
                                          ),
                                        ],
                                      )
                                    ,SizedBox(height: hSpace,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )

                            : Column(
                                children: [],
                              );
                      })
                  : noContent(
                      context, AppLocalizations.of(context)!.thereIsnoOrders),
        );
      },
    );
  }
  Future requestOrder({String order_id = ""}) async {
    await controller.requestOrder(
      context: context,
      order_id: order_id,
      family_notes: familyNotes.text,
      order_duration: processingTime.text,
      order_duration_unit:  valueChooseDuration==AppLocalizations.of(context)!.hour ?'h':valueChooseDuration==AppLocalizations.of(context)!.minute?"m":"d",
    );
  }
  Future rateMeOrder({String order_id = ""}) async {
    await OrderController().rateMeOrderFamilyController(
      context: context,
      order_id: order_id,
      language:
      Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );
  }
  Future readyOrder({String order_id = ""}) async {
    await OrderController().readyOrderFamilyController(
      context: context,
      order_id: order_id,
      language:
      Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );
  }
}