import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/chat/chat.dart';
import 'package:producer_family_app/components/row_product.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/orders/follow_order_driver.dart';
import 'package:producer_family_app/screens/public_screens/reporting.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/style/style_button.dart';

import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

import 'containers/container_app.dart';
import 'drop_down_list.dart';

class ExpansionTilesOrderDriver extends StatefulWidget {
  String date;
  String orderNumber;
  String userName;
  String deliveryTi;
  int orderId;
  String idUser;
  String idDelivery;
  String idFamily;
  String deliveryUnit;
  String deliveryCost;
  String noteUser;
  int? rate;
  String noteFamily;
  String familyName;
  String processingTime;
  String orderCost;
  int processDuration;
  String processDurationUnit;
  String mapFrom;
  String mapTo;
  String valueChoose = "day";
  String id;
  bool afterCurrent;
  bool current;
  bool newOrder;
  bool past;
  int index;
  ExpansionTilesOrderDriver(BuildContext context,
      {this.date = "",
      this.orderNumber = "",
      this.valueChoose = "day",
      this.userName = "",
      this.orderId = 0,
      this.deliveryTi = "",
      this.id = "",
      this.idUser = "",
      this.idFamily = "",
      this.idDelivery = "",
      required this.index,
      this.deliveryUnit = "",
      this.deliveryCost = "",
      this.noteUser = "",
      this.rate,
      this.noteFamily = "",
      this.familyName = "",
      this.processingTime = "",
      this.processDuration = 0,
      this.processDurationUnit = "",
      this.orderCost = "",
      this.mapFrom = "",
      this.mapTo = "",
      this.afterCurrent = false,
      this.current = false,
      this.newOrder = false,
      this.past = false});
  @override
  _ExpansionTilesOrderDriverState createState() =>
      _ExpansionTilesOrderDriverState();
}

class _ExpansionTilesOrderDriverState extends State<ExpansionTilesOrderDriver> {
  late TextEditingController deliveryCost;
  late TextEditingController processingTime;

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

