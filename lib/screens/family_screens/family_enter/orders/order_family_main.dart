import 'package:flutter/material.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widget_orders_family.dart';

class OrderScreenFamilyMain extends StatefulWidget {
  int orderIndex;

  OrderScreenFamilyMain({this.orderIndex=0});
  @override
  _OrderScreenFamilyMainState createState() => _OrderScreenFamilyMainState();
}

class _OrderScreenFamilyMainState extends State<OrderScreenFamilyMain>
    with SingleTickerProviderStateMixin {
  List<Widget> _ScreensTab = [
    WidgetOrdersFamily(),
    WidgetOrdersFamily(),

    WidgetOrdersFamily(),
  ];
  int _selectedIndex = 2;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _ScreensTab.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return taps_app(context);
  }
  Scaffold taps_app(BuildContext context) {
    return Scaffold(
      appBar: appBar_taps(
        context,
        selectedIndexx: _selectedIndex ,
        tabController: _tabController,
        tap1: AppLocalizations.of(context)!.waiting,
        tap2: AppLocalizations.of(context)!.currentt,
        tap3: AppLocalizations.of(context)!.end,
        tap3Exist: true,

      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WidgetOrdersFamily(
            waiting: true,
            status: 0,
          ),
          WidgetOrdersFamily(
            current: true,
            status: 4,
          ),
          WidgetOrdersFamily(
            end: true,
            status: 4 &2&3 ,
          ),
        ],
      ),
    );
  }
}
