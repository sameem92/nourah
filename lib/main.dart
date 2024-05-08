import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/info_profile_driver.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/orders/widget_orders_driver.dart';
import 'package:producer_family_app/screens/driver_screens/main_driver.dart';
import 'package:producer_family_app/screens/driver_screens/registration_delivery_screen.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/main_family.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/orders/widget_orders_family.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/profile/add_policies.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/profile/info_profile_family.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/profile/profile_family.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/add.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/categories.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/products.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/store_family.dart';
import 'package:producer_family_app/screens/family_screens/registration_family_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/cart_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/home/user_home_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/info_profile_user.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/login_screens/login_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/main_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/orders/order_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/policies_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/reviews_screen.dart';
import 'package:producer_family_app/screens/public_screens/administration.dart';
import 'package:producer_family_app/screens/public_screens/chat.dart';
import 'package:producer_family_app/screens/public_screens/faq_screen.dart';
import 'package:producer_family_app/screens/public_screens/forget_password_screen.dart';
import 'package:producer_family_app/screens/public_screens/info_screen.dart';
import 'package:producer_family_app/screens/public_screens/login_screen.dart';
import 'package:producer_family_app/screens/public_screens/map_screen.dart';
import 'package:producer_family_app/screens/public_screens/notification_screen.dart';
import 'package:producer_family_app/screens/public_screens/profile_screen.dart';
import 'package:producer_family_app/screens/public_screens/reporting.dart';
import 'package:producer_family_app/screens/public_screens/splash.dart';
import 'package:producer_family_app/screens/public_screens/statistics.dart';
import 'package:producer_family_app/screens/public_screens/terms_screen.dart';
import 'package:producer_family_app/storage/database/db_provider.dart';
import 'package:producer_family_app/storage/notificatons.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

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
    managenotificationAction(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageChangeNotifer>(
          create: (_) => LanguageChangeNotifer(),
        ),
        ChangeNotifierProvider<LatNotiferUser>(
          create: (_) => LatNotiferUser(),
        ),
        ChangeNotifierProvider<LongNotiferUser>(
          create: (_) => LongNotiferUser(),
        ),
        ChangeNotifierProvider<LatNotiferDriver>(
          create: (_) => LatNotiferDriver(),
        ),
        ChangeNotifierProvider<LongNotiferDriver>(
          create: (_) => LongNotiferDriver(),
        ),
        ChangeNotifierProvider<LatNotiferFamily>(
          create: (_) => LatNotiferFamily(),
        ),
        ChangeNotifierProvider<LongNotiferFamily>(
          create: (_) => LongNotiferFamily(),
        ),
        ChangeNotifierProvider<stringNotiferFamily>(
          create: (_) => stringNotiferFamily(),
        ),
        ChangeNotifierProvider<stringNotiferUser>(
          create: (_) => stringNotiferUser(),
        ),
        ChangeNotifierProvider<stringNotiferDriver>(
          create: (_) => stringNotiferDriver(),
        ),
        ChangeNotifierProvider<stringNotiferSearch>(
          create: (_) => stringNotiferSearch(),
        ),
        ChangeNotifierProvider<intCategoryId>(create: (_) => intCategoryId()),
        ChangeNotifierProvider<intIndexTabHome>(
          create: (_) => intIndexTabHome(),
        ),
        ChangeNotifierProvider<intIndexorder>(create: (_) => intIndexorder()),
        ChangeNotifierProvider<intOrderToConfirmFamily>(
          create: (_) => intOrderToConfirmFamily(),
        ),
        ChangeNotifierProvider<stringNoteCustomer>(
          create: (_) => stringNoteCustomer(),
        ),
        ChangeNotifierProvider<intIndexProfile>(
          create: (_) => intIndexProfile(),
        ),
      ],
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
          locale: Locale(Provider.of<LanguageChangeNotifer>(context).language),
          // locale: Locale('en'),
          theme: ThemeData(
            primarySwatch: Colors.grey,
            secondaryHeaderColor: Colors.grey,
            // indicatorColor: Color(0xffb25068).withOpacity(.9),
            // canvasColor: Color(0xffb25068).withOpacity(.9),
            primaryColor: Color(0xffb25068).withOpacity(.9),

            highlightColor: kSpecialColor.withOpacity(.4),
            scaffoldBackgroundColor: kBackgroundColor.withOpacity(1),
          ),
          // showPerformanceOverlay: true,

          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => Splash(),
            '/userHomeScreen': (context) => UserHomeScreen(),
            '/mainScreen': (context) => const MainScreen(
                  currentIndex: 2,
                  // 40.18889
                  // 29.05642
                ),
            '/cartScreen': (context) => CartScreen(),
            '/notificationScreen': (context) => NotificationScreen(),
            '/profileScreen': (context) => const ProfileScreen(),
            '/registrationFamilyScreen': (context) =>
                RegistrationFamilyScreen(),
            '/registrationDeliveryScreen': (context) =>
                RegistrationDeliveryScreen(),
            '/faqScreen': (context) => const FaqScreen(),
            '/termsScreen': (context) => TermsScreen(),
            '/infoScreen': (context) => InfoScreen(),
            '/logInDeliveryScreen': (context) => LogInScreen(),
            '/forgetPasswordScreen': (context) => const ForgetPasswordScreen(),
            '/orderScreen': (context) => const OrderScreen(),
            '/loginScreen': (context) => const LoginScreen(),
            '/infoProfileUser': (context) => InfoProfileUser(),
            "/reviewsScreen": (context) => const ReviewsScreen(),
            "/policiesScreen": (context) => const PoliciesScreen(),
            "/homeFamily": (context) => const Statistics(),
            "/mainFamily": (context) => const MainFamily(),
            "/mainDriver": (context) => const MainDriver(),
            "/profileFamily": (context) => const ProfileFamily(),
            "/infoProfileFamily": (context) => InfoProfileFamily(),
            "/infoProfileDriver": (context) => InfoProfileDriver(),
            "/addPolicies": (context) => AddPolicies(),
            "/administration": (context) => const Administration(),
            "/storeFamily": (context) => StoreFamily(),
            "/store": (context) => ProductsFamily(),
            "/categories": (context) => Categories(),
            "/add": (context) => Add(),
            "/newOrdersDriver": (context) => const WidgetOrdersDriver(),
            "/pastOrdersFamily": (context) => const WidgetOrdersFamily(),
            "/ordersFamily": (context) => const WidgetOrdersFamily(),
            "/ordersDriver": (context) => const WidgetOrdersDriver(),
            "/reporting": (context) => const Reporting(),
            "/mapScreen": (context) => const MapScreen(),
            "/chat": (context) => const Chat(),
          },
        );
      },
    );
  }
}
