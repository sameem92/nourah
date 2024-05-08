import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/components/containers/card_app.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/details_order_user.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

class WidgetOrderUser extends StatefulWidget {
  final bool end;
  final bool current;
  final bool waiting;
  final int deliveryReply;
  final dynamic familyOrderRate;
  final bool familyOrderRateBool;
  final getOrderGetX? controller;
  final int id;
  final int length;
  final int familyReply;
  final int orderDuration;
  final dynamic orderCost;
  final int userId;
  final int deliveryId;
  final int familyId;
  final int index;
  final dynamic familyrate;
  final String orderNo;
  final String deliveryDurationUnit;
  final String deliveryimage;
  final String familyname;
  final String createdAt;
  final String deliveryname;
  final String familyimage;
  final String clientNotes;
  final String familyNotes;
  final String orderDurationUnit;
  final String familycomment;
  final int deliveryDuration;
  final int shippingCost;
  final int ready;
  final int status;
  final dynamic deliveryrate;

  final String deliveryphone;
  const WidgetOrderUser({
    this.controller,
    this.shippingCost = 0,
    this.ready = 0,
    this.status = 0,
    this.deliveryDurationUnit = '',
    this.familyOrderRate,
    this.deliveryDuration = 0,
    this.deliveryrate = 0,
    this.deliveryimage = '',
    this.deliveryname = '',
    this.deliveryReply = 1,
    this.familyname = '',
    this.familyimage = '',
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
    this.familyOrderRateBool = false,
    this.waiting = false,
  });

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
    managenotificationAction(context);

