import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/expantion_tile.dart';
import 'package:producer_family_app/components/headers/header_app.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

class Statistics extends StatefulWidget {
  final bool family;

  const Statistics({this.family = false});

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  bool discribion = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    managenotificationAction(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: wPadding,
          end: wPadding,
          bottom: hPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerApp(
                context,
                title: AppLocalizations.of(context)!.statistics,
              ),
              GetX<GetNetworkGetx>(
                  init: GetNetworkGetx(),
                  builder: (GetNetworkGetx network) {
                    return network.connectionType.value == 0
                        ? Column(
                            children: [
                              noContent(context,
                                  AppLocalizations.of(context)!.noInternet),
                              SizedBox(
                                height: SizeConfig.scaleHeight(30),
                              ),
                              StyleButton(AppLocalizations.of(context)!.refresh,
                                  sideColor: kSpecialColor,
                                  backgroundColor: kSpecialColor,
                                  onPressed: () async {
                                await network.refreshData();
                              })
                            ],
                          )
                        : GetX<GetstatisticsGetx>(
                            init: GetstatisticsGetx(),
                            builder: (GetstatisticsGetx controller) {
                              return controller.isLoading.value
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: SizeConfig.scaleHeight(350),
                                        ),
                                        Center(child: indicatorNourahLoading()),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 10,
                                              child: ContainerApp(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                    bottom: hSpaceLarge,
                                                    top: hSpace,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: SizedBox(
                                                                child:
                                                                    StyleText(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .orders,
                                                            )),
                                                          ),
                                                          const Expanded(
                                                            child: StyleText(
                                                              "|",
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: SizedBox(
                                                              child: StyleText(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .completed,
                                                              ),
                                                            ),
                                                          ),
                                                          const Expanded(
                                                            child: StyleText(
                                                              "|",
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: SizedBox(
                                                              child: StyleText(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .requested,
                                                              ),
                                                            ),
                                                          ),
                                                          const Expanded(
                                                            child: StyleText(
                                                              "|",
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: SizedBox(
                                                              child: StyleText(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .bonus,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: hSpaceLarge,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: StyleText(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .daily,
                                                              textColor:
                                                                  kSpecialColor,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: StyleText(
                                                                "${controller.statistices['todaystatistics'] != null ? controller.statistices['todaystatistics']["completed_orders"] ?? 0 : 0}"
                                                                // :"",
                                                                ),
                                                          ),
                                                          Expanded(
                                                            child: StyleText(
                                                              "${controller.statistices['todaystatistics'] != null ? controller.statistices['todaystatistics']["required_orders_count"] ?? 0 : 10}",
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: StyleText(
                                                              "${controller.statistices['todaystatistics'] != null ? controller.statistices['todaystatistics']["bouns_orders"] ?? 0 : 0}",
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (discribion ==
                                                            false) {
                                                          discribion = true;
                                                        } else {
                                                          discribion = false;
                                                        }
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .announcement_outlined,
                                                      color: discribion == false
                                                          ? kSpecialColor
                                                          : kSpecialColor,
                                                    )))
                                          ],
                                        ),
                                        if (discribion == true)
                                          ContainerApp(
                                            child: Padding(
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                  bottom: hSpaceLarge,
                                                  top: hSpace,
                                                  end: wSpace,
                                                  start: wSpace,
                                                ),
                                                child: StyleText(
                                                  "في حال قدمتم أكثر من 3 طلبيات فإنه سيكون لكم بونص ولا يوجد أي عمولة للتطبيق",
                                                  textColor: kSpecialColor,
                                                  fontSize:
                                                      SizeConfig.scaleTextFont(
                                                          20),
                                                  height:
                                                      SizeConfig.scaleHeight(3),
                                                )),
                                          )
                                        else
                                          Column(),
                                        dividerApp(),
                                        MainExpantion(
                                          initiallyExpanded: true,
                                          mainTitle:
                                              "${AppLocalizations.of(context)!.statistics} ${AppLocalizations.of(context)!.currentt}    ${controller.statistices['currentstatistics'] != null ? controller.statistices['currentstatistics']['start_date'] : ''}",
                                          column: controller.isLoading.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive())
                                              : Column(
                                                  children: [
                                                    ContainerApp(
                                                        child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        numbers(
                                                          context,
                                                          title: AppLocalizations
                                                                  .of(context)!
                                                              .completeOrders,
                                                          icon: Icons
                                                              .shopping_cart_outlined,
                                                          value:
                                                              "${controller.statistices['currentstatistics'] != null ? controller.statistices['currentstatistics']['completed_orders'] : "0"}",
                                                        ),
                                                        numbers(
                                                          context,
                                                          title: AppLocalizations
                                                                  .of(context)!
                                                              .bonusOrders,
                                                          icon: Icons
                                                              .all_inclusive,
                                                          value:
                                                              "${controller.statistices['currentstatistics'] != null ? controller.statistices['currentstatistics']['bouns_orders'] : "0"}",
                                                        ),
                                                        // numbers(
                                                        //   context,
                                                        //   title: AppLocalizations.of(context)!.pendingOrders,
                                                        //   icon: Icons.pending_actions,
                                                        //   value: "${controller.statistices['currentstatistics']!=null?controller.statistices['currentstatistics']['pendding_orders']:"0"}",
                                                        // ),
                                                        // numbers(
                                                        //   context,
                                                        //   title: AppLocalizations.of(context)!.canceledOrders,
                                                        //   icon: Icons.cancel_outlined,
                                                        //   value: "${controller.statistices['currentstatistics']!=null?controller.statistices['currentstatistics']['cancel_orders']:"0"}",
                                                        // ),
                                                        if (widget.family ==
                                                            true)
                                                          numbers(
                                                            context,
                                                            title: AppLocalizations
                                                                    .of(context)!
                                                                .sales,
                                                            icon: Icons
                                                                .alarm_add_outlined,
                                                            value:
                                                                "${controller.statistices['currentstatistics'] != null ? controller.statistices['currentstatistics']['offers'] : "0"}",
                                                          ),
                                                        if (widget.family ==
                                                            true)
                                                          numbers(
                                                            context,
                                                            title: AppLocalizations
                                                                    .of(context)!
                                                                .soldProducts,
                                                            icon: Icons
                                                                .fastfood_outlined,
                                                            value:
                                                                "${controller.statistices['currentstatistics'] != null ? controller.statistices['currentstatistics']['sales'] : "0"}",
                                                          ),
                                                        if (widget.family ==
                                                            true)
                                                          numbers(
                                                            context,
                                                            title: AppLocalizations
                                                                    .of(context)!
                                                                .totalProducts,
                                                            icon: Icons
                                                                .work_outline_sharp,
                                                            value:
                                                                "${controller.statistices['currentstatistics'] != null ? controller.statistices['currentstatistics']['products'] : "0"}",
                                                          ),
                                                        numbers(
                                                          context,
                                                          title: AppLocalizations
                                                                  .of(context)!
                                                              .totalAmount,
                                                          icon: Icons
                                                              .monetization_on_rounded,
                                                          value:
                                                              "${controller.statistices['currentstatistics'] != null ? controller.statistices['currentstatistics']['total'] : "0"} ${AppLocalizations.of(context)!.reyal}",
                                                        ),
                                                        numbers(
                                                          context,
                                                          title: AppLocalizations
                                                                  .of(context)!
                                                              .applicationCommission,
                                                          icon: Icons.money_off,
                                                          value:
                                                              "${controller.statistices['currentstatistics'] != null ? controller.statistices['currentstatistics']['commission'] : "0"} ${AppLocalizations.of(context)!.reyal}",
                                                        ),
                                                        numbers(
                                                          context,
                                                          title: AppLocalizations
                                                                  .of(context)!
                                                              .profits,
                                                          icon: Icons
                                                              .monetization_on_outlined,
                                                          value:
                                                              "${controller.statistices['currentstatistics'] != null ? controller.statistices['currentstatistics']['profit'] : "0"} ${AppLocalizations.of(context)!.reyal}",
                                                        ),
                                                      ],
                                                    ))
                                                  ],
                                                ),
                                        ),
                                        GetX<GetCoulmnstatisticsGetx>(
                                            init: GetCoulmnstatisticsGetx(),
                                            builder: (GetCoulmnstatisticsGetx
                                                controller) {
                                              return controller.isLoading.value
                                                  ? Center(
                                                      child:
                                                          indicatorNourahLoading())
                                                  : controller.statistices
                                                          .isNotEmpty
                                                      ? Column(
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  hSpaceLargev,
                                                            ),
                                                            dividerApp(),
                                                            SizedBox(
                                                              height:
                                                                  hSpaceLargev,
                                                            ),
                                                            StyleText(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .archieve,
                                                              textColor:
                                                                  kSpecialColor,
                                                              textDecoration:
                                                                  TextDecoration
                                                                      .underline,
                                                            ),
                                                            SizedBox(
                                                                height: hSpace),
                                                            ListView.builder(
                                                              // reverse: true,
                                                              shrinkWrap: true,
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              itemCount:
                                                                  controller
                                                                      .statistices
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                int reverseIndex =
                                                                    controller
                                                                            .statistices
                                                                            .length -
                                                                        1 -
                                                                        index;

                                                                return MainExpantion(
                                                                  mainTitle:
                                                                      "( ${reverseIndex + 1} )    ${AppLocalizations.of(context)!.archieve}    ${controller.statistices[index].startDate}",
                                                                  column: controller
                                                                          .isLoading
                                                                          .value
                                                                      ? const Center(
                                                                          child:
                                                                              CircularProgressIndicator.adaptive())
                                                                      : Column(
                                                                          children: [
                                                                            ContainerApp(
                                                                                child: Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                numbers(
                                                                                  context,
                                                                                  title: AppLocalizations.of(context)!.completeOrders,
                                                                                  icon: Icons.shopping_cart_outlined,
                                                                                  value: "${controller.statistices[index].completedOrders}",
                                                                                ),
                                                                                numbers(
                                                                                  context,
                                                                                  title: AppLocalizations.of(context)!.bonusOrders,
                                                                                  icon: Icons.all_inclusive,
                                                                                  value: "${controller.statistices[index].bounsOrders}",
                                                                                ),
                                                                                numbers(
                                                                                  context,
                                                                                  title: AppLocalizations.of(context)!.pendingOrders,
                                                                                  icon: Icons.pending_actions,
                                                                                  value: "${controller.statistices[index].penddingOrders}",
                                                                                ),
                                                                                numbers(
                                                                                  context,
                                                                                  title: AppLocalizations.of(context)!.canceledOrders,
                                                                                  icon: Icons.cancel_outlined,
                                                                                  value: "${controller.statistices[index].cancelOrders}",
                                                                                ),
                                                                                if (widget.family == true)
                                                                                  numbers(
                                                                                    context,
                                                                                    title: AppLocalizations.of(context)!.sales,
                                                                                    icon: Icons.alarm_add_outlined,
                                                                                    value: "${controller.statistices[index].offers}",
                                                                                  ),
                                                                                if (widget.family == true)
                                                                                  numbers(
                                                                                    context,
                                                                                    title: AppLocalizations.of(context)!.soldProducts,
                                                                                    icon: Icons.fastfood_outlined,
                                                                                    value: "${controller.statistices[index].sales}",
                                                                                  ),
                                                                                if (widget.family == true)
                                                                                  numbers(
                                                                                    context,
                                                                                    title: AppLocalizations.of(context)!.totalProducts,
                                                                                    icon: Icons.work_outline_sharp,
                                                                                    value: "${controller.statistices[index].products}",
                                                                                  ),
                                                                                numbers(
                                                                                  context,
                                                                                  title: AppLocalizations.of(context)!.totalAmount,
                                                                                  icon: Icons.monetization_on_rounded,
                                                                                  value: "${controller.statistices[index].total}",
                                                                                ),
                                                                                numbers(
                                                                                  context,
                                                                                  title: AppLocalizations.of(context)!.applicationCommission,
                                                                                  icon: Icons.money_off,
                                                                                  value: "${controller.statistices[index].commission}",
                                                                                ),
                                                                                numbers(
                                                                                  context,
                                                                                  title: AppLocalizations.of(context)!.profits,
                                                                                  icon: Icons.monetization_on_outlined,
                                                                                  value: "${controller.statistices[index].profit}",
                                                                                ),
                                                                              ],
                                                                            ))
                                                                          ],
                                                                        ),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        )
                                                      : Column();
                                              // noContent(
                                              //             context,
                                              //             AppLocalizations.of(
                                              //                     context)!
                                              //                 .thereIsnoArchieve,
                                              //             height: 250);
                                            })
                                      ],
                                    );
                            });
                  }),
            ],
          ),
        ),
      ),
    ));
  }

  Padding numbers(BuildContext context,
      {required String title, required IconData icon, String value = ""}) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: SizeConfig.scaleWidth(20),
        top: SizeConfig.scaleHeight(10),
        bottom: SizeConfig.scaleHeight(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  icon,
                  color: kSpecialColor,
                  size: fIcon,
                ),
                const Spacer(),
                StyleText(
                  title,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: StyleText(
              value,
            ),
          ),
        ],
      ),
    );
  }
}
