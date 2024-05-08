import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/orders/orders_driver_main.dart';
import 'package:producer_family_app/screens/public_screens/administration.dart';
import 'package:producer_family_app/screens/public_screens/notification_screen.dart';
import 'package:producer_family_app/screens/public_screens/profile_screen.dart';
import 'package:producer_family_app/screens/public_screens/statistics.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

class MainDriver extends StatefulWidget {
  final int currentIndex;
  final int orderIndex;

  const MainDriver({
    this.currentIndex = 2,
    this.orderIndex = 0,
  });

  @override
  _MainDriverState createState() => _MainDriverState();
}

class _MainDriverState extends State<MainDriver>
    with SingleTickerProviderStateMixin {
  late TabController? _tabController;

  int _currentIndex = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _currentIndex = widget.currentIndex;
    managenotificationAction(context);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  getProfileGetx controller = Get.put(getProfileGetx());

  @override
  Widget build(BuildContext context) {
    List<Widget> screensBottomNavigationBar = [
      const ProfileScreen(
        driver: true,
      ),
      const Administration(
        header: true,
      ),
      const Statistics(),
      NotificationScreen(),
      OrdersDriverMain(
        orderIndex: widget.orderIndex,
      ),
    ];

    return Scaffold(
        body: screensBottomNavigationBar.elementAt(_currentIndex),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: kSpecialColor.withOpacity(.8),
          buttonBackgroundColor: kBackgroundColor,
          color: Colors.white,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          animationDuration: const Duration(milliseconds: 500),
          index: _currentIndex,
          height: SizeConfig.scaleWidth(65),
          items: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.delivery_dining,
                  color: controller.profile['available'] == 0
                      ? kRefuse
                      : kSpecialColor,
                ),
                StyleText(
                  AppLocalizations.of(context)!.profile,
                  fontSize: fSmallv,
                  textColor: controller.profile['available'] == 0
                      ? kRefuse
                      : kSpecialColor,
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.admin_panel_settings_outlined,
                  color: kSpecialColor,
                ),
                StyleText(
                  AppLocalizations.of(context)!.chat,
                  fontSize: fSmallv,
                  textColor: kSpecialColor,
                )
              ],
            ),
            CircleAvatar(
              radius: SizeConfig.scaleWidth(23),
              backgroundImage: const AssetImage(
                'assets/images/logonourahpinkk.png',
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  color: kSpecialColor,
                ),
                StyleText(
                  AppLocalizations.of(context)!.notifications,
                  fontSize: fSmallv,
                  textColor: kSpecialColor,
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.backup_table,
                  color: kSpecialColor,
                ),
                StyleText(
                  AppLocalizations.of(context)!.orders,
                  fontSize: fSmallv,
                  textColor: kSpecialColor,
                )
              ],
            ),
          ],
        ));
  }
}
