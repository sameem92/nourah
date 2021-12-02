
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:producer_family_app/screens/driver_screens/driver_enter/orders/orders_driver_main.dart';
import 'package:producer_family_app/screens/driver_screens/main_driver.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/orders/order_family_main.dart';
import 'package:producer_family_app/screens/public_screens/forget_password_screen.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';

Future<void> firebaseMessegingBackGroundHandler(
    RemoteMessage remoteMessage) async {
  await Firebase.initializeApp();
  print("Massage: ${remoteMessage.messageId}");
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin localNotificationsPlugin;

mixin FbNotifications {
  static Future<void> initNotifications() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessegingBackGroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'high_importance_channel',
        'This channel will recieve notifications',
        importance: Importance.max,
        enableLights: true,
        enableVibration: true,
        ledColor: Color(0xFF87695C),
        showBadge: true,
        playSound: true,
      );

    }
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> requestNotificationPermissions() async {
    print('requestNotificationPermissions');
    NotificationSettings notificationSettings = await FirebaseMessaging.instance
        .requestPermission(
            alert: true,
            badge: true,
            sound: true,
            carPlay: false,
            announcement: false,
            provisional: false,
            criticalAlert: false);
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      print('grant permision');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.denied) print('grant denied');
  }
}

initializeForegroundNotificationForAndroid() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('message recieved : ${message.messageId}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? androidNotification = notification?.android;
    if (notification != null && androidNotification != null) {
      localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            icon: "launch_background",
          ),
        ),
      );
    }
  });
}

void managenotificationAction() {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    _controllNotificationNavigation(message.data );
  });
}

void _controllNotificationNavigation(Map<String, dynamic> data,
    ) {
  if (data['page'] != null) {
    switch (data['page']) {
      case 'order_user_cancel':
        // var id = data["order_user_cancel"];
        if (SharedPreferencesController().isLoggedInFamily == true) {
          navigator!.push(MaterialPageRoute(builder: (context) => OrderScreenFamilyMain()));
        } else if (SharedPreferencesController().isLoggedInDriver == true) {
          navigator!.push( MaterialPageRoute(builder: (context) => MainDriver(currentIndex: 4,orderIndex: 1,)));
        }else{
          null;
        }
        break;
      case 'settings':
        print("navigate to settings");
        break;
      case 'profile':
        print("navigate to profile");
        break;
    }
  }
}
