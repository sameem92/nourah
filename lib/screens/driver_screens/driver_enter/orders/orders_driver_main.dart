import 'package:flutter/material.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widget_orders_driver.dart';

class OrdersDriverMain extends StatefulWidget {
int orderIndex;

OrdersDriverMain({this.orderIndex=0});
  @override
  _OrdersDriverMainState createState() => _OrdersDriverMainState();
}

class _OrdersDriverMainState extends State<OrdersDriverMain>
    with SingleTickerProviderStateMixin {
  List<Widget> _ScreensTab = [
    WidgetOrdersDriver(),
    WidgetOrdersDriver(),
    WidgetOrdersDriver(),
    WidgetOrdersDriver(),
  ];
  int _selectedIndex = 2;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _ScreensTab.length, vsync: this);
    _tabController.animateTo(widget.orderIndex);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });});
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: appBar_taps(
        context,
        tabController: _tabController,
        selectedIndexx: _selectedIndex,
        tap1: AppLocalizations.of(context)!.neworder,
        tap2: AppLocalizations.of(context)!.beforeNewOrdersDriver,
        tap3: AppLocalizations.of(context)!.currentt,
        tap4: AppLocalizations.of(context)!.end,
        tap3Exist: true,
        tap4Exist: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WidgetOrdersDriver(
            waiting: true,
            status: 4,
          ),
          WidgetOrdersDriver(
            afterWaiting: true,
            status: 4,
          ),
          WidgetOrdersDriver(
            current: true,
            status: 4,
          ),
          WidgetOrdersDriver(
            end: true,
            status: 4,
          ),
        ],
      ),
    );
  }
}
