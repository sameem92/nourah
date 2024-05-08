import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/row_product.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/public_screens/chat_damily_driver.dart';
import 'package:producer_family_app/screens/public_screens/reporting.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

class WidgetOrdersFamily extends StatefulWidget {
  final bool end;
  final bool current;
  final bool waiting;
  final bool familyOrderbool;
  final int id;
  final int ready;
  final int status;
  final int length;
  final int familyReply;
  final int orderDuration;
  final int driverDuration;
  final dynamic orderCost;
  final int userId;
  final int deliveryId;
  final int familyId;
  final int index;
  final dynamic familyrate;
  final String familyOrderRate;
  final String orderNo;
  final String createdAt;
  final String clientNotes;
  final getOrderFamilyGetX? controller;
  final String familyNotes;
  final String orderDurationUnit;
  final String driverDurationUnit;
  final String familycomment;
  final String deliveryphone;
  final getOrderFamilyGetX? controller1;
  const WidgetOrdersFamily({
    this.status = 0,
    this.controller1,
    this.familyOrderbool = false,
    this.controller,
    this.driverDurationUnit = '',
    this.driverDuration = 0,
    this.ready = 0,
    this.familyOrderRate = '',
    this.index = 0,
    this.familycomment = '',
    this.familyrate = 0,
    this.id = 0,
    this.deliveryphone = '',
    this.familyId = 0,
    this.deliveryId = 0,
    this.userId = 0,
    this.familyNotes = "",
    this.clientNotes = "",
    this.orderCost = 0,
    this.orderDurationUnit = "",
    this.orderDuration = 0,
    this.createdAt = '',
    this.orderNo = '',
    this.familyReply = 0,
    this.length = 0,
    this.end = false,
    this.current = false,
    this.waiting = false,
  });
  @override
  _WidgetOrdersFamilyState createState() => _WidgetOrdersFamilyState();
}

class _WidgetOrdersFamilyState extends State<WidgetOrdersFamily> {
  late TextEditingController familyNotes;
  late TextEditingController processingTime;
  String? valueChooseDuration;
  // getOrderFamilyGetX controller1 = Get.put(getOrderFamilyGetX());
  // List <int> _deletedItems = <int>[];

