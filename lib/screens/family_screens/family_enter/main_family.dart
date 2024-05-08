import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/profile/profile_family.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/store_family.dart';
import 'package:producer_family_app/screens/public_screens/notification_screen.dart';
import 'package:producer_family_app/screens/public_screens/statistics.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/login_profile_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

import 'orders/order_family_main.dart';

class MainFamily extends StatefulWidget {
  final int currentIndex;
  final int orderIndex;
  final int profileIndex;

  const MainFamily({
    this.currentIndex = 2,
    this.orderIndex = 0,
    this.profileIndex = 0,
  });
  @override
  _MainFamilyState createState() => _MainFamilyState();
}

class _MainFamilyState extends State<MainFamily>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    managenotificationAction(context);

    _tabController = TabController(length: 4, vsync: this);
    _currentIndex = widget.currentIndex;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  getProfileGetx controller = Get.put(getProfileGetx());

  @override
  Widget build(BuildContext context) {
    List<Widget> screensBottomNavigationBar = [
      ProfileFamily(
        profileIndex: widget.profileIndex,
      ),
      StoreFamily(),
      const Statistics(
        family: true,
      ),
      NotificationScreen(),
      OrderScreenFamilyMain(
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
                  Icons.family_restroom,
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
                  Icons.store,
                  color: kSpecialColor,
                ),
                StyleText(AppLocalizations.of(context)!.store,
                    fontSize: fSmallv, textColor: kSpecialColor)
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
