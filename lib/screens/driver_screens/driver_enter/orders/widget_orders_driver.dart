import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/row_product.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/orders/follow_order_driver.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/orders/map-custom.dart';
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

class WidgetOrdersDriver extends StatefulWidget {
  final bool end;
  final bool current;
  final bool waiting;
  final bool afterWaiting;
  final bool newOrder;
  final bool notNewOrder;
  final int length;
  final int id;
  final int ready;
  final int orderDuration;
  final dynamic orderCost;
  final dynamic shippingCost;
  final String createdAt;
  final String clientNotes;
  final String orderNo;
  final String familyaddress;
  final String shippingTo;
  final String clientname;
  final String orderDurationUnit;
  final String familyName;
  final String familyNotes;
  final int deliveryDuration;
  final int deliveryId;
  final int familyId;
  final int index;
  final int status;
  final dynamic deliveryrate;
  final dynamic deliveryOrderRate;
  final dynamic familylat;
  final dynamic familylng;
  final double clientlat;
  final double clientlng;
  final String deliveryDurationUnit;
  final String familyphone;
  final getNewOrderDriverGetX? controller;

  const WidgetOrdersDriver({
    this.controller,
    this.ready = 0,
    this.deliveryOrderRate = 0,
    this.familylat = 0,
    this.clientlat = 0,
    this.clientlng = 0,
    this.familylng = 0,
    this.notNewOrder = false,
    this.newOrder = false,
    this.deliveryrate = 0,
    this.index = 0,
    this.familyphone = "",
    this.deliveryId = 0,
    this.familyId = 0,
    this.shippingCost = 0,
    this.deliveryDurationUnit = "",
    this.deliveryDuration = 0,
    this.id = 0,
    this.familyNotes = "",
    this.clientNotes = "",
    this.orderCost = 0,
    this.orderDurationUnit = "",
    this.orderDuration = 0,
    this.familyName = "",
    this.clientname = "",
    this.end = false,
    this.shippingTo = "",
    this.familyaddress = "",
    this.orderNo = "",
    this.length = 0,
    this.status = 0,
    this.createdAt = "",
    this.current = false,
    this.waiting = false,
    this.afterWaiting = false,
  });

  @override
  _WidgetOrdersDriverState createState() => _WidgetOrdersDriverState();
}

class _WidgetOrdersDriverState extends State<WidgetOrdersDriver> {
  late TextEditingController deliveryCost;
  late TextEditingController processingTime;
  String? valueChooseDuration;
  getOrderDriverGetX controller = Get.put(getOrderDriverGetX());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    managenotificationAction(context);

    deliveryCost = TextEditingController();
    processingTime = TextEditingController();
    processingTime.addListener(() => setState(() {}));
    deliveryCost.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Get.delete<getNewOrderDriverGetX>() ;
    Get.delete<getOrderDriverGetX>();