  @override
  Widget build(BuildContext context) {
    List listItem = [
      "day",
      "minute",
      "hour",
    ];
    var _formKey1=GlobalKey<FormState>();

    return ExpansionTile(
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
                    "${widget.date}",
                    textColor: kSpecialColor,
                  ),
                ),
                SizedBox(
                  height: hSpace,
                ),
                SizedBox(
                    width: SizeConfig.scaleWidth(340),
                    child: StyleText(
                      "${AppLocalizations.of(context)!.orderNumber}     ${widget.orderNumber}",
                    )),
                SizedBox(
                  height: hSpace,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person_pin_circle_outlined,
                      color: kSpecialColor,
                      size: fIconSmall,
                    ),
                    SizedBox(
                        width: SizeConfig.scaleWidth(320),
                        child: StyleText(
                          "  ${AppLocalizations.of(context)!.from}          ${widget.mapFrom}",
                          textAlign: TextAlign.start,
                          maxLines: 3,
                        )),
                  ],
                ),
                SizedBox(
                  height: hSpace,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person_pin_circle_outlined,
                      color: kSpecialColor,
                      size: fIconSmall,
                    ),
                    SizedBox(
                        width: SizeConfig.scaleWidth(320),
                        child: StyleText(
                          "  ${AppLocalizations.of(context)!.to}          ${widget.mapTo}",
                          textAlign: TextAlign.start,
                        )),
                  ],
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
          child: Column(
            children: [
              SizedBox(height: hSpace,),
              SizedBox(
                width: wAllCard,
                child: StyleText(
                  "${AppLocalizations.of(context)!.nameUser} :               ${widget.userName} ",
                ),
              ),
              SizedBox(
                height: hSpaceLarge,
              ),
              SizedBox(
                width: wAllCard,
                child: StyleText(
                  "${AppLocalizations.of(context)!.nameFamily} :               ${widget.familyName} ",
                ),
              ),
              divider_app(height: hSpaceLargevv),
              rowProductTitle(
                notFirst: false,
                text1: AppLocalizations.of(context)!.productName,
                text2: AppLocalizations.of(context)!.quantity,
                text3: AppLocalizations.of(context)!.price,
                text4: AppLocalizations.of(context)!.totalPrice,
              ),
              GetX<getOrderDriverGetX>(
                  init: getOrderDriverGetX(),
                  builder: (getOrderDriverGetX controller) {
                    return controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: controller
                                .orders[widget.index].orderDetails.length,
                            itemBuilder: (context, indexx) {
                              return rowProductTitle(
                                notFirst: false,
                                text1: controller.orders[widget.index]
                                    .orderDetails[indexx].productname,
                                text2:
                                    "${controller.orders[widget.index].orderDetails[indexx].qty}",
                                text3:
                                    "${controller.orders[widget.index].orderDetails[indexx].productprice}",
                                text4:
                                    "${controller.orders[widget.index].orderDetails[indexx].total}",
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
                    "${widget.processDuration}   ${widget.processDurationUnit}",
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
                    "${widget.orderCost}   ${AppLocalizations.of(context)!.reyal}",
                    textColor: kSpecialColor,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              SizedBox(
                height: hSpaceLargev,
              ),
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
                note: widget.noteUser,
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
                note: widget.noteFamily,
              ),
              SizedBox(
                height: hSpaceLargev,
              ),
              if (widget.newOrder == true)
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
                                  padding: EdgeInsets.only(
                                      left: wSpace, right: wSpace),
                                  child: DropdownButton(
                                    dropdownColor: Colors.white,
                                    elevation: 2,
                                    underline: SizedBox(),
                                    style: TextStyle(
                                      fontFamily: "Almarai",
                                      color: kPrimaryColor,
                                    ),
                                    icon: Icon(Icons.arrow_drop_down_sharp),
                                    iconSize: fIcon,
                                    isExpanded: true,
                                    value: widget.valueChoose,
                                    onChanged: (newValue) {
                                      setState(() {
                                        widget.valueChoose = newValue.toString();
                                      });
                                    },
                                    items: listItem.map((valueItem) {
                                      return DropdownMenuItem(
                                          value: valueItem,
                                          child: StyleText(valueItem));
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
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
                          await requestOrder(order_id: widget.orderId);
                          FocusScope.of(context).unfocus();
                        }},
                        sideColor: kConfirm,
                        width: SizeConfig.scaleWidth(200),
                        backgroundColor: kConfirm,
                      ),
                    ],
                  ),
                ),
              if (widget.newOrder != true)
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
                          "${widget.deliveryTi}   ${widget.deliveryUnit}",
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
                          "${widget.deliveryCost}   ${AppLocalizations.of(context)!.reyal}",
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
                                        idFamily: widget.idFamily,
                                        idDriver: widget.idDelivery,
                                        idUser: widget.idUser,
                                        idOrder: widget.id,
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
                                        FollowOrderDriver(index: widget.index),

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
              if (widget.past == true)
                Column(
                  children: [
                    if (widget.rate != null)
                      SizedBox(
                        height: hSpaceLargev,
                      ),
                    if (widget.rate != null)
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
                                    " ${widget.rate}",
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
                    if (widget.rate == null)
                      StyleButton(
                        AppLocalizations.of(context)!.rateMe,
                        sideColor: kSpecialColor,
                        backgroundColor: kSpecialColor,
                        onPressed: () async {
                          await rateMeOrder(order_id: widget.orderId);
                        },
                      )
                  ],
                ),
            ],
          ),
        ),
      ],
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
      delivery_duration_unit: widget.valueChoose == "day"
          ? "d"
          : widget.valueChoose == "hour"
              ? "h"
              : "m",
    );
  }
}

//**********************************************************************

class MainExpantion extends StatelessWidget {
  String mainTitle;
  Widget Column;

  MainExpantion({required this.mainTitle, required this.Column});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Colors.grey[200],
      title: StyleText(mainTitle),
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: wSpaceLarge,
            right: wSpaceLarge,
            top: hSpaceLarge,
            bottom: hSpaceLarge,
          ),
          child: Column,
        ),
      ],
    );
  }
}
//**********************************************************************

class SubExpantion extends StatelessWidget {
  String title;
  String subject;

  SubExpantion({required this.title, required this.subject});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: StyleText(title),
      children: [
        Column(
          children: [
            StyleText(
              subject,
              maxLines: 10,
              height: 3,
            ),
            SizedBox(height: hSpaceLargev,)
          ],
        ),
      ],
    );
  }
}

//**********************************************************************
