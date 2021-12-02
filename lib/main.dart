 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/orders/follow_order_driver.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/orders/widget_orders_driver.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/info_profile_driver.dart';
import 'package:producer_family_app/screens/public_screens/forget_password_screen.dart';
import 'package:producer_family_app/screens/driver_screens/main_driver.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/orders/widget_orders_family.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/profile/add_policies.dart';
import 'package:producer_family_app/screens/public_screens/administration.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/profile/info_profile_family.dart';
import 'package:producer_family_app/screens/public_screens/statistics.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/main_family.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/profile/profile_family.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/add.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/categories.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/store_family.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/products.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/policies_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/reviews_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/login_screens/login_screen.dart';
import 'package:producer_family_app/screens/public_screens/map_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/follow_order_user.dart';
import 'package:producer_family_app/screens/public_screens/profile_screen.dart';
import 'package:producer_family_app/screens/public_screens/reporting.dart';
import 'package:producer_family_app/screens/public_screens/faq_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/info_profile_user.dart';
import 'package:producer_family_app/screens/public_screens/info_screen.dart';
import 'package:producer_family_app/screens/public_screens/login_screen.dart';
import 'package:producer_family_app/screens/driver_screens/registration_delivery_screen.dart';
import 'package:producer_family_app/screens/family_screens/registration_family_screen.dart';
import 'package:producer_family_app/screens/public_screens/terms_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/cart_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/main_screen.dart';
import 'package:producer_family_app/screens/public_screens/notification_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/order_screen.dart';
import 'package:producer_family_app/screens/public_screens/splash.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/home/user_home_screen.dart';
import 'package:producer_family_app/storage/database/db_provider.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesController().initSharedPreferences();
  await Firebase.initializeApp();
  await FbNotifications.initNotifications();
  await DbProvider().initDatabase();
  runApp(FamilyApp());
}

class FamilyApp extends StatefulWidget {
  @override
  _FamilyAppState createState() => _FamilyAppState();
}

class _FamilyAppState extends State<FamilyApp> with FbNotifications {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LanguageChangeNotifer>(
              create: (_) => LanguageChangeNotifer()),
          ChangeNotifierProvider<LatNotiferUser>(
              create: (_) => LatNotiferUser ()),
          ChangeNotifierProvider<LongNotiferUser>(
              create: (_) => LongNotiferUser ()),
          ChangeNotifierProvider<LatNotiferDriver>(
              create: (_) => LatNotiferDriver ()),
          ChangeNotifierProvider<LongNotiferDriver>(
              create: (_) => LongNotiferDriver ()),
          ChangeNotifierProvider<LatNotiferFamily>(
              create: (_) => LatNotiferFamily()),
          ChangeNotifierProvider<LongNotiferFamily>(
              create: (_) => LongNotiferFamily ()),
          ChangeNotifierProvider<stringNotiferFamily>(
              create: (_) => stringNotiferFamily ()),
          ChangeNotifierProvider<stringNotiferUser>(
              create: (_) => stringNotiferUser ()),
          ChangeNotifierProvider<stringNotiferDriver>(
              create: (_) => stringNotiferDriver ()),
          ChangeNotifierProvider<stringNotiferSearch>(
              create: (_) => stringNotiferSearch ()),
        ],
        builder: (BuildContext context, Widget? child) {
          return GetMaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('ar'),
              Locale('en'),
            ],
            locale: Locale(Provider.of<LanguageChangeNotifer>(context).language),
            theme: ThemeData(
              primarySwatch: Colors.brown,
              highlightColor: kSecondaryColor, colorScheme: ColorScheme.light(primary: kSpecialColor.withOpacity(.9)),
              scaffoldBackgroundColor: kBackgroundColor.withOpacity(1),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: '/splash',
            routes: {
              '/splash': (context) => Splash(),
              '/userHomeScreen': (context) => UserHomeScreen(),
              '/mainScreen': (context) => MainScreen(),
              '/cartScreen': (context) => CartScreen(),
              '/notificationScreen': (context) => NotificationScreen(),
              '/profileScreen': (context) => ProfileScreen(),
              '/registrationFamilyScreen': (context) =>
                  RegistrationFamilyScreen(),
              '/registrationDeliveryScreen': (context) =>
                  RegistrationDeliveryScreen(),
              '/faqScreen': (context) => FaqScreen(),
              '/termsScreen': (context) => TermsScreen(),
              '/infoScreen': (context) => InfoScreen(),
              '/logInDeliveryScreen': (context) => LogInScreen(),
              '/forgetPasswordScreen': (context) =>
                  ForgetPasswordScreen(),
              '/orderScreen': (context) => OrderScreen(),
              '/loginScreen': (context) => LoginScreen(),
              '/infoProfileUser': (context) => InfoProfileUser(),
              "/reviewsScreen": (context) => ReviewsScreen(),
              "/policiesScreen": (context) => PoliciesScreen(),
              "/homeFamily": (context) => Statistics(),
              "/mainFamily": (context) => MainFamily(),
              "/mainDriver": (context) => MainDriver(),
              "/profileFamily": (context) => ProfileFamily(),
              "/infoProfileFamily": (context) => InfoProfileFamily(),
              "/infoProfileDriver": (context) => InfoProfileDriver(),
              "/addPolicies": (context) => AddPolicies(),
              "/administration": (context) => Administration(),
              "/storeFamily": (context) => StoreFamily(),
              "/store": (context) => products(),
              "/categories": (context) => Categories(),
              "/add": (context) => Add(),
              "/newOrdersDriver": (context) => WidgetOrdersDriver(),
              "/pastOrdersFamily": (context) => WidgetOrdersFamily(),
              "/ordersFamily": (context) => WidgetOrdersFamily(),
              "/ordersDriver": (context) => WidgetOrdersDriver(),
              "/reporting": (context) => Reporting(),
              "/mapScreen": (context) => MapScreen(),
              "/followOrderUser": (context) => FollowOrderUser(),
              "/followOrderDriver": (context) => FollowOrderDriver(),
            },
          );
        });
  }
}