    deliveryCost.dispose();
    processingTime.dispose();
    super.dispose();
  }

  // getNewOrderDriverGetX controller = Get.put(getNewOrderDriverGetX());
  getOrderDriverGetX controller1 = Get.put(getOrderDriverGetX());

  final _formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final List listItem = [
      AppLocalizations.of(context)!.day,
      AppLocalizations.of(context)!.minute,
      AppLocalizations.of(context)!.hour,
    ];
    return Padding(
      padding: EdgeInsets.only(right: wPadding, left: wPadding),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(0),
        expandedAlignment: Alignment.center,
        title: ContainerApp(
          colorContainer: widget.status == 4
              ? Colors.grey.shade300
              : widget.deliveryOrderRate == 0 && widget.status == 3 ||
                      widget.ready == 1 && widget.status == 1
                  ? kSpecialColor.withOpacity(.2)
                  : Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: hSpaceSmall,
              ),
              SizedBox(
                width: SizeConfig.scaleWidth(350),
                child: StyleText(
                  widget.createdAt,
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
                      widget.orderNo,
                      textColor: kSpecialColor,
                      textDecoration: TextDecoration.underline,
                    ),
                  ],
                ),
              ),
              if (widget.end == true)
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
              if (widget.end != true)
                SizedBox(
                  height: hSpace,
                ),
              if (widget.end != true)
                SizedBox(
                  width: SizeConfig.scaleWidth(360),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: StyleText(
                          widget.familyaddress,
                          textAlign: TextAlign.center,
                          textColor: kSpecialColor,
                          maxLines: 5,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.end != true)
                SizedBox(
                  height: hSpace,
                ),
              if (widget.end != true)
                SizedBox(
                  width: SizeConfig.scaleWidth(360),
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
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: StyleText(
                          widget.shippingTo,
                          textAlign: TextAlign.center,
                          textColor: kSpecialColor,
                          maxLines: 5,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: hSpaceSmall,
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.only(right: wSpace, left: wSpace),
            child: ContainerApp(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: wPadding,
                  end: wPadding,
                  bottom: wPadding,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: hSpace,
                    ),
                    SizedBox(
                      width: SizeConfig.scaleWidth(400),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StyleText(
                            "${AppLocalizations.of(context)!.nameUser} :               ",
                          ),
                          Flexible(
                            child: StyleText(
                              "${widget.clientname} ",
                              textColor: kSpecialColor,
                            ),
                          ),
                          SizedBox(
                            width: wSpace,
                          ),
                          if (widget.waiting == true || widget.current == true)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapCustom(
                                      latCustom: widget.clientlat.toDouble(),
                                      lngCustom: widget.clientlng.toDouble(),
                                    ),
                                  ),
                                );
                              },
                              child: StyleText(
                                AppLocalizations.of(context)!.location,
                                textColor: kConfirm,
                              ),
                            )
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
                          Flexible(
                            child: StyleText(
                              "${AppLocalizations.of(context)!.nameFamily} :               ",
                            ),
                          ),
                          StyleText(
                            "${widget.familyName} ",
                            textColor: kSpecialColor,
                          ),
                          SizedBox(
                            width: wSpace,
                          ),
                          if (widget.waiting == true || widget.current == true)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapCustom(
                                      latCustom: widget.familylat.toDouble(),
                                      lngCustom: widget.familylng.toDouble(),
                                    ),
                                  ),
                                );
                              },
                              child: StyleText(
                                AppLocalizations.of(context)!.location,
                                textColor: kConfirm,
                              ),
                            )
                        ],
                      ),
                    ),
                    dividerApp(height: hSpaceLargevv),
                    RowProductTitle(
                      notFirst: false,
                      text1: AppLocalizations.of(context)!.productName,
                      text2: AppLocalizations.of(context)!.quantity,
                      text3: AppLocalizations.of(context)!.price,
                      text4: AppLocalizations.of(context)!.dis,
                      text5: AppLocalizations.of(context)!.totalPrice,
                      textColor: kSpecialColor,
                    ),
                    if (widget.notNewOrder == true)
                      GetX<getOrderDriverGetX>(
                        init: getOrderDriverGetX(),
                        builder: (getOrderDriverGetX controller) {
                          return controller.isLoading.value
                              ? Center(child: indicatorNourahLoading())
                              : controller.orders[widget.index].orderDetails
                                      .isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: controller.orders[widget.index]
                                          .orderDetails.length,
                                      itemBuilder: (context, indexx) {
                                        return controller.orders[widget.index]
                                                .orderDetails.isNotEmpty
                                            ? controller
                                                        .orders[widget.index]
                                                        .orderDetails[indexx]
                                                        .qty ==
                                                    0
                                                ? Column()
                                                : RowProductTitle(
                                                    textColor: kSpecialColor,
                                                    notFirst: false,
                                                    text1: Localizations
                                                                .localeOf(
                                                              context,
                                                            ).languageCode ==
                                                            "ar"
                                                        ? controller
                                                            .orders[
                                                                widget.index]
                                                            .orderDetails[
                                                                indexx]
                                                            .arname
                                                        : controller
                                                            .orders[
                                                                widget.index]
                                                            .orderDetails[
                                                                indexx]
                                                            .enname,
                                                    text2:
                                                        "${controller.orders[widget.index].orderDetails[indexx].qty}",
                                                    text3:
                                                        "${controller.orders[widget.index].orderDetails[indexx].productprice}",
                                                    text4:
                                                        "${controller.orders[widget.index].orderDetails[indexx].offerDiscount ?? 0} %",
                                                    text5:
                                                        "${controller.orders[widget.index].orderDetails[indexx].total}",
                                                  )
                                            : Column();
                                      },
                                    )
                                  : Column();
                        },
                      ),
                    if (widget.newOrder == true)
                      GetX<getNewOrderDriverGetX>(
                        init: getNewOrderDriverGetX(),
                        builder: (getNewOrderDriverGetX controller) {
                          return controller.isLoading.value
                              ? Center(child: indicatorNourahLoading())
                              : controller.newOrders[widget.index].orderDetails
                                      .isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: controller
                                          .newOrders[widget.index]
                                          .orderDetails
                                          .length,
                                      itemBuilder: (context, indexx) {
                                        return controller
                                                    .newOrders[widget.index]
                                                    .orderDetails[indexx]
                                                    .qty ==
                                                0
                                            ? Column()
                                            : RowProductTitle(
                                                textColor: kSpecialColor,
                                                notFirst: false,
                                                text1: Localizations.localeOf(
                                                                context)
                                                            .languageCode ==
                                                        "ar"
                                                    ? controller
                                                        .newOrders[widget.index]
                                                        .orderDetails[indexx]
                                                        .arname
                                                    : controller
                                                        .newOrders[widget.index]
                                                        .orderDetails[indexx]
                                                        .enname,
                                                text2:
                                                    "${controller.newOrders[widget.index].orderDetails[indexx].qty}",
                                                text3:
                                                    "${controller.newOrders[widget.index].orderDetails[indexx].productprice}",
                                                text4:
                                                    "${controller.newOrders[widget.index].orderDetails[indexx].offerDiscount ?? 0} %",
                                                text5:
                                                    "${controller.newOrders[widget.index].orderDetails[indexx].total}",
                                              );
                                      },
                                    )
                                  : Column();
                        },
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          dividerApp(height: hSpaceLarge),
                          SizedBox(
                            height: hSpace,
                          ),
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
                                "${widget.orderDuration}   ${widget.orderDurationUnit == "h" ? AppLocalizations.of(context)!.hour : widget.orderDurationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day}",
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
                          if (widget.current == true)
                            Column(
                              children: [
                                SizedBox(
                                  height: hSpaceLarge,
                                ),
                                Row(
                                  children: [
                                    StyleText(
                                      "${AppLocalizations.of(context)!.deliveryCost}  :",
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      width: wSpaceLarge,
                                    ),
                                    StyleText(
                                      "${widget.shippingCost}   ${AppLocalizations.of(context)!.reyal}",
                                      textColor: kSpecialColor,
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: hSpaceLarge,
                                ),
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
                                      "${widget.deliveryDuration}  ${widget.deliveryDurationUnit == "h" ? AppLocalizations.of(context)!.hour : widget.deliveryDurationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                      textColor: kSpecialColor,
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          dividerApp(height: hSpaceLargevv),
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
                                            title: AppLocalizations.of(context)!
                                                .deliveryTi,
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
                                          height: SizeConfig.scaleWidth(58),
                                          child: ContainerApp(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: wSpace,
                                                right: wSpace,
                                              ),
                                              child: DropdownButton<String>(
                                                dropdownColor: Colors.white,
                                                elevation: 0,
                                                underline: const SizedBox(),
                                                style: TextStyle(
                                                  fontFamily: "ElMessiri",
                                                  color: kSpecialColor,
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down_sharp,
                                                ),
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
                                                    DropdownMenuItem<
                                                        String>>((valueItem) {
                                                  return DropdownMenuItem(
                                                    value: valueItem,
                                                    child: StyleText(
                                                      valueItem,
                                                    ),
                                                  );
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
                                    width: SizeConfig.scaleWidth(250),
                                    child: StyleField(
                                      title: AppLocalizations.of(context)!
                                          .deliveryCost,
                                      width: SizeConfig.scaleWidth(300),
                                      keyboardType: TextInputType.number,
                                      controller: deliveryCost,
                                      isRequired: true,
                                    ),
                                  ),
                                  dividerApp(height: hSpaceLargevv),
                                  StyleButton(
                                    AppLocalizations.of(context)!.submit,
                                    onPressed: () async {
                                      final bool isValidate =
                                          _formKey1.currentState!.validate();
                                      if (isValidate) {
                                        showDialoge(
                                          context,
                                          message3: Column(),
                                          message1:
                                              AppLocalizations.of(context)!
                                                  .submit,
                                          message2:
                                              AppLocalizations.of(context)!
                                                  .submitRequest,
                                          button1: AppLocalizations.of(context)!
                                              .confirm,
                                          button2: AppLocalizations.of(context)!
                                              .cancel,
                                          colorButton1: kConfirm,
                                          colorButton2: kSpecialColor,
                                          iconMeassge: Icon(
                                            Icons.next_plan_sharp,
                                            color: kConfirm,
                                            size: SizeConfig.scaleTextFont(50),
                                          ),
                                          onPressed: () async {
                                            // print('requestOrder');
                                            await requestOrder(
                                              orderId: widget.id,
                                            );
                                            Navigator.pop(context);
                                          },
                                        );

                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    sideColor: kConfirm,
                                    width: SizeConfig.scaleWidth(200),
                                    backgroundColor: kConfirm,
                                  ),
                                  SizedBox(
                                    height: hSpace,
                                  ),
                                ],
                              ),
                            ),
                          if (widget.current == true)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: StyleButton(
                                        widget.ready == 1
                                            ? AppLocalizations.of(context)!
                                                .continueUp
                                            : AppLocalizations.of(context)!
                                                .waitingForTheFamilyReady,
                                        sideColor: widget.ready == 1
                                            ? kConfirm
                                            : Colors.grey,
                                        backgroundColor: widget.ready == 1
                                            ? kConfirm
                                            : Colors.grey,
                                        onPressed: () {
                                          if (widget.ready == 0) {
                                            controller1.refreshValues();
                                          }
                                          if (widget.ready == 1) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FollowOrderDriver(
                                                  index: widget.index,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    if (widget.ready == 0)
                                      SizedBox(
                                        width: wSpaceSmall,
                                      ),
                                    if (widget.ready == 0)
                                      Expanded(
                                        flex: 2,
                                        child: StyleButton(
                                          AppLocalizations.of(context)!
                                              .chatWithFamily,
                                          sideColor: kSpecialColor,
                                          backgroundColor: kSpecialColor,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatFamily(
                                                  orderNo: widget.orderNo,
                                                  driverId: widget.deliveryId,
                                                  familyId: widget.familyId,
                                                  phone: widget.familyphone,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  height: hSpace,
                                ),
                                widget.ready == 0
                                    ? Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: StyleButton(
                                              AppLocalizations.of(context)!
                                                  .refresh,
                                              sideColor: kConfirm,
                                              backgroundColor: kConfirm,
                                              onPressed: () {
                                                if (widget.ready == 0) {
                                                  controller1.refreshValues();
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: wSpaceSmall,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: StyleButton(
                                              AppLocalizations.of(context)!
                                                  .reporting,
                                              sideColor: kRefuse,
                                              backgroundColor: kRefuse,
                                              onPressed: () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return Reporting(
                                                        family: true,
                                                        user: true,
                                                        id: widget.id,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    : Column(),
                              ],
                            ),
                          if (widget.end == true)
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
                                      "${widget.deliveryDuration}   ${widget.deliveryDurationUnit == "h" ? AppLocalizations.of(context)!.hour : widget.deliveryDurationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day}",
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
                                      "${widget.shippingCost}   ${AppLocalizations.of(context)!.reyal}",
                                      textColor: kSpecialColor,
                                    ),
                                  ],
                                ),
                                widget.deliveryOrderRate != 0
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: hSpaceLargev,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: StyleText(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!
                                                        .rateorder,
                                                    textAlign: TextAlign.center,
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
                                                  flex: 3,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      StyleText(
                                                        " ${widget.deliveryOrderRate}",
                                                        textAlign:
                                                            TextAlign.center,
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
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          dividerApp(height: hSpaceLargevv),
                                          StyleButton(
                                            AppLocalizations.of(context)!
                                                .rateMe,
                                            sideColor: kSpecialColor,
                                            backgroundColor: kSpecialColor,
                                            onPressed: () async {
                                              await rateMeOrder(
                                                orderId: widget.id,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                SizedBox(
                                  height: hSpace,
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future rateMeOrder({required int orderId}) async {
    await OrderController().rateMeOrderFamilyController(
      context: context,
      orderId: "$orderId",
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
    );
  }

  Future requestOrder({required int orderId}) async {
    if (processingTime.text.isNotEmpty && valueChooseDuration != null) {
      await widget.controller!.requestOrder(
        context: context,
        delivery_duration_unit:
            valueChooseDuration == AppLocalizations.of(context)!.hour
                ? 'h'
                : valueChooseDuration == AppLocalizations.of(context)!.minute
                    ? "m"
                    : "d",
        order_id: orderId,
        delivery_duration: int.parse(processingTime.text),
        shipping_cost: int.parse(deliveryCost.text),
      );
      // print(
      //   valueChooseDuration == AppLocalizations.of(context)!.hour
      //       ? 'h'
      //       : valueChooseDuration == AppLocalizations.of(context)!.minute
      //           ? "m"
      //           : "d",
      // );
      // print(processingTime.text);
      // print(orderId);
    } else {
      helper(
        context: context,
        message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
        error: true,
      );
    }
  }
}
