// import 'package:flutter/material.dart';
// import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/home/user_home_screen.dart';
// import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/profile_screens/profile_screen.dart';
// import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/cart_screens/cart_screen.dart';
// import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/order_screen.dart';
// import 'package:producer_family_app/style/size_config.dart';
// import 'package:producer_family_app/style/style_colors.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import 'navigation_botton_screens/user_home_screen/notifications_screens/notification_screen.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen>
//     with SingleTickerProviderStateMixin {
//   TabController _tabController;
//
//   int _currentIndex = 2;
//   List<Widget> _screensBottomNavigationBar = [
//     ProfileScreen(),
//     OrderScreen(),
//     UserHomeScreen(),
//     NotificationScreen(),
//     CartScreen(),
//   ];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _tabController = TabController(length: 5, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _tabController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//
//     return Scaffold(
//       body: TabBarView(
//         controller: _tabController,
//         children: <Widget>[
//           ProfileScreen(),
//           OrderScreen(),
//           UserHomeScreen(),
//           NotificationScreen(),
//           CartScreen(),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         color: Colors.white,
//         child: TabBar(
//           // physics: NeverScrollableScrollPhysics(),
//           controller: _tabController,
//           unselectedLabelColor: kSecondaryColor,
//           labelPadding: EdgeInsets.only(bottom: 20),
//           indicator: UnderlineTabIndicator(
//             borderSide: BorderSide(
//                 width: SizeConfig.scaleHeight(3), color: kSpecialColor),
//           ),
//           indicatorPadding: EdgeInsets.only(bottom: 20),
//           indicatorColor: kSpecialColor,
//           labelColor: kSpecialColor,
//           labelStyle: TextStyle(
//               fontSize: SizeConfig.scaleTextFont(17), fontFamily: "Almarai"),
//           tabs: [
//             Tab(
//               icon: Icon(
//                 Icons.person_outline_outlined,
//                 size: SizeConfig.scaleTextFont(30),
//               ),
//               text: AppLocalizations.of(context).profile,
//             ),
//             Tab(
//               icon: Icon(
//                 Icons.shopping_cart,
//                 size: SizeConfig.scaleTextFont(30),
//               ),
//               text: AppLocalizations.of(context).orders,
//             ),
//             Tab(
//               icon: Icon(
//                 Icons.home_outlined,
//                 size: SizeConfig.scaleTextFont(30),
//               ),
//               text: AppLocalizations.of(context).home,
//             ),
//             Tab(
//               icon: Icon(
//                 Icons.notifications_none_outlined,
//                 size: SizeConfig.scaleTextFont(30),
//               ),
//               text: AppLocalizations.of(context).notifications,
//             ),
//             Tab(
//               icon: Icon(
//                 Icons.shopping_cart_outlined,
//                 size: SizeConfig.scaleTextFont(30),
//               ),
//               text: AppLocalizations.of(context).cart,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }