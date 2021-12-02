import 'package:flutter/material.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/headers/header_app.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/style/size_config.dart';

class Statistics extends StatefulWidget {
  bool family;

  Statistics({this.family=false});

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  String? valueChoose ;
 bool discribion=false;
  List? listItem ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: wPadding,
          end:wPadding,
          bottom:hPadding,
        ),
        child: SingleChildScrollView(
          child:  Column(
            children: [
              header_app(
                context,
                title: AppLocalizations.of(context)!.statistics,
              ),
              GetX<getstatisticsGetx>(
                  init: getstatisticsGetx(),
                  builder: (getstatisticsGetx controller) {
                    return controller.isLoading.value
                        ? Column(
                          children: [
                            SizedBox(height: SizeConfig.scaleHeight(350),),
                            Center(child: indicator_nourah_loading()  ),
                          ],
                        )
                        :
                    Column(
                      children: [


                        Row(
                          children: [
                            Expanded(

                              child: ContainerApp(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
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
                                                child: StyleText(
                                                  AppLocalizations.of(context)!.orders,
                                                )),
                                          ),
                                          Expanded(
                                            child: StyleText(
                                              "|",
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              child: StyleText(
                                                AppLocalizations.of(context)!.completed,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: StyleText(
                                              "|",
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              child: StyleText(
                                                AppLocalizations.of(context)!.requested,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: StyleText(
                                              "|",
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: SizedBox(
                                              child: StyleText(
                                                AppLocalizations.of(context)!.bonus,
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
                                              AppLocalizations.of(context)!.daily,
                                              textColor: kSpecialColor,
                                            ),
                                          ),
                                          Expanded(

                                            child: StyleText(
                                              controller.statistices['todaystatistics']["completed_orders"]!=null?
                                              "${controller
                                                  .statistices['todaystatistics']["completed_orders"] ??
                                                  ''}":"",
                                            ),
                                          ),
                                          Expanded(
                                            child: StyleText(
                                              "${controller
                                                  .statistices['todaystatistics']["required_orders_count"] ??
                                                  ''}",
                                            ),
                                          ),
                                          Expanded(
                                            child: StyleText(
                                              "${controller
                                                  .statistices['todaystatistics']["bouns_orders"] ??
                                                  ''}",
                                            ),
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30,child: IconButton(onPressed: (){
                              setState(() {
                                if(discribion==false) {
                                                discribion = true;
                                              }else{ discribion = false;}
                                            });

                            }, icon: Icon(Icons.announcement_outlined,color: kSecondaryColor,)))
                          ],
                        ),
                        discribion==true
                   ?     ContainerApp(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              bottom: hSpaceLarge,
                              top: hSpace,
                            ),
                            child:  StyleText("نبـذة عن البووووونص")
                          ),
                        )
                        :Column(),
                        // SizedBox(
                        //   height: hSpace,
                        // ),
                        divider_app(),
                        GetX<getCoulmnstatisticsGetx>(
                            init: getCoulmnstatisticsGetx(),
                            builder: (getCoulmnstatisticsGetx controller) {
                              int index = 0;
                              return  controller.isLoading.value
                                  ? Column(
                                children: [
                                  SizedBox(height: SizeConfig.scaleHeight(170),),
                                  Center(child: indicator_nourah_loading() ),
                                ],
                              )
                                  :
                              Column(
                                children: [

                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.statistices.length,
                                          itemBuilder: (context, indeX) {
                                            index = indeX;

                                            String valueChoose =
                                                "  ${AppLocalizations.of(context)!
                                                .archieve}  ${controller
                                                .statistices[0].startDate}";

                                            List listItem = [
                                              "  ${AppLocalizations.of(context)!
                                                  .archieve}  ${controller
                                                  .statistices[indeX].startDate}"
                                            ];
                                            return Column(
                                                children: [
                                                  SizedBox(
                                                    height: SizeConfig.scaleWidth(
                                                        60),
                                                    child: ContainerApp(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            left: wSpace,
                                                            right: wSpace),
                                                        child: DropdownButton(
                                                          dropdownColor: Colors
                                                              .white,
                                                          elevation: 2,
                                                          underline: SizedBox(),
                                                          style: TextStyle(
                                                            fontFamily: "Almarai",
                                                            color: kPrimaryColor,
                                                          ),
                                                          icon:
                                                          Icon(Icons
                                                              .arrow_drop_down_sharp),
                                                          iconSize: fIcon,
                                                          isExpanded: true,
                                                          value: valueChoose,
                                                          onChanged: (newValue) {
                                                            setState(() {
                                                              valueChoose = newValue
                                                                  .toString();
                                                            });
                                                          },
                                                          items: listItem.map((
                                                              valueItem) {
                                                            return DropdownMenuItem(
                                                                value: valueItem,
                                                                child: StyleText(
                                                                    valueItem));
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                          }),
                                      ContainerApp(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              numbers(
                                                context,
                                                title:
                                                AppLocalizations.of(context)!
                                                    .completeOrders,
                                                icon: Icons.shopping_cart_outlined,
                                                value:
                                                "${controller.statistices[index]
                                                    .completedOrders}",
                                              ),
                                              numbers(
                                                context,
                                                title: AppLocalizations.of(context)!
                                                    .bonusOrders,
                                                icon: Icons.all_inclusive,
                                                value:
                                                "${controller.statistices[index]
                                                    .bounsOrders}",
                                              ),
                                              numbers(
                                                context,
                                                title:
                                                AppLocalizations.of(context)!
                                                    .pendingOrders,
                                                icon: Icons.pending_actions,
                                                value:
                                                "${controller.statistices[index]
                                                    .penddingOrders}",
                                              ),
                                              numbers(
                                                context,
                                                title:
                                                AppLocalizations.of(context)!
                                                    .canceledOrders,
                                                icon: Icons.cancel_outlined,
                                                value:
                                                "${controller.statistices[index]
                                                    .cancelOrders}",
                                              ),
                                              if (widget.family == true)
                                                numbers(
                                                  context,
                                                  title: AppLocalizations.of(
                                                      context)!.sales,
                                                  icon: Icons.alarm_add_outlined,
                                                  value:
                                                  "${controller.statistices[index]
                                                      .offers}",
                                                ),
                                              if (widget.family == true)
                                                numbers(
                                                  context,
                                                  title:
                                                  AppLocalizations.of(context)!
                                                      .soldProducts,
                                                  icon: Icons.fastfood_outlined,
                                                  value: "${controller
                                                      .statistices[index].sales}",
                                                ),
                                              if (widget.family == true)
                                                numbers(
                                                  context,
                                                  title:
                                                  AppLocalizations.of(context)!
                                                      .totalProducts,
                                                  icon: Icons.work_outline_sharp,
                                                  value:
                                                  "${controller.statistices[index]
                                                      .products}",
                                                ),
                                              numbers(
                                                context,
                                                title: AppLocalizations.of(context)!
                                                    .totalAmount,
                                                icon: Icons.monetization_on_rounded,
                                                value: "${controller
                                                    .statistices[index].total}",
                                              ),
                                              numbers(
                                                context,
                                                title: AppLocalizations.of(context)!
                                                    .applicationCommission,
                                                icon: Icons.money_off,
                                                value:
                                                "${controller.statistices[index]
                                                    .commission}",
                                              ),
                                              numbers(
                                                context,
                                                title: AppLocalizations.of(context)!
                                                    .profits,
                                                icon: Icons
                                                    .monetization_on_outlined,
                                                value: "${controller
                                                    .statistices[index].profit}",
                                              ),
                                            ],
                                          )),

                                ],
                                );}

                            ),

                      ],
                    );
                  }
                    ),
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
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Icon(
                  icon,
                  color: kSpecialColor,
                  size: fIcon,
                ),

                Spacer(),
                StyleText(
                  title,
                  textAlign: TextAlign.start,


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
