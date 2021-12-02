import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:producer_family_app/chat/chat.dart';
import 'package:producer_family_app/components/row_product.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/orders/follow_order_driver.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

class WidgetOrdersDriver extends StatefulWidget {
  bool end;
  bool current;
  bool waiting;
  bool afterWaiting;
  int status;

  WidgetOrdersDriver({this.end = false,this.current = false,this.waiting = false,this.afterWaiting = false, this.status = 0});

  @override
  _WidgetOrdersDriverState createState() => _WidgetOrdersDriverState();
}

class _WidgetOrdersDriverState extends State<WidgetOrdersDriver> {
  late TextEditingController deliveryCost;
  late TextEditingController processingTime;
  String? valueChooseDuration ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deliveryCost = TextEditingController();
    processingTime = TextEditingController();
    processingTime.addListener(() => setState(() {}));
    deliveryCost.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    deliveryCost.dispose();
    processingTime.dispose();
  }
  var _formKey1=GlobalKey<FormState>();
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
    return GetX<getOrderDriverGetX>(
      init: getOrderDriverGetX(language:Localizations.localeOf(context).languageCode=="ar"?"ar":"en", ),
      builder: (getOrderDriverGetX controller) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
            start: wPadding,
            end: wPadding,
            top: wPadding,
            bottom: wPadding,
          ),
          child: controller.isLoading.value
              ? Center(
            child: indicator_nourah_loading()

          )
              :  controller.orders.length != 0
              ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.orders.length,
              itemBuilder: (context, index) {
                return controller.isLoading.value
                    ? Center(
                  child: indicator_nourah_loading()
                )
                    :controller.orders[index].status == widget.status
                    ?ExpansionTile(
                  tilePadding: EdgeInsets.all(0),
                  expandedAlignment: Alignment.center,
                  title: ContainerApp(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: hSpaceSmall,
                            ),
                            SizedBox(
                              width: SizeConfig.scaleWidth(350),
                              child: StyleText(
                                "${controller.orders[index].createdAt}",
                              ),
                            ),
                            SizedBox(
                              height: hSpace,
                            ),

                            SizedBox(
                                width: SizeConfig.scaleWidth(340),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    StyleText(
                                      "${AppLocalizations.of(context)!.orderNumber}     ",
                                    ),
                                    StyleText(
                                      "${controller.orders[index].orderNo}",textColor: kSpecialColor,textDecoration: TextDecoration.underline,
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: hSpace,
                            ),
                            SizedBox(
                              width: SizeConfig.scaleWidth(330),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.person_pin_circle_outlined,
                                    color: kSpecialColor,
                                    size: fIconSmall,
                                  ),
                                  SizedBox(
                                      child: StyleText(
                                        "  ${AppLocalizations.of(context)!.from}",
                                        textAlign: TextAlign.start,
                                      )),
                                  SizedBox(
                                      child: StyleText(
                                        "          ${controller.orders[index].familyaddress}",
                                        textAlign: TextAlign.start,
                                        textColor: kSpecialColor,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: hSpace,
                            ),
                            SizedBox(
                              width: SizeConfig.scaleWidth(330),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.person_pin_circle_outlined,
                                    color: kSpecialColor,
                                    size: fIconSmall,
                                  ),
                                  SizedBox(
                                      child: StyleText(
                                        "  ${AppLocalizations.of(context)!.to}",
                                        textAlign: TextAlign.start,
                                      )),
                                  SizedBox(
                                      child: StyleText(
                                        "          ${controller.orders[index].shippingTo}",
                                        textAlign: TextAlign.start,
                                        textColor: kSpecialColor,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: hSpaceSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  children: [
                    ContainerApp(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: wPadding,
                          end: wPadding,

                          bottom: wPadding,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: hSpace,),
                            SizedBox(
                              width: SizeConfig.scaleWidth(400),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StyleText(
                                    "${AppLocalizations.of(context)!.nameUser} :               ",
                                  ),
                                  StyleText(
                                    "${controller.orders[index].clientname} ",
                                    textColor: kSpecialColor,
                                    textDecoration: TextDecoration.underline,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: hSpaceLarge,
                            ),

                            SizedBox(
                              width: SizeConfig.scaleWidth(400),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StyleText(
                                    "${AppLocalizations.of(context)!.nameFamily} :               ",
                                  ),
                                  StyleText(
                                    "${controller.orders[index].familyname} ",
                                    textColor: kSpecialColor,
                                    textDecoration: TextDecoration.underline,
                                  ),
                                ],
                              ),
                            ),
                            divider_app(height: hSpaceLargevv),
                            rowProductTitle(
                              notFirst: false,
                              text1: AppLocalizations.of(context)!.productName,
                              text2: AppLocalizations.of(context)!.quantity,
                              text3: AppLocalizations.of(context)!.price,
                              text4: AppLocalizations.of(context)!.totalPrice,
                              textColor: kSpecialColor,
                            ),
                            GetX<getOrderDriverGetX>(
                                init: getOrderDriverGetX(),
                                builder: (getOrderDriverGetX controller) {
                                  return controller.isLoading.value
                                      ? Center(
                                    child:  indicator_nourah_loading()

                                  )
                                      : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: controller
                                          .orders[index].orderDetails.length,
                                      itemBuilder: (context, indexx) {
                                        return rowProductTitle(
                                          textColor: kSpecialColor,
                                          notFirst: false,
                                          text1: controller.orders[index]
                                              .orderDetails[indexx].productname,
                                          text2:
                                          "${controller.orders[index].orderDetails[indexx].qty}",
                                          text3:
                                          "${controller.orders[index].orderDetails[indexx].productprice}",
                                          text4:
                                          "${controller.orders[index].orderDetails[indexx].total}",
                                        );
                                      });
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
                                  "${controller.orders[index].orderDuration}   ${controller.orders[index].orderDurationUnit == "h" ? AppLocalizations.of(context)!.hour : "${controller.orders[index].orderDurationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day}",
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
                              note:  controller.orders[index].clientNotes,
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
                            divider_app(height: hSpaceLargevv),

                            if (widget.waiting == true)
                              Form(
                                key: _formKey1,

                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                            child: StyleField(
                                              padding: 15,
                                              title: AppLocalizations.of(context)!.deliveryTi,
                                              keyboardType: TextInputType.number,
                                              controller: processingTime,
                                              isRequired: true,
                                            ),
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
                                    SizedBox(
                                      height: hSpaceLarge,
                                    ),
                                    SizedBox(
                                      child: StyleField(
                                        title: AppLocalizations.of(context)!.deliveryCost,
                                        width: SizeConfig.scaleWidth(300),
                                        keyboardType: TextInputType.number,
                                        controller: deliveryCost,
                                        isRequired: true,
                                      ),
                                    ),
                                    SizedBox(
                                      height: hSpace,
                                    ),
                                    StyleButton(
                                      AppLocalizations.of(context)!.submit,
                                      onPressed: () async {
                                        bool   isValidate=  _formKey1.currentState!.validate() ;
                                        if(isValidate){
                                          await requestOrder(order_id: controller.orders[index].id);
                                          FocusScope.of(context).unfocus();
                                        }},
                                      sideColor: kConfirm,
                                      width: SizeConfig.scaleWidth(200),
                                      backgroundColor: kConfirm,
                                    ),
                                  ],
                                ),
                              ),
                            if (widget.waiting != true)
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      StyleText(
                                        "${AppLocalizations.of(context)!.deliveryTi} : ",
                                      ),
                                      SizedBox(
                                        width: wSpaceLarge,
                                      ),
                                      StyleText(
                                        "${controller.orders[index].deliveryDuration}   ${controller.orders[index].deliveryDurationUnit == "h" ? AppLocalizations.of(context)!.hour : "${controller.orders[index].deliveryDurationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day}",
                                        textColor: kSpecialColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  Row(
                                    children: [
                                      StyleText(
                                        "${AppLocalizations.of(context)!.deliveryCost} : ",
                                      ),
                                      SizedBox(
                                        width: wSpaceLarge,
                                      ),
                                      StyleText(
                                        "${controller.orders[index].shippingCost}   ${AppLocalizations.of(context)!.reyal}",
                                        textColor: kSpecialColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                ],
                              ),

                            if (widget.current == true)
                              Column(
                                children: [
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: wSpace,
                                      ),
                                      Expanded(
                                        child: StyleButton(
                                            AppLocalizations.of(context)!.chatWithFamily,
                                            sideColor: kSecondaryColor,
                                            backgroundColor: kSecondaryColor, onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Chat(
                                                  idFamily: "${controller.orders[index].familyId}",
                                                  idDriver:"${controller.orders[index].deliveryId}",
                                                  // idUser:"${controller.orders[index].userId}",
                                                  idOrder:"${controller.orders[index].id}",
                                                )),
                                          );
                                        }),
                                      ),
                                      SizedBox(
                                        width: wSpaceLarge,
                                      ),
                                      Expanded(
                                        child: StyleButton(
                                          AppLocalizations.of(context)!.continueUp,
                                          sideColor: kConfirm,
                                          backgroundColor: kConfirm,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FollowOrderDriver(index:index),

                                                ));
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: wSpace,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            if (widget.end == true)
                              Column(
                                children: [
                                  if (controller.orders[index].deliveryrate != null)
                                    SizedBox(
                                      height: hSpaceLargev,
                                    ),
                                  if (controller.orders[index].deliveryrate != null)
                                    SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          Expanded(
                                            flex: 4,
                                            child: StyleText(
                                              AppLocalizations.of(context)!.rateorder,
                                              textAlign: TextAlign.center,
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
                                            flex: 3,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                StyleText(
                                                  " ${controller.orders[index].deliveryrate}",
                                                  textAlign: TextAlign.center,
                                                  fontSize: fSmall,
                                                  height: 1.4,
                                                ),

                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: fIconSmall,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  SizedBox(
                                    height: hSpaceLarge,
                                  ),
                                  if (controller.orders[index].deliveryrate == null)
                                    StyleButton(
                                      AppLocalizations.of(context)!.rateMe,
                                      sideColor: kSpecialColor,
                                      backgroundColor: kSpecialColor,
                                      onPressed: () async {
                                        await rateMeOrder(order_id: controller.orders[index].id);
                                      },
                                    )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )

                : Column();
              })
              : noContent(context,AppLocalizations.of(context)!.thereIsnoOrders),

        );

      },
    );
  }


  Future rateMeOrder({required int order_id}) async {
    await OrderController().rateMeOrderFamilyController(
      context: context,
      order_id: "${order_id}",
      language:
      Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );
  }

  Future requestOrder({required int order_id}) async {
    await OrderController().requestOrderDriverController(
      context: context,
      order_id: "${order_id}",
      shipping_cost: deliveryCost.text,
      delivery_duration: processingTime.text,
      language:
      Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      delivery_duration_unit: valueChooseDuration==AppLocalizations.of(context)!.hour ?'h':valueChooseDuration==AppLocalizations.of(context)!.minute?"m":"d",

    );
  }
}

