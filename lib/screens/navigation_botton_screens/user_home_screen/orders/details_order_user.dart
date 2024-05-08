import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/row_product.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/screens/public_screens/chat.dart';
import 'package:producer_family_app/screens/public_screens/reporting.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

import '../../../../components/containers/container_app.dart';
import '../main_screen.dart';

class DetailsOrderUser extends StatefulWidget {
  final bool end;
  final bool current;
  final bool waiting;
  final int ready;
  final int index;
  final getOrderGetX controller;

  const DetailsOrderUser(
      {this.end = false,
      required this.controller,
      this.current = false,
      this.waiting = false,
      this.ready = 0,
      this.index = 0});
  @override
  State<DetailsOrderUser> createState() => _DetailsOrderUserState();
}

class _DetailsOrderUserState extends State<DetailsOrderUser> {
  getOrderGetX controller = Get.put(getOrderGetX());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.details,
        onPressed: () {
          // print(widget.index);
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: hPadding,
          bottom: hPadding,
          left: wPadding,
          right: wPadding,
        ),
        child: controller.isLoading.value
            ? Center(child: indicatorNourahLoading())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ContainerApp(
                        child: Padding(
                      padding: EdgeInsets.only(
                        left: wSpace,
                        right: wSpace,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: hSpace,
                          ),
                          StyleText(
                            controller.orders[widget.index].createdAt,
                          ),
                          SizedBox(
                            height: hSpaceLarge,
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
                                    controller.orders[widget.index].orderNo,
                                    textColor: kSpecialColor,
                                    textDecoration: TextDecoration.underline,
                                  ),
                                ],
                              )),
                          dividerApp(),
                          RowProductTitle(
                            notFirst: false,
                            text1: AppLocalizations.of(context)!.productName,
                            // text2: "",
                            text2: AppLocalizations.of(context)!.quantity,
                            text3: AppLocalizations.of(context)!.price,
                            text4: AppLocalizations.of(context)!.dis,
                            text5: AppLocalizations.of(context)!.totalPrice,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: controller
                                  .orders[widget.index].orderDetails.length,
                              itemBuilder: (context, index) {
                                return controller.orders[widget.index]
                                            .orderDetails[index].qty ==
                                        0
                                    ? Column()
                                    : RowProductTitle(
                                        notFirst: false,
                                        text1: Localizations.localeOf(context)
                                                    .languageCode ==
                                                "ar"
                                            ? controller.orders[widget.index]
                                                .orderDetails[index].arname
                                            : controller.orders[widget.index]
                                                .orderDetails[index].enname,
                                        text2:
                                            "${controller.orders[widget.index].orderDetails[index].qty}",
                                        text3:
                                            "${controller.orders[widget.index].orderDetails[index].productprice}",
                                        text4:
                                            "${controller.orders[widget.index].orderDetails[index].offerDiscount ?? 0} %",
                                        text5:
                                            "${controller.orders[widget.index].orderDetails[index].total}",
                                      );
                              }),
                          SizedBox(
                            height: hSpace,
                          ),
                          dividerApp(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RowProduct2(
                                text1: widget.waiting != true
                                    ? AppLocalizations.of(context)!.deliveryCost
                                    : "",
                                text2: widget.waiting != true
                                    ? "${controller.orders[widget.index].shippingCost}"
                                    : "",
                                text3: AppLocalizations.of(context)!.orderCost,
                                text4:
                                    "${controller.orders[widget.index].orderCost}",
                              ),
                              RowProduct2(
                                text1: AppLocalizations.of(context)!.dis,
                                text2:
                                    "${controller.orders[widget.index].coupon}",
                                text3: AppLocalizations.of(context)!.totalCost,
                                text4:
                                    "${controller.orders[widget.index].totalCost + controller.orders[widget.index].shippingCost}",
                              ),
                              SizedBox(
                                height: hSpace,
                              ),
                              dividerApp(),
                              SizedBox(
                                height: hSpace,
                              ),
                              Row(
                                children: [
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
                                        "${controller.orders[widget.index].orderDuration}  ${controller.orders[widget.index].orderDurationUnit == "h" ? AppLocalizations.of(context)!.hour : controller.orders[widget.index].orderDurationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                        textColor: kSpecialColor,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: hSpace,
                              ),
                              Row(
                                children: [
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
                                        "${controller.orders[widget.index].deliveryDuration}  ${controller.orders[widget.index].deliveryDurationUnit == "h" ? AppLocalizations.of(context)!.hour : controller.orders[widget.index].deliveryDurationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                        textColor: kSpecialColor,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  // if(widget.end==false)
                                  // SizedBox(
                                  //   width: wSpaceLarge,
                                  // ),
                                  // if(widget.end==false)
                                  //   StyleText(
                                  // widget.ready==0?AppLocalizations.of(context)!
                                  //       .notStartedYet:AppLocalizations.of(context)!
                                  //     .inProgress,
                                  //   textAlign: TextAlign.start,
                                  //   textColor: widget.ready==0?kSecondaryColor:kConfirm,
                                  //
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: hSpace,
                              ),
                              dividerApp(),
                              if (widget.end == false)
                                SizedBox(
                                  height: hSpaceLarge,
                                ),
                              SizedBox(
                                height: hSpace,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: StyleText(
                                  AppLocalizations.of(context)!.userNotes,
                                  textAlign: TextAlign.start,
                                  textColor: kSpecialColor,
                                ),
                              ),
                              SizedBox(
                                height: hSpace,
                              ),
                              Notes(
                                note:
                                    controller.orders[widget.index].clientNotes,
                              ),
                              SizedBox(
                                height: hSpaceLarge,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: StyleText(
                                  AppLocalizations.of(context)!.familyNotes,
                                  textAlign: TextAlign.start,
                                  textColor: kSpecialColor,
                                ),
                              ),
                              SizedBox(
                                height: hSpace,
                              ),
                              Notes(
                                note:
                                    controller.orders[widget.index].familyNotes,
                              ),
                              SizedBox(
                                height: hSpace,
                              ),
                              if (widget.end == true &&
                                  controller.orders[widget.index]
                                          .familyorderRate !=
                                      null &&
                                  controller.orders[widget.index]
                                          .familyorderRate !=
                                      0)
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      dividerApp(),
                                      SizedBox(
                                        height: hSpace,
                                      ),
                                      Row(
                                        children: [
                                          StyleText(
                                            AppLocalizations.of(context)!
                                                .familyRate,
                                            textAlign: TextAlign.start,
                                            textColor: kSpecialColor,
                                          ),
                                          SizedBox(
                                            width: wSpace,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              StyleText(
                                                "${controller.orders[widget.index].familyorderRate} ",
                                                textAlign: TextAlign.end,
                                                fontSize: fSmall,
                                                height: 1.4,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: fIconSmall,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: hSpace,
                                      ),
                                      Notes(
                                        note:
                                            "${controller.orders[widget.index].familycomment} ",
                                      ),
                                      SizedBox(
                                        height: hSpace,
                                      ),
                                      dividerApp(),
                                      SizedBox(
                                        height: hSpace,
                                      ),
                                      Row(
                                        children: [
                                          StyleText(
                                            AppLocalizations.of(context)!
                                                .deliveryRate,
                                            textAlign: TextAlign.start,
                                            textColor: kSpecialColor,
                                          ),
                                          SizedBox(
                                            width: wSpace,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              StyleText(
                                                controller.orders[widget.index]
                                                            .deliveryorderRate !=
                                                        0
                                                    ? "${controller.orders[widget.index].deliveryorderRate}.0 "
                                                    : "",
                                                textAlign: TextAlign.end,
                                                fontSize: fSmall,
                                                height: 1.4,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: fIconSmall,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: hSpaceLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              if (widget.current == true)
                                Column(
                                  children: [
                                    dividerApp(),
                                    SizedBox(
                                      height: hSpace,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: StyleButton(
                                            AppLocalizations.of(context)!
                                                .chatWithDriver,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Chat(
                                                          orderNo: controller
                                                              .orders[
                                                                  widget.index]
                                                              .orderNo,
                                                          userId: controller
                                                              .orders[
                                                                  widget.index]
                                                              .userId,
                                                          driverId: controller
                                                              .orders[
                                                                  widget.index]
                                                              .deliveryId,
                                                          phone: controller
                                                              .orders[
                                                                  widget.index]
                                                              .deliveryphone)));
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: StyleButton(
                                              AppLocalizations.of(context)!
                                                  .doneUser,
                                              sideColor: kConfirm,
                                              backgroundColor: kConfirm,
                                              onPressed: () async {
                                                showDialoge(
                                                  context,
                                                  message3: Column(),
                                                  message1: AppLocalizations.of(
                                                          context)!
                                                      .confirm,
                                                  message2: AppLocalizations.of(
                                                          context)!
                                                      .areYouDeliverded,
                                                  button1: AppLocalizations.of(
                                                          context)!
                                                      .confirm,
                                                  button2: AppLocalizations.of(
                                                          context)!
                                                      .cancel,
                                                  colorButton1: kConfirm,
                                                  colorButton2: kSpecialColor,
                                                  iconMeassge: Icon(
                                                    Icons.next_plan_sharp,
                                                    color: kConfirm,
                                                    size: SizeConfig
                                                        .scaleTextFont(50),
                                                  ),
                                                  onPressed: () async {
                                                    // print('deliveredOrder');
                                                    await deliveredrmDeliveryOrder(
                                                        orderId: controller
                                                            .orders[
                                                                widget.index]
                                                            .id);
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const MainScreen(
                                                                  currentIndex:
                                                                      1,
                                                                  orderIndex: 1,
                                                                )));
                                                    helper(
                                                        context: context,
                                                        message:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .pleaseRate,
                                                        error: true);
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
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
                                                      driver: true,
                                                      id: controller
                                                          .orders[widget.index]
                                                          .id,
                                                    );
                                                  },
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
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
      ),
    );
  }

  Future deliveredrmDeliveryOrder({required int orderId}) async {
    await controller.Delivered(context: context, order_id: orderId);
  }
}

class RowProduct2 extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;

  RowProduct2(
      {this.text1 = "", this.text2 = "", this.text3 = "", this.text4 = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: hSpace,
        bottom: hSpaceSmall,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: StyleText(
              text1,
              textColor: kSpecialColor,
              textAlign: TextAlign.start,
              maxLines: 2,
              height: SizeConfig.scaleHeight(2),
            ),
          ),
          Expanded(
            flex: 1,
            child: StyleText(
              text2,
              maxLines: 2,
            ),
          ),
          Expanded(
            flex: 2,
            child: StyleText(
              text3,
              textColor: kSpecialColor,
              maxLines: 2,
              height: SizeConfig.scaleHeight(2),
            ),
          ),
          Expanded(
            flex: 2,
            child: StyleText(
              text4,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
