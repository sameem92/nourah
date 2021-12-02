import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/orders/orders_driver_main.dart';
import 'package:producer_family_app/screens/public_screens/administration.dart';
import 'package:producer_family_app/screens/public_screens/notification_screen.dart';
import 'package:producer_family_app/screens/public_screens/profile_screen.dart';
import 'package:producer_family_app/screens/public_screens/statistics.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/style/style_text.dart';

class MainDriver extends StatefulWidget {
  int currentIndex;
  int orderIndex;

  MainDriver({
    this.currentIndex = 2,
    this.orderIndex = 0,
  });

  @override
  _MainDriverState createState() => _MainDriverState();
}

class _MainDriverState extends State<MainDriver>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;


  int _currentIndex = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _currentIndex = widget.currentIndex;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screensBottomNavigationBar = [

      ProfileScreen(
        driver: true,
      ),
      Administration(
        header: true,
      ),
      Statistics(),
      NotificationScreen(),
      OrdersDriverMain(orderIndex:widget.orderIndex ,),
    ];

    return Scaffold(
        body: _screensBottomNavigationBar.elementAt(_currentIndex),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: kSpecialColor.withOpacity(.8),
          buttonBackgroundColor: kBackgroundColor,
          color: Colors.white,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          animationDuration: Duration(milliseconds: 500),
          index: _currentIndex,
          height: SizeConfig.scaleWidth(65),
          items: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.delivery_dining,
                  color: kSecondaryColor.withOpacity(.8),
                ),
                StyleText(
                  AppLocalizations.of(context)!.profile,
                  fontSize: fSmallv,
                  textColor: kSecondaryColor.withOpacity(.8),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.admin_panel_settings_outlined,
                  color: kSecondaryColor.withOpacity(.8),
                ),
                StyleText(
                  AppLocalizations.of(context)!.chat,
                  fontSize: fSmallv,
                  textColor: kSecondaryColor.withOpacity(.8),
                )
              ],
            ),
            CircleAvatar(
              radius: SizeConfig.scaleWidth(23),
              // radius: SizeConfig.scaleHeight(100),
              backgroundImage: AssetImage('assets/images/family_logo.png'),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  color: kSecondaryColor.withOpacity(.8),
                ),
                StyleText(
                  AppLocalizations.of(context)!.notifications,
                  fontSize: fSmallv,
                  textColor: kSecondaryColor.withOpacity(.8),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.backup_table,
                  color: kSecondaryColor.withOpacity(.8),
                ),
                StyleText(
                  AppLocalizations.of(context)!.orders,
                  fontSize: fSmallv,
                  textColor: kSecondaryColor.withOpacity(.8),
                )
              ],
            ),
          ],
        )

        );
  }
}
