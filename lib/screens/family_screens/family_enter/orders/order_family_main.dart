import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

import 'widget_orders_family.dart';

class OrderScreenFamilyMain extends StatefulWidget {
  final int orderIndex;
  const OrderScreenFamilyMain({
    this.orderIndex = 0,
  });
  @override
  _OrderScreenFamilyMainState createState() => _OrderScreenFamilyMainState();
}

class _OrderScreenFamilyMainState extends State<OrderScreenFamilyMain>
    with SingleTickerProviderStateMixin {
  List<Widget> screensTab = [
    WidgetOrdersFamily(),
    WidgetOrdersFamily(),
    WidgetOrdersFamily(),
  ];
  int _selectedIndex = 2;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    managenotificationAction(context);

    _tabController = TabController(length: screensTab.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    _tabController.animateTo(
        Provider.of<intIndexorder>(context, listen: false).intIndex != null
            ? Provider.of<intIndexorder>(context, listen: false).intIndex!
            : 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  getProfileGetx cont = Get.find();

  @override
  Widget build(BuildContext context) {
    return tapsApp(context);
  }

  Scaffold tapsApp(BuildContext context) {
    return Scaffold(
      appBar: appBarTaps(
        context,
        selectedIndexx: _selectedIndex,
        tabController: _tabController,
        tap1: AppLocalizations.of(context)!.waiting,
        tap2: AppLocalizations.of(context)!.currentt,
        tap3: AppLocalizations.of(context)!.end,
        tap3Exist: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
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
                    : GetX<getOrderFamilyGetX>(
                        init: getOrderFamilyGetX(
                          language:
                              Localizations.localeOf(context).languageCode ==
                                      "ar"
                                  ? "ar"
                                  : "en",
                        ),
                        builder: (getOrderFamilyGetX controller1) {
                          Future<void> getData() async {
                            await controller1.refreshData();
                          }

                          return RefreshIndicator(
                              onRefresh: getData,
                              child: cont.profile['available'] == 1
                                  ? controller1.isLoading.value
                                      ? Center(
                                          child:
                                              indicatorNourahLoadingSpecial())
                                      : controller1.orders.isNotEmpty
                                          ? ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount:
                                                  controller1.orders.length,
                                              itemBuilder: (context, index) {
                                                int reverseIndex =
                                                    controller1.orders.length -
                                                        1 -
                                                        index;

                                                return controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .status ==
                                                            0 &&
                                                        controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .familyReply ==
                                                            0
                                                    ? WidgetOrdersFamily(
                                                        controller1:
                                                            controller1,
                                                        length: controller1
                                                            .orders.length,
                                                        familyReply: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyReply,
                                                        orderNo: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .orderNo,
                                                        createdAt: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .createdAt,
                                                        familyrate: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyrate,
                                                        familycomment:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .familycomment,
                                                        id: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .id,
                                                        deliveryphone:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .deliveryphone,
                                                        familyId: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyId,
                                                        deliveryId: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryId,
                                                        orderDuration:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .orderDuration,
                                                        controller: controller1,
                                                        userId: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .userId,
                                                        familyNotes: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyNotes,
                                                        clientNotes: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .clientNotes,
                                                        orderCost: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .orderCost,
                                                        index: reverseIndex,
                                                        orderDurationUnit:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .orderDurationUnit,
                                                        waiting: true,
                                                      )
                                                    : Column();
                                              })
                                          : noContent(
                                              context,
                                              AppLocalizations.of(context)!
                                                  .thereIsnoOrders)
                                  : Center(
                                      child: StyleText(AppLocalizations.of(
                                              context)!
                                          .youHaveSuspendedYourAccountFromYourProfile)));
                        });
              }),
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
                    : GetX<getOrderFamilyGetX>(
                        init: getOrderFamilyGetX(
                          language:
                              Localizations.localeOf(context).languageCode ==
                                      "ar"
                                  ? "ar"
                                  : "en",
                        ),
                        builder: (getOrderFamilyGetX controller1) {
                          Future<void> getData() async {
                            await controller1.refreshData();
                          }

                          return RefreshIndicator(
                              onRefresh: getData,
                              child: cont.profile['available'] == 1
                                  ? controller1.isLoading.value
                                      ? Center(
                                          child:
                                              indicatorNourahLoadingSpecial())
                                      : controller1.orders.isNotEmpty
                                          ? ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              // shrinkWrap: true,
                                              itemCount:
                                                  controller1.orders.length,
                                              itemBuilder: (context, index) {
                                                int reverseIndex =
                                                    controller1.orders.length -
                                                        1 -
                                                        index;

                                                return controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .status ==
                                                            1 &&
                                                        controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .familyReply ==
                                                            1
                                                    ? WidgetOrdersFamily(
                                                        length: controller1
                                                            .orders.length,
                                                        familyReply: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyReply,
                                                        orderNo: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .orderNo,
                                                        createdAt: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .createdAt,
                                                        ready: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .ready,
                                                        driverDuration: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryDuration,
                                                        driverDurationUnit:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .deliveryDurationUnit,
                                                        familyrate: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyrate,
                                                        familycomment:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .familycomment,
                                                        id: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .id,
                                                        deliveryphone:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .deliveryphone,
                                                        familyId: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyId,
                                                        deliveryId: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryId,
                                                        orderDuration:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .orderDuration,
                                                        userId: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .userId,
                                                        familyNotes: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyNotes,
                                                        clientNotes: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .clientNotes,
                                                        orderCost: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .orderCost,
                                                        index: reverseIndex,
                                                        orderDurationUnit:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .orderDurationUnit,
                                                        current: true,
                                                        controller: controller1,
                                                      )
                                                    : Column();
                                              })
                                          : noContent(
                                              context,
                                              AppLocalizations.of(context)!
                                                  .thereIsnoOrders)
                                  : Center(
                                      child: StyleText(AppLocalizations.of(
                                              context)!
                                          .youHaveSuspendedYourAccountFromYourProfile)));
                        });
              }),
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
                    : GetX<getOrderFamilyGetX>(
                        init: getOrderFamilyGetX(
                          language:
                              Localizations.localeOf(context).languageCode ==
                                      "ar"
                                  ? "ar"
                                  : "en",
                        ),
                        builder: (getOrderFamilyGetX controller1) {
                          Future<void> getData() async {
                            await controller1.refreshData();
                          }

                          return RefreshIndicator(
                              onRefresh: getData,
                              child: controller1.isLoading.value
                                  ? Center(
                                      child: indicatorNourahLoadingSpecial())
                                  : controller1.orders.isNotEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          // shrinkWrap: true,
                                          itemCount: controller1.orders.length,
                                          itemBuilder: (context, index) {
                                            int reverseIndex =
                                                controller1.orders.length -
                                                    1 -
                                                    index;

                                            return controller1
                                                        .orders[reverseIndex]
                                                        .paid ==
                                                    0
                                                ? Column()
                                                : controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .status ==
                                                            2 ||
                                                        controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .status ==
                                                            3 ||
                                                        controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .status ==
                                                            4
                                                    ? WidgetOrdersFamily(
                                                        length: controller1
                                                            .orders.length,
                                                        controller: controller1,
                                                        familyReply: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyReply,
                                                        orderNo: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .orderNo,
                                                        createdAt: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .createdAt,
                                                        familyrate: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyrate,
                                                        familycomment:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .familycomment,
                                                        id: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .id,
                                                        deliveryphone:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .deliveryphone,
                                                        familyId: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyId,
                                                        deliveryId: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryId,
                                                        status: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .status,
                                                        orderDuration:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .orderDuration,
                                                        driverDuration: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryDuration,
                                                        driverDurationUnit:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .deliveryDurationUnit,
                                                        userId: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .userId,
                                                        familyNotes: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .familyNotes,
                                                        clientNotes: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .clientNotes,
                                                        orderCost: controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .orderCost,
                                                        orderDurationUnit:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .orderDurationUnit,
                                                        familyOrderRate:
                                                            controller1
                                                                .orders[
                                                                    reverseIndex]
                                                                .familyorderRate,
                                                        index: reverseIndex,
                                                        familyOrderbool: controller1
                                                                        .orders[
                                                                            reverseIndex]
                                                                        .status ==
                                                                    3 &&
                                                                controller1
                                                                        .orders[
                                                                            reverseIndex]
                                                                        .familyorderRate !=
                                                                    null
                                                            ? true
                                                            : false,
                                                        end: true,
                                                      )
                                                    : Column();
                                          })
                                      : noContent(
                                          context,
                                          AppLocalizations.of(context)!
                                              .thereIsnoOrders));
                        });
              }),
        ],
      ),
    );
  }
}
