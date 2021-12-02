import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/row_product.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../components/containers/container_app.dart';

class DetailsOrderUser extends StatefulWidget {
  bool end;
  bool current;
  bool waiting;
  int index;

  DetailsOrderUser(
      {this.end = false,
      this.current = false,
      this.waiting = false,
      this.index = 0});
  @override
  State<DetailsOrderUser> createState() => _DetailsOrderUserState();
}

class _DetailsOrderUserState extends State<DetailsOrderUser> {
  @override
  Widget build(BuildContext context) {
    return GetX<getOrderGetX>(
        init: getOrderGetX(
          language: Localizations.localeOf(context).languageCode == "ar"
              ? "ar"
              : "en",
        ),
        builder: (getOrderGetX controller) {
          return Scaffold(
            appBar: AppBarWhite(
              context,
              title: AppLocalizations.of(context)!.details,
              onPressed: () {
                print(widget.index);
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
                  ? Center(
                      child: indicator_nourah_loading()
              )
                  : Column(
                      children: [
                        ContainerApp(
                            child: Padding(
                              padding: EdgeInsets.only(


                                left: wSpace,
                                right: wSpace,
                              ),                              child: Column(
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
                                      "${controller.orders[widget.index].orderNo}",textColor: kSpecialColor,textDecoration: TextDecoration.underline,
                                    ),
                                  ],
                                )),
                              divider_app(),
                              rowProductTitle(
                                notFirst: false,
                                text1: AppLocalizations.of(context)!.productName,
                                text2: AppLocalizations.of(context)!.quantity,
                                text3: AppLocalizations.of(context)!.price,
                                text4: AppLocalizations.of(context)!.totalPrice,
                              ),
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: controller
                                      .orders[widget.index].orderDetails.length,
                                  itemBuilder: (context, index) {
                                    return rowProductTitle(
                                      notFirst: false,
                                      text1: controller.orders[index]
                                          .orderDetails[index].productname,
                                      text2:
                                          "${controller.orders[index].orderDetails[index].qty}",
                                      text3:
                                          "${controller.orders[index].orderDetails[index].productprice}",
                                      text4:
                                          "${controller.orders[index].orderDetails[index].total}",
                                    );
                                  }),
                            SizedBox(
                              height: hSpace,
                            ), divider_app(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  rowProduct2(
                                    text1:widget.waiting!=true? AppLocalizations.of(context)!
                                        .deliveryCost:"",
                                    text2:widget.waiting!=true?
                                        "${controller.orders[widget.index].shippingCost}":"",
                                    text3:
                                        AppLocalizations.of(context)!.orderCost,
                                    text4:
                                        "${controller.orders[widget.index].orderCost}",
                                  ),
                                  rowProduct2(
                                    text1: AppLocalizations.of(context)!.discount,
                                    text2:
                                        "${controller.orders[widget.index].coupon} %",
                                    text3:
                                        AppLocalizations.of(context)!.totalCost,
                                    text4:
                                        "${controller.orders[widget.index].totalCost}",
                                  ),
                                  SizedBox(
                                    height: hSpace,
                                  ),
                                  divider_app(),
                                  SizedBox(
                                    height: hSpaceLarge,
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
                                  notes(
                                    note:
                                        "${controller.orders[widget.index].clientNotes}",
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
                                  notes(
                                    note:
                                        "${controller.orders[widget.index].familyNotes}",
                                  ),
                                  SizedBox(
                                    height: hSpace,
                                  ),

                                  if (widget.end == true &&
                                      controller
                                              .orders[widget.index].familyrate !=
                                          null)
                                    SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              StyleText(
                                                AppLocalizations.of(context)!
                                                    .rateorder,
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
                                                    "${controller.orders[widget.index].familyrate} ",
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
                                          notes(
                                            note:"${controller.orders[widget.index].familycomment} ",
                                          ),
                                          SizedBox(
                                            height: hSpaceLarge,
                                          ),
                                        ],
                                      ),
                                    ),

                                  // if (widget.endDetails == true)
                                  //   Row(
                                  //     children: [
                                  //       Spacer(),
                                  //       if (widget.endDetails == true)
                                  //         StyleButton('إعادة الطلب',
                                  //             sideColor: kConfirm,
                                  //             backgroundColor: kConfirm,
                                  //             onPressed: () {}),
                                  //     ],
                                  //   ),
                                ],
                              ),
                          ],
                        ),
                            )),
                      ],
                    ),
            ),
          );
        });
  }
}

class rowProduct2 extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;

  rowProduct2(
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
            ),
          ),
          Expanded(
            flex: 1,
            child: StyleText(text2),
          ),
          Expanded(
            flex: 2,
            child: StyleText(text3, textColor: kSpecialColor),
          ),
          Expanded(
            flex: 1,
            child: StyleText(text4),
          ),
        ],
      ),
    );
  }
}
