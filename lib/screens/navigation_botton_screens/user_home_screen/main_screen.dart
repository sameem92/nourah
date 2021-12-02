import 'package:flutter/material.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/home/user_home_screen.dart';
import 'package:producer_family_app/screens/public_screens/notification_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/order_screen.dart';
import 'package:producer_family_app/screens/public_screens/profile_screen.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'login_screens/login_screen.dart';
import '../../public_screens/map_screen.dart';

class MainScreen extends StatefulWidget {
  int currentIndex;
  int orderIndex;

  MainScreen({
    this.currentIndex = 2,
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> screensBottomNavigationBar = [
      ProfileScreen(
        user: true,
      ),
      SharedPreferencesController().isLoggedInUser == true
          ? OrderScreen(orderIndex:widget.orderIndex ,)
          : LoginScreen(
        main: true,
      ),
      UserHomeScreen(),
      NotificationScreen(),
      MapScreen(
        user: true,
      ),
    ];

    return Scaffold(
        body:screensBottomNavigationBar.elementAt(_currentIndex),
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
                  isLoggedIn == true ? Icons.person_outline_outlined : Icons.login,
                  color: kSecondaryColor.withOpacity(.8),
                ),
                StyleText(AppLocalizations.of(context)!.profile,fontSize: fSmallv,
                  textColor: kSecondaryColor.withOpacity(.8),)
              ],
            ),
            Column(              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: kSecondaryColor.withOpacity(.8),
                ),
                StyleText(AppLocalizations.of(context)!.orders,fontSize: fSmallv,
                  textColor: kSecondaryColor.withOpacity(.8),)
              ],
            ),
            CircleAvatar(
              radius: SizeConfig.scaleWidth(23),
              backgroundImage: AssetImage('assets/images/family_logo.png'),
            ),
            Column(              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  color: kSecondaryColor.withOpacity(.8),
                ),
                StyleText(AppLocalizations.of(context)!.notifications,fontSize: fSmallv,
                  textColor: kSecondaryColor.withOpacity(.8),)

              ],
            ),
            Column(              mainAxisSize: MainAxisSize.min,

              children: [
                Icon(
                  Icons.edit_location_outlined,
                  color: kSecondaryColor.withOpacity(.8),
                ),
                StyleText(AppLocalizations.of(context)!.changeLocation,fontSize: fSmallv,
                  textColor: kSecondaryColor.withOpacity(.8),
    )

              ],
            ),
          ],
        )

        );
  }
}
