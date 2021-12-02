import 'package:flutter/material.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/widget_order_user.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderScreen extends StatefulWidget {
  int orderIndex;

  OrderScreen({this.orderIndex=0});
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> _ScreensTab = [
    WidgetOrderUser(),
    WidgetOrderUser(),

    WidgetOrderUser(),
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
          WidgetOrderUser(
            waiting: true,
            status: 0,
          ),
          WidgetOrderUser(
            current: true,
            status: 0,
          ),
          WidgetOrderUser(
            end: true,
            status: 4,
          ),
        ],
      ),
    );
  }
}
