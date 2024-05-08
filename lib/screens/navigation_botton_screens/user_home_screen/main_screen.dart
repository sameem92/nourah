import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/home/user_home_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/order_screen.dart';
import 'package:producer_family_app/screens/public_screens/notification_screen.dart';
import 'package:producer_family_app/screens/public_screens/profile_screen.dart';
import 'package:producer_family_app/storage/providersAndGetx/cart_getx_controller.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

import '../../../storage/providersAndGetx/home_getx.dart';
import '../../public_screens/map_screen.dart';
import 'login_screens/login_screen.dart';

class MainScreen extends StatefulWidget {
  final int currentIndex;
  final int orderIndex;

  const MainScreen({
    required this.currentIndex,
    this.orderIndex = 0,
  });

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 2;
  bool isLoggedIn = SharedPreferencesController().isLoggedInUser;
  CartGetxController controllerr = Get.put(CartGetxController());
  Timer? _timer;

  @override
  void initState() {
    _timer = new Timer.periodic(Duration(minutes: 5),
        (Timer t) => HomeGetx.to.refreshOffer(isUpdated: true));

    super.initState();

    _tabController = TabController(length: 4, vsync: this);

    _tabController.animateTo(widget.currentIndex);

    CartGetxController.to.cleanCart();

    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screensBottomNavigationBar = [
      ProfileScreen(
        user: true,
      ),
      SharedPreferencesController().isLoggedInUser == true
          ? OrderScreen(
              orderIndex: widget.orderIndex,
            )
          : const LoginScreen(
              main: true,
            ),
      UserHomeScreen(),
      SharedPreferencesController().isLoggedInUser == true
          ? NotificationScreen()
          : const LoginScreen(
              main: true,
            ),
      MapScreen(
          user: SharedPreferencesController().isLoggedInUser == true
              ? true
              : false),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: screensBottomNavigationBar.elementAt(_currentIndex),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: kSpecialColor,
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
                    isLoggedIn == true
                        ? Icons.person_outline_outlined
                        : Icons.login,
                    color: kTextColor.withOpacity(.8),
                  ),
                  StyleText(
                    AppLocalizations.of(context)!.profile,
                    fontSize: fSmallv,
                    textColor: kTextColor.withOpacity(.8),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: kTextColor.withOpacity(.8),
                  ),
                  StyleText(
                    AppLocalizations.of(context)!.orders,
                    fontSize: fSmallv,
                    textColor: kTextColor.withOpacity(.8),
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
                    color: kTextColor.withOpacity(.8),
                  ),
                  StyleText(
                    AppLocalizations.of(context)!.notifications,
                    fontSize: fSmallv,
                    textColor: kTextColor.withOpacity(.8),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit_location_outlined,
                    color: kTextColor.withOpacity(.8),
                  ),
                  StyleText(
                    AppLocalizations.of(context)!.changeLocation,
                    fontSize: fSmallv,
                    textColor: kTextColor.withOpacity(.8),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