    comment = TextEditingController();
    comment.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    comment.dispose();
    super.dispose();
  }

  getOrderGetX cont = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: wPadding,
        end: wPadding,
        top: wPadding,
        bottom: wPadding,
      ),
      child: cardApp(
        Column(
          children: [
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
            if (widget.end == true)
              SizedBox(
                height: hSpace,
              ),
            SizedBox(
              width: SizeConfig.scaleWidth(390),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (widget.createdAt != null && widget.createdAt != "")
                    StyleText(
                      widget.createdAt,
                      maxLines: 2,
                    ),
                  if (widget.createdAt != null && widget.createdAt != "")
                    Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StyleText(
                        "${AppLocalizations.of(context)!.orderNumber}   ",
                      ),
                      StyleText(
                        widget.orderNo,
                        textColor: kSpecialColor,
                        maxLines: 2,
                        textDecoration: TextDecoration.underline,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: SizeConfig.scaleWidth(400),
              child: dividerApp(),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ImageCircle(imageString: widget.familyimage, size: 90),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 12,
                              child: StyleText(
                                widget.familyname,
                                textColor: kSpecialColor,
                                // width: SizeConfig.scaleWidth(245),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  StyleText(
                                    "${widget.familyrate} ",
                                    textAlign: TextAlign.end,
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
                      SizedBox(
                        width: wBetweenCard,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: StyleText(
                                "${widget.orderDuration}  ${widget.orderDurationUnit == "h" ? AppLocalizations.of(context)!.hour : widget.orderDurationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                textColor: kSpecialColor,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              child: StyleText(
                                "${widget.orderCost}  ${AppLocalizations.of(context)!.reyal}",
                                textColor: kSpecialColor,
                                textAlign: TextAlign.end,
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
            if (widget.waiting != true) dividerApp(height: 20),
            if (widget.end || widget.current)
              widget.deliveryReply == 1
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ImageCircle(
                            imageString: widget.deliveryimage, size: 90),
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
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 12,
                                      child: StyleText(
                                        widget.deliveryname,
                                        textColor: kSpecialColor,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          StyleText(
                                            "${widget.deliveryrate} ",
                                            // width: SizeConfig.scaleWidth(40),
                                            textAlign: TextAlign.end,
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
                              SizedBox(
                                width: wBetweenCard,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: StyleText(
                                        "${widget.deliveryDuration}  ${widget.deliveryDurationUnit == "h" ? AppLocalizations.of(context)!.hour : widget.deliveryDurationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                        textColor: kSpecialColor,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Expanded(
                                      child: StyleText(
                                        "${widget.shippingCost}  ${AppLocalizations.of(context)!.reyal}",
                                        textColor: kSpecialColor,
                                        // width: SizeConfig.scaleWidth(157),
                                        textAlign: TextAlign.end,
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
                    )
                  : StyleText(AppLocalizations.of(context)!.noDeliverySelected
                      // "as"
                      ),
            dividerApp(height: 15),
            SizedBox(
              width: wAllCard,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: wSpaceSmall,
                  ),
                  Expanded(
                    flex: 3,
                    child: StyleButton(
                      AppLocalizations.of(context)!.details,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsOrderUser(
                                end: widget.end,
                                index: widget.index,
                                current: widget.current,
                                waiting: widget.waiting,
                                ready: widget.ready,
                                controller: widget.controller!,
                              ),
                            ));
                      },
                      backgroundColor: kSpecialColor,
                      sideColor: kSpecialColor,
                    ),
                  ),

                  if (widget.end == true)
                    if (widget.familyOrderRateBool == true)
                      // if(widget.familyOrderRate == null||widget.familyOrderRate == "")
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            SizedBox(
                              width: wSpaceSmall,
                            ),
                            Expanded(
                              flex: 2,
                              child: StyleButton(
                                AppLocalizations.of(context)!.rateorder,
                                onPressed: () async {
                                  await rateDailoge(
                                      context, cont, widget.index);
                                },
                                backgroundColor: kConfirm,
                                sideColor: kConfirm,
                              ),
                            ),
                          ],
                        ),
                      ),
                  SizedBox(
                    width: wSpaceSmall,
                  ),
                  // if (widget.current == true)
                  //   Expanded(
                  //     flex: 2,
                  //     child: StyleButton(
                  //       AppLocalizations.of(context)!
                  //           .followorder,
                  //
                  //       onPressed: () async{
                  //
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) =>
                  //                   FollowOrderUser(
                  //                       index: index),
                  //             ));
                  //       },
                  //       backgroundColor: kConfirm,
                  //       sideColor: kConfirm,
                  //       // onPressed: onPressed,
                  //     ),
                  //   ),
                  // if (widget.waiting == true)
                  //   Expanded(
                  //     flex: 3,
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           width: wSpaceSmall,
                  //         ),
                  //         Expanded(
                  //           flex: 3,
                  //           child: StyleButton(
                  //             AppLocalizations.of(
                  //                     context)!
                  //                 .chooseyourdriver,
                  //             onPressed: () async {
                  //               // Navigator.push(
                  //               //   context,
                  //               //   MaterialPageRoute(
                  //               //     builder: (context) =>
                  //               //         ChooseDriverScreen(
                  //               //             index:
                  //               //                 index),
                  //               //   ),
                  //               // );
                  //             },
                  //             backgroundColor:
                  //                 kSpecialColor,
                  //             sideColor:
                  //                 kSpecialColor,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: wSpaceSmall,
                  //         ),
                  //         Expanded(
                  //           flex: 2,
                  //           child: StyleButton(
                  //             AppLocalizations.of(
                  //                     context)!
                  //                 .cancel,
                  //             backgroundColor:
                  //                 kRefuse,
                  //             sideColor: kRefuse,
                  //             onPressed: () async {
                  //               await cancel_dialoge(
                  //                   context,
                  //                   controller,
                  //                   index);
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // SizedBox(
                  //   width: wSpaceSmall,
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: hSpace,
            ),
          ],
        ),
        special: false,
        colorContainer:
            widget.status == 4 ? Colors.grey.shade200 : Colors.white,
      ),
    );
  }

  Future<void> cancelDialoge(
      BuildContext context, getOrderGetX controller, int index) async {
    showDialoge(context, onPressed: () async {
      await cancelOrder(id: controller.orders[index].id);
      Navigator.pop(context);
      setState(() {});
      // print("order ${controller.orders[index].id} canceled");
    },
        message3: const SizedBox(),
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

  Future<void> rateDailoge(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageCircle(
                          imageString: controller.orders[index].familyimage),
                      SizedBox(
                        width: wSpaceLarge,
                      ),
                      StyleText(
                        controller.orders[index].familyname,
                        fontSize: fLargev,
                      ),
                    ],
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
                      itemPadding: const EdgeInsets.all(4),
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
                          // print("value   $value");
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
                  dividerApp(thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageCircle(
                          imageString: controller.orders[index].deliveryimage),
                      SizedBox(
                        width: wSpaceLarge,
                      ),
                      StyleText(
                        controller.orders[index].deliveryname,
                        fontSize: fLargev,
                      ),
                    ],
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
                      itemPadding: const EdgeInsets.all(4),
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
                          // print("value2  $value2");
                        });
                      }),
                  SizedBox(
                    height: hSpace,
                  ),
                  StyleButton(
                    AppLocalizations.of(context)!.rateorder,
                    onPressed: () async {
                      await rate(
                        orderId: "${controller.orders[index].id}",
                        familyId: "${controller.orders[index].familyId}",
                        deliveryId: "${controller.orders[index].deliveryId}",
                      );
                      Navigator.pop(context);

                      // print(
                      //     '${controller.orders[index].id},${controller.orders[index].familyId},${controller.orders[index].deliveryId}');
                    },
                    backgroundColor: kSpecialColor,
                    sideColor: kSpecialColor,
                    // width: SizeConfig.scaleWidth(130),
                  ),
                  SizedBox(
                    height: hSpace,
                  )
                ],
              ),
            ),
          );
        });
  }

  Future rate(
      {String orderId = '',
      String familyId = '',
      String deliveryId = ''}) async {
    await OrderController().rateOrdersController(
        orderId: orderId,
        language:
            Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
        comment: comment.text,
        familyId: familyId,
        rate: value != null ? "$value" : "3",
        deliveryId: deliveryId,
        deliveryRate: value2 != null ? "$value2" : "3",
        context: context);
    // print("value $value");
    // print("value2 $value2");
    // print("comment.text : ${comment.text}");
    // print("family_id : $familyId");
  }

  Future cancelOrder({required int id}) async {
    await cont.cancelOrder(
      context: context,
      id: id,
    );
  }
}
