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

import 'widget_orders_driver.dart';

class OrdersDriverMain extends StatefulWidget {
  final int orderIndex;
  // getOrderDriverGetX? controller;
  // getNewOrderDriverGetX? controller1;

  const OrdersDriverMain({this.orderIndex = 0});
  @override
  _OrdersDriverMainState createState() => _OrdersDriverMainState();
}

class _OrdersDriverMainState extends State<OrdersDriverMain>
    with SingleTickerProviderStateMixin {
  List<Widget> screensTab = [
    const WidgetOrdersDriver(),
    const WidgetOrdersDriver(),
    const WidgetOrdersDriver(),
  ];
  int _selectedIndex = 2;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    managenotificationAction(context);

    _tabController = TabController(length: screensTab.length, vsync: this);
    _tabController.animateTo(widget.orderIndex);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
    _tabController.animateTo(
      Provider.of<intIndexorder>(context, listen: false).intIndex != null
          ? Provider.of<intIndexorder>(context, listen: false).intIndex!
          : 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  getOrderDriverGetX controller = Get.put(getOrderDriverGetX());

  getProfileGetx controllerProfile = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTaps(
        context,
        tabController: _tabController,
        selectedIndexx: _selectedIndex,
        tap1: AppLocalizations.of(context)!.neworder,
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
                        noContent(
                            context, AppLocalizations.of(context)!.noInternet),
                        SizedBox(
                          height: SizeConfig.scaleHeight(30),
                        ),
                        StyleButton(
                          AppLocalizations.of(context)!.refresh,
                          sideColor: kSpecialColor,
                          backgroundColor: kSpecialColor,
                          onPressed: () async {
                            await network.refreshData();
                          },
                        )
                      ],
                    )
                  : GetX<getNewOrderDriverGetX>(
                      init: getNewOrderDriverGetX(
                        language:
                            Localizations.localeOf(context).languageCode == "ar"
                                ? "ar"
                                : "en",
                      ),
                      builder: (getNewOrderDriverGetX controller) {
                        Future<void> getData() async {
                          await controller.refreshValues();
                        }

                        return RefreshIndicator(
                          onRefresh: getData,
                          child: controllerProfile.profile['available'] == 1
                              ? controller.isLoading.value
                                  ? Center(
                                      child: indicatorNourahLoadingSpecial())
                                  : controller.newOrders.isNotEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              controller.newOrders.length,
                                          itemBuilder: (context, index) {
                                            final int reverseIndex =
                                                controller.newOrders.length -
                                                    1 -
                                                    index;

                                            return controller
                                                            .newOrders[
                                                                reverseIndex]
                                                            .status ==
                                                        0 &&
                                                    controller
                                                            .newOrders[
                                                                reverseIndex]
                                                            .deliveryReply ==
                                                        0
                                                ? WidgetOrdersDriver(
                                                    controller: controller,
                                                    length: controller
                                                        .newOrders.length,
                                                    familylat: controller
                                                        .newOrders[reverseIndex]
                                                        .familylat,
                                                    familylng: controller
                                                        .newOrders[reverseIndex]
                                                        .familylng,
                                                    newOrder: true,
                                                    createdAt: controller
                                                        .newOrders[reverseIndex]
                                                        .createdAt,
                                                    deliveryrate: controller
                                                        .newOrders[reverseIndex]
                                                        .deliveryrate,
                                                    familyaddress: controller
                                                        .newOrders[reverseIndex]
                                                        .familyaddress,
                                                    id: controller
                                                        .newOrders[reverseIndex]
                                                        .id,
                                                    familyphone: controller
                                                        .newOrders[reverseIndex]
                                                        .familyphone,
                                                    index: reverseIndex,
                                                    deliveryDurationUnit:
                                                        controller
                                                            .newOrders[
                                                                reverseIndex]
                                                            .deliveryDurationUnit,
                                                    deliveryDuration: controller
                                                        .newOrders[reverseIndex]
                                                        .deliveryDuration,
                                                    deliveryId: controller
                                                        .newOrders[reverseIndex]
                                                        .deliveryId,
                                                    orderDuration: controller
                                                        .newOrders[reverseIndex]
                                                        .orderDuration,
                                                    orderDurationUnit:
                                                        controller
                                                            .newOrders[
                                                                reverseIndex]
                                                            .orderDurationUnit,
                                                    clientname: controller
                                                        .newOrders[reverseIndex]
                                                        .clientname,
                                                    familyName: controller
                                                        .newOrders[reverseIndex]
                                                        .familyname,
                                                    shippingTo: controller
                                                        .newOrders[reverseIndex]
                                                        .shippingTo,
                                                    orderCost: controller
                                                        .newOrders[reverseIndex]
                                                        .orderCost,
                                                    clientNotes: controller
                                                        .newOrders[reverseIndex]
                                                        .clientNotes,
                                                    familyNotes: controller
                                                        .newOrders[reverseIndex]
                                                        .familyNotes,
                                                    clientlat: controller
                                                        .newOrders[reverseIndex]
                                                        .clientlat,
                                                    clientlng: controller
                                                        .newOrders[reverseIndex]
                                                        .clientlng,
                                                    orderNo: controller
                                                        .newOrders[reverseIndex]
                                                        .orderNo,
                                                    shippingCost: controller
                                                        .newOrders[reverseIndex]
                                                        .shippingCost,
                                                    familyId: controller
                                                        .newOrders[reverseIndex]
                                                        .familyId,
                                                    waiting: true,
                                                  )
                                                : Column();
                                          },
                                        )
                                      : noContent(
                                          context,
                                          AppLocalizations.of(context)!
                                              .thereIsnoOrders,
                                        )
                              : Center(
                                  child: StyleText(
                                    AppLocalizations.of(context)!
                                        .youHaveSuspendedYourAccountFromYourProfile,
                                  ),
                                ),
                        );
                      },
                    );
            },
          ),
          GetX<GetNetworkGetx>(
            init: GetNetworkGetx(),
            builder: (GetNetworkGetx network) {
              return network.connectionType.value == 0
                  ? Column(
                      children: [
                        noContent(
                            context, AppLocalizations.of(context)!.noInternet),
                        SizedBox(
                          height: SizeConfig.scaleHeight(30),
                        ),
                        StyleButton(
                          AppLocalizations.of(context)!.refresh,
                          sideColor: kSpecialColor,
                          backgroundColor: kSpecialColor,
                          onPressed: () async {
                            await network.refreshData();
                          },
                        )
                      ],
                    )
                  : GetX<getOrderDriverGetX>(
                      init: getOrderDriverGetX(
                        language:
                            Localizations.localeOf(context).languageCode == "ar"
                                ? "ar"
                                : "en",
                      ),
                      builder: (getOrderDriverGetX controller1) {
                        Future<void> getData() async {
                          await controller1.refreshValues();
                        }

                        return RefreshIndicator(
                          onRefresh: getData,
                          child: controllerProfile.profile['available'] == 1
                              ? controller1.isLoading.value
                                  ? Center(
                                      child: indicatorNourahLoadingSpecial())
                                  : controller1.orders.isNotEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          // shrinkWrap: true,
                                          itemCount: controller1.orders.length,
                                          itemBuilder: (context, index) {
                                            final int reverseIndex =
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
                                                        1 &&
                                                    controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .paid ==
                                                        1
                                                ? WidgetOrdersDriver(
                                                    length: controller1
                                                        .orders.length,
                                                    createdAt: controller1
                                                        .orders[reverseIndex]
                                                        .createdAt,
                                                    deliveryrate: controller1
                                                        .orders[reverseIndex]
                                                        .deliveryrate,
                                                    ready: controller1
                                                        .orders[reverseIndex]
                                                        .ready,
                                                    status: controller1
                                                        .orders[reverseIndex]
                                                        .status,
                                                    familyaddress: controller1
                                                        .orders[reverseIndex]
                                                        .familyaddress,
                                                    id: controller1
                                                        .orders[reverseIndex]
                                                        .id,
                                                    clientlng: controller1
                                                        .orders[reverseIndex]
                                                        .clientlng,
                                                    familylng: controller1
                                                        .orders[reverseIndex]
                                                        .familylng,
                                                    familylat: controller1
                                                        .orders[reverseIndex]
                                                        .familylat,
                                                    familyphone: controller1
                                                        .orders[reverseIndex]
                                                        .familyphone,
                                                    index: reverseIndex,
                                                    deliveryDurationUnit:
                                                        controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryDurationUnit,
                                                    deliveryDuration:
                                                        controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryDuration,
                                                    clientlat: controller1
                                                        .orders[reverseIndex]
                                                        .clientlat,
                                                    deliveryId: controller1
                                                        .orders[reverseIndex]
                                                        .deliveryId,
                                                    orderDuration: controller1
                                                        .orders[reverseIndex]
                                                        .orderDuration,
                                                    orderDurationUnit:
                                                        controller1
                                                            .orders[
                                                                reverseIndex]
                                                            .orderDurationUnit,
                                                    clientname: controller1
                                                        .orders[reverseIndex]
                                                        .clientname,
                                                    shippingCost: controller1
                                                        .orders[reverseIndex]
                                                        .shippingCost,
                                                    familyName: controller1
                                                        .orders[reverseIndex]
                                                        .familyname,
                                                    shippingTo: controller1
                                                        .orders[reverseIndex]
                                                        .shippingTo,
                                                    orderCost: controller1
                                                        .orders[reverseIndex]
                                                        .orderCost,
                                                    clientNotes: controller1
                                                        .orders[reverseIndex]
                                                        .clientNotes,
                                                    familyNotes: controller1
                                                        .orders[reverseIndex]
                                                        .familyNotes,
                                                    newOrder: false,
                                                    notNewOrder: true,
                                                    orderNo: controller1
                                                        .orders[reverseIndex]
                                                        .orderNo,
                                                    familyId: controller1
                                                        .orders[reverseIndex]
                                                        .familyId,
                                                    current: true,
                                                    end: false,
                                                  )
                                                : Column();
                                          },
                                        )
                                      : noContent(
                                          context,
                                          AppLocalizations.of(context)!
                                              .thereIsnoOrders,
                                        )
                              : Center(
                                  child: StyleText(
                                    AppLocalizations.of(context)!
                                        .youHaveSuspendedYourAccountFromYourProfile,
                                  ),
                                ),
                        );
                      },
                    );
            },
          ),
          GetX<GetNetworkGetx>(
            init: GetNetworkGetx(),
            builder: (GetNetworkGetx network) {
              return network.connectionType.value == 0
                  ? Column(
                      children: [
                        noContent(
                            context, AppLocalizations.of(context)!.noInternet),
                        SizedBox(
                          height: SizeConfig.scaleHeight(30),
                        ),
                        StyleButton(
                          AppLocalizations.of(context)!.refresh,
                          sideColor: kSpecialColor,
                          backgroundColor: kSpecialColor,
                          onPressed: () async {
                            await network.refreshData();
                          },
                        )
                      ],
                    )
                  : GetX<getOrderDriverGetX>(
                      init: getOrderDriverGetX(
                        language:
                            Localizations.localeOf(context).languageCode == "ar"
                                ? "ar"
                                : "en",
                      ),
                      builder: (getOrderDriverGetX controller) {
                        Future<void> getData() async {
                          await controller.refreshValues();
                        }

                        return RefreshIndicator(
                          onRefresh: getData,
                          child: controller.isLoading.value
                              ? Center(child: indicatorNourahLoadingSpecial())
                              : controller.orders.isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      // shrinkWrap: true,
                                      itemCount: controller.orders.length,
                                      itemBuilder: (context, index) {
                                        final int reverseIndex =
                                            controller.orders.length -
                                                1 -
                                                index;

                                        return controller.orders[reverseIndex]
                                                    .paid ==
                                                0
                                            ? Column()
                                            : controller.orders[reverseIndex]
                                                            .status ==
                                                        2 ||
                                                    controller
                                                            .orders[
                                                                reverseIndex]
                                                            .status ==
                                                        3 ||
                                                    controller
                                                            .orders[
                                                                reverseIndex]
                                                            .status ==
                                                        4
                                                ? WidgetOrdersDriver(
                                                    length: controller
                                                        .orders.length,
                                                    createdAt: controller
                                                        .orders[reverseIndex]
                                                        .createdAt,
                                                    notNewOrder: true,
                                                    familylat: controller
                                                        .orders[reverseIndex]
                                                        .familylat,
                                                    familylng: controller
                                                        .orders[reverseIndex]
                                                        .familylng,
                                                    deliveryrate: controller
                                                        .orders[reverseIndex]
                                                        .deliveryrate,
                                                    clientlng: controller
                                                        .orders[reverseIndex]
                                                        .clientlng,
                                                    familyaddress: controller
                                                        .orders[reverseIndex]
                                                        .familyaddress,
                                                    id: controller
                                                        .orders[reverseIndex]
                                                        .id,
                                                    familyphone: controller
                                                        .orders[reverseIndex]
                                                        .familyphone,
                                                    index: reverseIndex,
                                                    clientlat: controller
                                                        .orders[reverseIndex]
                                                        .clientlat,
                                                    deliveryDurationUnit:
                                                        controller
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryDurationUnit,
                                                    deliveryDuration: controller
                                                        .orders[reverseIndex]
                                                        .deliveryDuration,
                                                    deliveryId: controller
                                                        .orders[reverseIndex]
                                                        .deliveryId,
                                                    orderDuration: controller
                                                        .orders[reverseIndex]
                                                        .orderDuration,
                                                    newOrder: false,
                                                    shippingCost: controller
                                                        .orders[reverseIndex]
                                                        .shippingCost,
                                                    orderDurationUnit:
                                                        controller
                                                            .orders[
                                                                reverseIndex]
                                                            .orderDurationUnit,
                                                    clientname: controller
                                                        .orders[reverseIndex]
                                                        .clientname,
                                                    familyName: controller
                                                        .orders[reverseIndex]
                                                        .familyname,
                                                    shippingTo: controller
                                                        .orders[reverseIndex]
                                                        .shippingTo,
                                                    orderCost: controller
                                                        .orders[reverseIndex]
                                                        .orderCost,
                                                    status: controller
                                                        .orders[reverseIndex]
                                                        .status,
                                                    clientNotes: controller
                                                        .orders[reverseIndex]
                                                        .clientNotes,
                                                    familyNotes: controller
                                                        .orders[reverseIndex]
                                                        .familyNotes,
                                                    familyId: controller
                                                        .orders[reverseIndex]
                                                        .familyId,
                                                    deliveryOrderRate:
                                                        controller
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryorderRate,
                                                    orderNo: controller
                                                        .orders[reverseIndex]
                                                        .orderNo,
                                                    end: true,
                                                    ready: controller
                                                        .orders[reverseIndex]
                                                        .ready,
                                                    current: false,
                                                  )
                                                : Column();
                                      },
                                    )
                                  : noContent(
                                      context,
                                      AppLocalizations.of(context)!
                                          .thereIsnoOrders,
                                    ),
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