  @override
  void initState() {
    super.initState();
    managenotificationAction(context);

    familyNotes = TextEditingController();
    processingTime = TextEditingController();
    familyNotes.addListener(() => setState(() {}));
    processingTime.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    Get.delete<getOrderFamilyGetX>();
    familyNotes.dispose();
    processingTime.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List listItem = [
      AppLocalizations.of(context)!.minute,
      AppLocalizations.of(context)!.hour,
      AppLocalizations.of(context)!.day,
    ];
    return Padding(
      padding: EdgeInsets.only(right: wPadding, left: wPadding),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(0),
        title: Row(
          children: [
//
            Expanded(
              child: ContainerApp(
                colorContainer: widget.status == 4
                    ? Colors.grey.shade300
                    : widget.familyOrderRate == null && widget.status == 3 ||
                            widget.familyOrderRate == "" && widget.status == 3
                        ? kSpecialColor.withOpacity(.2)
                        : Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.scaleHeight(15),
                    // bottom: SizeConfig.scaleHeight(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StyleText(
                                "${AppLocalizations.of(context)!.orderNumber}     ",
                              ),
                              StyleText(
                                widget.orderNo,
                                textColor: kSpecialColor,
                                textDecoration: TextDecoration.underline,
                              ),
                            ],
                          ),

                          StyleText(
                            widget.createdAt,
                          ),
                          // if(current==true)
                        ],
                      ),
                      SizedBox(
                        height: hSpace,
                      ),
                      if (widget.end == true)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StyleText(
                              "${AppLocalizations.of(context)!.status}:     ",
                            ),
                            StyleText(
                              widget.status == 3
                                  ? AppLocalizations.of(context)!.completeOrder
                                  : AppLocalizations.of(context)!.canceledOrder,
                              textColor: kSpecialColor,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.only(right: wSpace, left: wSpace),
            child: ContainerApp(
              child: Padding(
                padding: EdgeInsets.only(right: wSpace, left: wSpace),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      RowProductTitle(
                        notFirst: false,
                        text1: AppLocalizations.of(context)!.productName,
                        text2: AppLocalizations.of(context)!.quantity,
                        text3: AppLocalizations.of(context)!.price,
                        text4: AppLocalizations.of(context)!.dis,
                        text5: AppLocalizations.of(context)!.totalPrice,
                      ),
                      GetX<getOrderFamilyGetX>(
                          init: getOrderFamilyGetX(
                            language:
                                Localizations.localeOf(context).languageCode ==
                                        "ar"
                                    ? "ar"
                                    : "en",
                          ),
                          builder: (getOrderFamilyGetX controller) {
                            return controller.isLoading.value
                                ? Center(child: indicatorNourahLoading())
                                : controller.orders[widget.index].orderDetails
                                        .isNotEmpty
                                    ? ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: controller
                                            .orders[widget.index]
                                            .orderDetails
                                            .length,
                                        itemBuilder: (context, indexx) {
                                          return controller
                                                      .orders[widget.index]
                                                      .orderDetails[indexx]
                                                      .qty ==
                                                  0
                                              ? Column()
                                              : RowProductTitle(
                                                  notFirst: false,
                                                  text1: Localizations.localeOf(
                                                                  context)
                                                              .languageCode ==
                                                          "ar"
                                                      ? controller
                                                          .orders[widget.index]
                                                          .orderDetails[indexx]
                                                          .arname
                                                      : controller
                                                          .orders[widget.index]
                                                          .orderDetails[indexx]
                                                          .enname,
                                                  text2:
                                                      "${controller.orders[widget.index].orderDetails[indexx].qty}",
                                                  text3:
                                                      "${controller.orders[widget.index].orderDetails[indexx].productprice}",
                                                  text4:
                                                      "${controller.orders[widget.index].orderDetails[indexx].offerDiscount ?? 0} %",
                                                  text5:
                                                      "${controller.orders[widget.index].orderDetails[indexx].total}",
                                                );
                                        })
                                    : Column();
                          }),
                      dividerApp(height: hSpaceLarge),
                      SizedBox(
                        height: hSpace,
                      ),
                      if (widget.waiting != true)
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
                              "${widget.orderDuration}   ${widget.orderDurationUnit == "h" ? AppLocalizations.of(context)!.hour : widget.orderDurationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                              textColor: kSpecialColor,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      // : Column(),
                      // widget.orderDuration != 0 ?

                      SizedBox(
                        height: hSpaceLarge,
                      ),
                      // : Column(),
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
                      if (widget.waiting != true && widget.orderDuration != 0)
                        SizedBox(
                          height: hSpaceLarge,
                        ),
                      if (widget.waiting != true && widget.orderDuration != 0)
                        Row(
                          children: [
                            StyleText(
                              "${AppLocalizations.of(context)!.driverTime}  :",
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              width: wSpaceLarge,
                            ),
                            StyleText(
                              "${widget.driverDuration}   ${widget.driverDurationUnit == "h" ? AppLocalizations.of(context)!.hour : widget.driverDurationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                              textColor: kSpecialColor,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      dividerApp(height: hSpaceLargevv),

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
                            Notes(
                              note: widget.clientNotes,
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
                            Notes(
                              note: widget.familyNotes,
                            ),
                            SizedBox(
                              height: hSpaceLargev,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: wSpace,
                                ),
                                Expanded(
                                  flex: 6,
                                  child: StyleButton(
                                    AppLocalizations.of(context)!
                                        .chatWithDriver,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatFamily(
                                                orderNo: widget.orderNo,
                                                driverId: widget.deliveryId,
                                                familyId: widget.familyId,
                                                phone: widget.deliveryphone)),
                                      );
                                    },
                                  ),
                                ),
                                if (widget.ready == 0)
                                  SizedBox(
                                    width: wSpace,
                                  ),
                                if (widget.ready == 0)
                                  Expanded(
                                    flex: 4,
                                    child: StyleButton(
                                      AppLocalizations.of(context)!.prepared,
                                      sideColor: kConfirm,
                                      backgroundColor: kConfirm,
                                      onPressed: () async {
                                        await readyOrder(orderId: widget.id);
                                        // print(
                                        //     "order_id prepared is ${widget.id}");
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
                                      backgroundColor: kRefuse,
                                      onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Reporting(
                                            driver: true,
                                            user: true,
                                            id: widget.id,
                                          );
                                        },
                                      ),
                                    );
                                    print("order_id reported is ${widget.id}");
                                  }),
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
                            widget.familyOrderRate != null &&
                                    widget.familyOrderRate != ""
                                ? Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: StyleText(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .rateorder,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Icon(
                                                    Icons.arrow_forward,
                                                    color: kSpecialColor,
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
                                                        widget.familyOrderRate,
                                                        textAlign:
                                                            TextAlign.start,
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
                                            Notes(
                                              note: widget.familycomment,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: hSpaceLarge,
                                      ),
                                    ],
                                  )
                                : Column(),
                            if (widget.familyOrderbool == true)
                              if (widget.end == true)
                                if (widget.familyOrderRate == null ||
                                    widget.familyOrderRate == "")
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: SizeConfig.scaleWidth(200),
                                        child: StyleButton(
                                          AppLocalizations.of(context)!.rateMe,
                                          sideColor: kSpecialColor,
                                          backgroundColor: kSpecialColor,
                                          onPressed: () async {
                                            await rateMeOrder(
                                                orderId: "${widget.id}");
                                          },
                                        ),
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
                            Notes(
                              note: widget.clientNotes,
                            ),
                            SizedBox(
                              height: hSpaceLarge,
                            ),
                            SizedBox(
                              height: SizeConfig.scaleHeight(150),
                              width: SizeConfig.scaleWidth(350),
                              child: StyleField(
                                title:
                                    AppLocalizations.of(context)!.familyNotes,
                                controller: familyNotes,
                                width: double.infinity,
                                maxLines: 10,
                              ),
                            ),
                            dividerApp(height: hSpaceLargevv),
                            SizedBox(
                              width: SizeConfig.scaleWidth(350),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: StyleField(
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
                                              value: valueChooseDuration,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  valueChooseDuration =
                                                      newValue.toString();
                                                });
                                              },
                                              items: listItem.map<
                                                      DropdownMenuItem<String>>(
                                                  (valueItem) {
                                                return DropdownMenuItem(
                                                    value: valueItem,
                                                    child:
                                                        StyleText(valueItem));
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
                                bool isValidate =
                                    _formKey.currentState!.validate();
                                if (isValidate) {
                                  showDialoge(
                                    context,
                                    message3: Column(),
                                    message1:
                                        AppLocalizations.of(context)!.submit,
                                    message2: AppLocalizations.of(context)!
                                        .submitRequest,
                                    button1:
                                        AppLocalizations.of(context)!.confirm,
                                    button2:
                                        AppLocalizations.of(context)!.cancel,
                                    colorButton1: kConfirm,
                                    colorButton2: kSpecialColor,
                                    iconMeassge: Icon(
                                      Icons.next_plan_sharp,
                                      color: kConfirm,
                                      size: SizeConfig.scaleTextFont(50),
                                    ),
                                    onPressed: () async {
                                      // print('requestOrder');
                                      await requestOrder(orderId: widget.id);
                                      Navigator.pop(context);
                                    },
                                  );
                                }
                              },
                              sideColor: kConfirm,
                              backgroundColor: kConfirm,
                            ),
                          ],
                        ),
                      SizedBox(
                        height: hSpace,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future requestOrder({required int orderId}) async {
    if (processingTime.text.isNotEmpty || valueChooseDuration != null) {
      await widget.controller1!.requestOrder(
        context: context,
        order_id: orderId,
        family_notes: familyNotes.text,
        order_duration: processingTime.text,
        order_duration_unit:
            valueChooseDuration == AppLocalizations.of(context)!.hour
                ? 'h'
                : valueChooseDuration == AppLocalizations.of(context)!.minute
                    ? "m"
                    : "d",
      );
      // print(valueChooseDuration == AppLocalizations.of(context)!.hour
      //     ? 'h'
      //     : valueChooseDuration == AppLocalizations.of(context)!.minute
      //         ? "m"
      //         : "d");
      // print(processingTime.text);
      // print(orderId);
      // print(familyNotes.text);
    } else {
      helper(
          context: context,
          message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
          error: true);
    }
  }

  Future rateMeOrder({String orderId = ""}) async {
    await OrderController().rateMeOrderFamilyController(
      context: context,
      orderId: orderId,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );
  }

  Future readyOrder({required int orderId}) async {
    await widget.controller!.readyOrder(context: context, order_id: orderId);
  }
}
