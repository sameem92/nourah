import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/card_app.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/details_order_user.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/choose_driver_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/follow_order_user.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WidgetOrderUser extends StatefulWidget {
  bool end;
  bool current;
  bool waiting;
  int status;

  WidgetOrderUser(
      {this.end = false,
      this.current = false,
      this.waiting = false,
      this.status = 0});

  @override
  _WidgetOrderUserState createState() => _WidgetOrderUserState();
}

class _WidgetOrderUserState extends State<WidgetOrderUser> {
  late TextEditingController comment;
  double? value;
  double? value2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    comment = TextEditingController();
    comment.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    comment.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<getOrderGetX>(
        init: getOrderGetX(),
        builder: (getOrderGetX controller) {
          return Padding(
            padding: EdgeInsetsDirectional.only(
              start: wPadding,
              end: wPadding,
              top: wPadding,
              bottom: wPadding,
            ),
            child: controller.isLoading.value
                ? Center(child: indicator_nourah_loading())
                : controller.orders.length != 0
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.orders.length,
                        itemBuilder: (context, index) {
                          return controller.orders[index].status ==
                                  widget.status
                              ? card_app(
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: hSpace,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.scaleWidth(390),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (controller.orders[index]
                                                        .createdAt !=
                                                    null &&
                                                controller.orders[index]
                                                        .createdAt !=
                                                    "")
                                              StyleText(
                                                controller
                                                    .orders[index].createdAt,
                                              ),
                                            if (controller.orders[index]
                                                        .createdAt !=
                                                    null &&
                                                controller.orders[index]
                                                        .createdAt !=
                                                    "")
                                              SizedBox(
                                                width: wSpaceLargev,
                                              ),
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
                                                )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                          width: SizeConfig.scaleWidth(400),
                                          child: divider_app(),),

                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          image_circle(
                                       imageString:        controller
                                                  .orders[index].familyimage,
                                              radius: 38),
                                          SizedBox(
                                            width: SizeConfig.scaleWidth(6),
                                          ),
                                          SizedBox(
                                            width: wBetweenCard,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: wBetweenCard,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        flex: 12,
                                                        child: StyleText(
                                                          controller
                                                              .orders[index]
                                                              .familyname,
                                                          textColor:
                                                              kSecondaryColor,
                                                          // width: SizeConfig.scaleWidth(245),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            StyleText(
                                                              "${controller.orders[index].familyrate} ",
                                                              textAlign:
                                                                  TextAlign.end,
                                                              height: 1.4,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
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
                                                SizedBox(
                                                  width: wBetweenCard,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: StyleText(
                                                          "${controller.orders[index].orderDuration}  ${controller.orders[index].orderDurationUnit == "h" ? AppLocalizations.of(context)!.hour : "${controller.orders[index].orderDurationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                                          textColor:
                                                              kSpecialColor,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StyleText(
                                                          "${controller.orders[index].orderCost}  ${AppLocalizations.of(context)!.reyal}",
                                                          textColor:
                                                              kSpecialColor,
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (widget.waiting != true)
                                        divider_app(height: 20),
                                      if (widget.waiting != true)
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            image_circle(
                                           imageString:      controller.orders[index]
                                                    .deliveryimage,
                                                size: 90),
                                            SizedBox(
                                              width: SizeConfig.scaleWidth(5),
                                            ),
                                            SizedBox(
                                              width: wBetweenCard,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: wBetweenCard,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex: 12,
                                                          child: StyleText(
                                                            controller
                                                                .orders[index]
                                                                .deliveryname,
                                                            textColor:
                                                                kSecondaryColor,
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              StyleText(
                                                                "${controller.orders[index].deliveryrate} ",
                                                                // width: SizeConfig.scaleWidth(40),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                height: 1.4,
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                                size:
                                                                    fIconSmall,
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
                                                  SizedBox(
                                                    width: wBetweenCard,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: StyleText(
                                                            "${controller.orders[index].deliveryDuration}  ${controller.orders[index].deliveryDurationUnit == "h" ? AppLocalizations.of(context)!.hour : "${controller.orders[index].deliveryDurationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                                            textColor:
                                                                kSpecialColor,
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: StyleText(
                                                            "${controller.orders[index].shippingCost}  ${AppLocalizations.of(context)!.reyal}",

                                                            textColor:
                                                                kSpecialColor,
                                                            // width: SizeConfig.scaleWidth(157),
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  // Spacer(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      divider_app(height: 15),
                                      SizedBox(
                                        width: wAllCard,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: wSpaceSmall,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: StyleButton(
                                                AppLocalizations.of(context)!
                                                    .details,
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailsOrderUser(
                                                          end: widget.end,
                                                          index: index,
                                                          current:
                                                              widget.current,
                                                          waiting:
                                                              widget.waiting,
                                                        ),
                                                      ));
                                                },
                                                backgroundColor: kSpecialColor,
                                                sideColor: kSpecialColor,
                                              ),
                                            ),
                                            if (widget.end == true &&
                                                controller.orders[index]
                                                        .familyrate ==
                                                    null)
                                              SizedBox(
                                                width: wSpaceSmall,
                                              ),
                                            if (widget.end == true &&
                                                controller.orders[index]
                                                        .familyrate ==
                                                    null)
                                              Expanded(
                                                flex: 2,
                                                child: StyleButton(
                                                  AppLocalizations.of(context)!
                                                      .rateorder,
                                                  onPressed: () async {
                                                    await rate_dailoge(context,
                                                        controller, index);
                                                  },
                                                  backgroundColor:
                                                      kConfirm,
                                                  sideColor: kConfirm,
                                                ),
                                              ),
                                            if (widget.current == true)
                                              SizedBox(
                                                width: wSpaceSmall,
                                              ),
                                            if (widget.current == true)
                                              Expanded(
                                                flex: 2,
                                                child: StyleButton(
                                                  AppLocalizations.of(context)!
                                                      .followorder,

                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              FollowOrderUser(
                                                                  index: index),
                                                        ));
                                                  },
                                                  backgroundColor:
                                                      kConfirm,
                                                  sideColor: kConfirm,
                                                  // onPressed: onPressed,
                                                ),
                                              ),
                                            if (widget.waiting == true)
                                              Expanded(
                                                flex: 3,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: wSpaceSmall,
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: StyleButton(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .chooseyourdriver,
                                                        onPressed: () async {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ChooseDriverScreen(
                                                                      index:
                                                                          index),
                                                            ),
                                                          );
                                                        },
                                                        backgroundColor:
                                                            kSpecialColor,
                                                        sideColor:
                                                            kSpecialColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: wSpaceSmall,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: StyleButton(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .cancel,
                                                        backgroundColor:
                                                            kRefuse,
                                                        sideColor: kRefuse,
                                                        onPressed: () async {
                                                          await cancel_dialoge(
                                                              context,
                                                              controller,
                                                              index);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            SizedBox(
                                              width: wSpaceSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  special: false)
                              : Column();
                          // :  noContent(
                          // context, AppLocalizations.of(context)!.thereIsnoOrders);
                        })
                    : noContent(
                        context, AppLocalizations.of(context)!.thereIsnoOrders),
          );
        });
  }

  Future<void> cancel_dialoge(
      BuildContext context, getOrderGetX controller, int index) async {
    ShowDialoge(context, height: 310, onPressed: () async {
      await cancelOrder(id: "${controller.orders[index].id}");
      Navigator.pop(context);
      setState(() {});
      print("order ${controller.orders[index].id} canceled");
    },
        message3: SizedBox(),
        message1: AppLocalizations.of(context)!.cancelrequest,
        message2:
            AppLocalizations.of(context)!.areyousureaboutcancelingtherequest2,
        iconMeassge: Icon(
          Icons.warning_amber_outlined,
          color: kRefuse,
          size: SizeConfig.scaleHeight(80),
        ),
        colorButton1: kRefuse,
        colorButton2: kConfirm,
        button1: AppLocalizations.of(context)!.yes,
        button2: AppLocalizations.of(context)!.no);
  }

  Future<void> rate_dailoge(
      BuildContext context, getOrderGetX controller, int index) async {
    showDialog(
        context: context,
        builder: (context) {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  image_circle(imageString: controller.orders[index].familyimage),
                  SizedBox(
                    height: hSpace,
                  ),
                  StyleText(
                    controller.orders[index].familyname,
                    fontSize: fLargev,
                  ),
                  SizedBox(
                    height: hSpaceSmall,
                  ),
                  RatingBar.builder(
                      initialRating: 3,
                      direction: Axis.horizontal,
                      minRating: 1,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.all(4),
                      itemSize: fIconLarge,
                      unratedColor: Colors.grey,
                      updateOnDrag: true,
                      maxRating: 5,
                      itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: kSpecialColor,
                          ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          value = rating;
                        });
                      }),
                  SizedBox(
                    height: hSpaceSmall,
                  ),
                  StyleField(
                    title: AppLocalizations.of(context)!.comment,
                    controller: comment,
                    height: 70,
                    maxLines: 6,
                    isRequired: true,
                  ),
                  divider_app(),
                  image_circle(imageString: controller.orders[index].deliveryimage),
                  SizedBox(
                    height: hSpaceSmall,
                  ),
                  StyleText(
                    controller.orders[index].deliveryname,
                    fontSize: fLargev,
                  ),
                  SizedBox(
                    height: hSpaceSmall,
                  ),
                  RatingBar.builder(
                      initialRating: 3,
                      direction: Axis.horizontal,
                      minRating: 1,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.all(4),
                      itemSize: fIconLarge,
                      unratedColor: Colors.grey,
                      updateOnDrag: true,
                      maxRating: 5,
                      itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: kSpecialColor,
                          ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          value2 = rating;
                        });
                      }),
                  SizedBox(
                    height: hSpace,
                  ),
                  StyleButton(
                    AppLocalizations.of(context)!.confirm,
                    onPressed: () async {
                      await rate(
                        order_id: "${controller.orders[index].id}",
                        family_id: "${controller.orders[index].familyId}",
                        delivery_id: "${controller.orders[index].deliveryId}",
                      );
                      Navigator.pop(context);

                      print(
                          '${controller.orders[index].id},${controller.orders[index].familyId},${controller.orders[index].deliveryId}');
                    },
                    backgroundColor: kSpecialColor,
                    sideColor: kSpecialColor,
                    // width: SizeConfig.scaleWidth(130),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future rate(
      {String order_id = '',
      String family_id = '',
      String delivery_id = ''}) async {
    bool rateIt = await OrderController().rateOrdersController(
        order_id: order_id,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
        comment: comment.text,
        family_id: family_id,
        rate: "$value",
        delivery_id: delivery_id,
        delivery_rate: "$value2",
        context: context);
  }

  Future cancelOrder({String id = ""}) async {
    await OrderController().CancelOrderUserController(
        context: context,
        order_id: id,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en");
  }
}
