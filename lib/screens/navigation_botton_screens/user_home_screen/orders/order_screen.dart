import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/widget_order_user.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';

class OrderScreen extends StatefulWidget {
  final int orderIndex;

  const OrderScreen({this.orderIndex = 0});
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> screensTab = [
    // WidgetOrderUser(refresh:getOrderGetX().refreshData() ,),
    const WidgetOrderUser(),
    const WidgetOrderUser(),
  ];
  int _selectedreverseIndex = 2;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: screensTab.length, vsync: this);
    _tabController.animateTo(widget.orderIndex);

    _tabController.addListener(() {
      setState(() {
        _selectedreverseIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    Get.delete<getOrderGetX>();
    super.dispose();
  }

  getOrderGetX cont = Get.put(getOrderGetX());

  @override
  Widget build(BuildContext context) {
    return tapsApp(context);
  }

  Scaffold tapsApp(BuildContext context) {
    return Scaffold(
      appBar: appBarTaps(context,
          selectedIndexx: _selectedreverseIndex,
          tabController: _tabController,
          tap1: AppLocalizations.of(context)!.currentt,
          tap2: AppLocalizations.of(context)!.end,
          tap3: '',
          tap3Exist: false),
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
                    : GetX<getOrderGetX>(
                        init: getOrderGetX(),
                        builder: (getOrderGetX controller) {
                          Future<void> getData() async {
                            await controller.refreshData();
                          }

                          return RefreshIndicator(
                              onRefresh: getData,
                              child: controller.isLoading.value
                                  ? Center(
                                      child: indicatorNourahLoadingSpecial())
                                  : controller.orders.isNotEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount: controller.orders.length,
                                          itemBuilder: (context, index) {
                                            int reverseIndex =
                                                controller.orders.length -
                                                    1 -
                                                    index;

                                            return controller
                                                            .orders[
                                                                reverseIndex]
                                                            .status ==
                                                        1 &&
                                                    controller
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryReply ==
                                                        1
                                                ? WidgetOrderUser(
                                                    controller: controller,
                                                    length: controller
                                                        .orders.length,
                                                    familyReply: controller
                                                        .orders[reverseIndex]
                                                        .familyReply,
                                                    orderNo: controller
                                                        .orders[reverseIndex]
                                                        .orderNo,
                                                    createdAt: controller
                                                        .orders[reverseIndex]
                                                        .createdAt,
                                                    familyrate: controller
                                                        .orders[reverseIndex]
                                                        .familyrate,
                                                    familycomment: controller
                                                        .orders[reverseIndex]
                                                        .familycomment,
                                                    id: controller
                                                        .orders[reverseIndex]
                                                        .id,
                                                    deliveryphone: controller
                                                        .orders[reverseIndex]
                                                        .deliveryphone,
                                                    familyId: controller
                                                        .orders[reverseIndex]
                                                        .familyId,
                                                    // refresh:controller.refreshData() ,
                                                    deliveryId: controller
                                                        .orders[reverseIndex]
                                                        .deliveryId,
                                                    orderDuration: controller
                                                        .orders[reverseIndex]
                                                        .orderDuration,
                                                    userId: controller
                                                        .orders[reverseIndex]
                                                        .userId,
                                                    familyNotes: controller
                                                        .orders[reverseIndex]
                                                        .familyNotes,
                                                    clientNotes: controller
                                                        .orders[reverseIndex]
                                                        .clientNotes,
                                                    orderCost: controller
                                                        .orders[reverseIndex]
                                                        .orderCost,
                                                    orderDurationUnit:
                                                        controller
                                                            .orders[
                                                                reverseIndex]
                                                            .orderDurationUnit,
                                                    current: true,
                                                    familyimage: controller
                                                        .orders[reverseIndex]
                                                        .familyimage,
                                                    familyname: controller
                                                        .orders[reverseIndex]
                                                        .familyname,
                                                    deliveryReply: controller
                                                        .orders[reverseIndex]
                                                        .deliveryReply,
                                                    deliveryname: controller
                                                        .orders[reverseIndex]
                                                        .deliveryname,
                                                    deliveryimage: controller
                                                        .orders[reverseIndex]
                                                        .deliveryimage,
                                                    index: reverseIndex,
                                                    familyOrderRate: controller
                                                        .orders[reverseIndex]
                                                        .familyorderRate,
                                                    end: false,
                                                    deliveryrate: controller
                                                        .orders[reverseIndex]
                                                        .deliveryrate,
                                                    deliveryDuration: controller
                                                        .orders[reverseIndex]
                                                        .deliveryDuration,
                                                    deliveryDurationUnit:
                                                        controller
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryDurationUnit,
                                                    shippingCost: controller
                                                        .orders[reverseIndex]
                                                        .shippingCost,
                                                    ready: controller
                                                        .orders[reverseIndex]
                                                        .ready,
                                                    status: controller
                                                        .orders[reverseIndex]
                                                        .status,
                                                  )
                                                : Column();
                                          })
                                      : noContent(
                                          context,
                                          AppLocalizations.of(context)!
                                              .thereIsnoOrders));
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
                    : GetX<getOrderGetX>(
                        init: getOrderGetX(),
                        builder: (getOrderGetX controller) {
                          Future<void> getData() async {
                            await controller.refreshData();
                          }

                          return RefreshIndicator(
                              onRefresh: getData,
                              child: controller.isLoading.value
                                  ? Center(
                                      child: indicatorNourahLoadingSpecial())
                                  : controller.orders.isNotEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          // shrinkWrap: true,
                                          itemCount: controller.orders.length,
                                          itemBuilder: (context, index) {
                                            int reverseIndex =
                                                controller.orders.length -
                                                    1 -
                                                    index;

                                            return controller
                                                        .orders[reverseIndex]
                                                        .paid ==
                                                    0
                                                ? Column()
                                                : controller
                                                                .orders[
                                                                    reverseIndex]
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
                                                    ? WidgetOrderUser(
                                                        end: true,
                                                        length: controller
                                                            .orders.length,
                                                        status: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .status,
                                                        ready: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .ready,
                                                        controller: controller,
                                                        familyReply: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .familyReply,
                                                        orderNo: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .orderNo,
                                                        createdAt: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .createdAt,
                                                        familyrate: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .familyrate,
                                                        familycomment: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .familycomment,
                                                        id: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .id,
                                                        deliveryphone: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryphone,
                                                        familyId: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .familyId,
                                                        deliveryId: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryId,
                                                        orderDuration: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .orderDuration,
                                                        userId: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .userId,
                                                        familyNotes: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .familyNotes,
                                                        clientNotes: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .clientNotes,
                                                        orderCost: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .orderCost,
                                                        orderDurationUnit:
                                                            controller
                                                                .orders[
                                                                    reverseIndex]
                                                                .orderDurationUnit,
                                                        current: false,
                                                        familyimage: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .familyimage,
                                                        familyname: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .familyname,
                                                        deliveryReply: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryReply,
                                                        deliveryname: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryname,
                                                        deliveryimage: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryimage,
                                                        index: reverseIndex,
                                                        deliveryrate: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .deliveryrate,
                                                        familyOrderRate:
                                                            controller
                                                                .orders[
                                                                    reverseIndex]
                                                                .familyorderRate,
                                                        familyOrderRateBool: controller
                                                                            .orders[
                                                                                reverseIndex]
                                                                            .status ==
                                                                        3 &&
                                                                    controller
                                                                            .orders[
                                                                                reverseIndex]
                                                                            .familyorderRate ==
                                                                        null ||
                                                                controller
                                                                            .orders[
                                                                                reverseIndex]
                                                                            .status ==
                                                                        3 &&
                                                                    controller
                                                                            .orders[reverseIndex]
                                                                            .familyorderRate ==
                                                                        0
                                                            ? true
                                                            : false,
                                                        deliveryDuration:
                                                            controller
                                                                .orders[
                                                                    reverseIndex]
                                                                .deliveryDuration,
                                                        deliveryDurationUnit:
                                                            controller
                                                                .orders[
                                                                    reverseIndex]
                                                                .deliveryDurationUnit,
                                                        shippingCost: controller
                                                            .orders[
                                                                reverseIndex]
                                                            .shippingCost,
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
