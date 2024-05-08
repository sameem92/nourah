import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/screens/driver_screens/main_driver.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/main_family.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/cart_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/main_screen.dart';
import 'package:producer_family_app/screens/public_screens/chat.dart';
import 'package:producer_family_app/screens/public_screens/chat_damily_driver.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/storage/providersAndGetx/order_getx.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:provider/provider.dart';

Future<void> firebaseMessegingBackGroundHandler(
    RemoteMessage remoteMessage) async {
  await Firebase.initializeApp();
  // print("Massage: ${remoteMessage.messageId}");
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin localNotificationsPlugin;

mixin FbNotifications {
  static Future<void> initNotifications() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessegingBackGroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.', // d
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
    // print('requestNotificationPermissions');
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
      // print('grant permision');
    } else if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.denied) {
      // print('grant denied');
    }
  }
}

initializeForegroundNotificationForAndroid() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('message recieved : ${message.messageId}');
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
            channelDescription: channel.description,
            importance: Importance.max,
            enableLights: true,
            enableVibration: true,
            ledColor: const Color(0xFF87695C),
            priority: Priority.max,
            playSound: true,
            icon: "assets/images/img.png",
          ),
        ),
      );
    }
  });
}

void managenotificationAction(BuildContext context) {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    _controllNotificationNavigation(message.data, context);
  });
}

_controllNotificationNavigation(
  Map<String, dynamic> data,
  BuildContext context,
) {
  // print("data $data");

  if (data['page'] != null) {
    switch (data['page']) {

      //make order from user        family new
      case 'family_order_id':
        if (SharedPreferencesController().isLoggedInFamily == true) {
          // print("family_order_id   family");
          Get.put(getOrderFamilyGetX());
          Provider.of<intIndexorder>(context, listen: false)
              .changeIntIndexorder(0);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainFamily(
                        currentIndex: 4,
                        orderIndex: 0,
                      )));
        }
        break;

      //  confirm from family       user on cart
      case 'family_confirm_order_id':
        if (SharedPreferencesController().isLoggedInUser == true) {
          // print("family_confirm_order_id   user");
          getCartOrderIdGetx controller = Get.put(getCartOrderIdGetx(
            order_id:
                Provider.of<intOrderToConfirmFamily>(context, listen: false)
                    .intIndex,
          ));
          controller.refreshValues(
            order_id_2:
                Provider.of<intOrderToConfirmFamily>(context, listen: false)
                    .intIndex,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CartScreen(
                      currentStep: 1,
                      orderIdPage: Provider.of<intOrderToConfirmFamily>(context,
                              listen: false)
                          .intIndex,
                      controllerCartt: controller,
                      disapearButtom: true,
                    )),
          );
          // print("on cart");
        }
        break;

      //  findDelivery from user     driver new
      case 'findDelivery_order_id':
        if (SharedPreferencesController().isLoggedInDriver == true) {
          // print("findDelivery_order_id   driver");
          Provider.of<intIndexorder>(context, listen: false)
              .changeIntIndexorder(0);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainDriver(
                        currentIndex: 4,
                        orderIndex: 0,
                      )));
        }
        break;

      //  request from delivery     user  on cart
      case 'delivery_request_order_id':
        if (SharedPreferencesController().isLoggedInUser == true) {
          // print("delivery_request_order_id   user");

          GetOrderDeliveryRequestsGetX controller =
              Get.put(GetOrderDeliveryRequestsGetX(
            order_id:
                Provider.of<intOrderToConfirmFamily>(context, listen: false)
                    .intIndex,
          ));
          controller.refreshData();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CartScreen(
                      currentStep: 2,
                      orderIdPage: Provider.of<intOrderToConfirmFamily>(context,
                              listen: false)
                          .intIndex,
                      controllerDelivery: controller,
                      disapearButtom: true,
                      deliveryBool: true,
                    )),
          );
          // print("on cart");
        }
        break;

      // ** confirm from user     driver   new
      case 'user_confirm_order_id':
        if (SharedPreferencesController().isLoggedInDriver == true) {
          // print("user_confirm_order_id   driver");
          Provider.of<intIndexorder>(context, listen: false)
              .changeIntIndexorder(0);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MainDriver(
                        currentIndex: 4,
                        orderIndex: 0,
                      )));
        }
        break;

      // ** confirm from user to request     driver  family  current
      case 'user_payment_order_id':
        if (SharedPreferencesController().isLoggedInDriver == true) {
          // print("delivery_request_confirm_order_id   driver");
          Provider.of<intIndexorder>(context, listen: false)
              .changeIntIndexorder(1);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainDriver(
                        currentIndex: 4,
                        orderIndex: 1,
                      )));
        }
        if (SharedPreferencesController().isLoggedInFamily == true) {
          // print("delivery_request_confirm_order_id   family");
          Provider.of<intIndexorder>(context, listen: false)
              .changeIntIndexorder(1);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainFamily(
                        currentIndex: 4,
                        orderIndex: 1,
                      )));
        }

        break;

      //  ready from family to driver     driver  current
      case 'family_ready_order_id':
        // print("family_ready_order_id");
        if (SharedPreferencesController().isLoggedInDriver == true) {
          // print("family_ready_order_id   driver");
          Provider.of<intIndexorder>(context, listen: false)
              .changeIntIndexorder(1);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainDriver(
                        currentIndex: 4,
                        orderIndex: 1,
                      )));
        }
        break;

      // ** order_delivered from user to request     driver  family  end
      case 'order_delivered':
        if (SharedPreferencesController().isLoggedInDriver == true) {
          // print("order_delivered   driver");
          Provider.of<intIndexorder>(context, listen: false)
              .changeIntIndexorder(2);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainDriver(
                        currentIndex: 4,
                        orderIndex: 2,
                      )));
        }
        if (SharedPreferencesController().isLoggedInFamily == true) {
          // print("order_delivered   family");
          Provider.of<intIndexorder>(context, listen: false)
              .changeIntIndexorder(2);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainFamily(
                        currentIndex: 4,
                        orderIndex: 2,
                      )));
        }

        break;

      //rate  from family driver    user end
      case 'family_rate_me_ready_order_id':
        if (SharedPreferencesController().isLoggedInUser == true) {
          // print("family_rate_me_ready_order_id   user");

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainScreen(
                        currentIndex: 1,
                        orderIndex: 1,
                      )));
        }
        break;

      //rate  from user     family end    driver end
      case 'order_rating':
        if (SharedPreferencesController().isLoggedInFamily == true) {
          // print("order_rating   family");
          Provider.of<intIndexorder>(context, listen: false)
              .changeIntIndexorder(2);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainFamily(
                        currentIndex: 4,
                        orderIndex: 2,
                      )));
        }
        if (SharedPreferencesController().isLoggedInDriver == true) {
          // print("order_rating   driver");

          Provider.of<intIndexorder>(context, listen: false)
              .changeIntIndexorder(2);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainDriver(
                        currentIndex: 4,
                        orderIndex: 2,
                      )));
        }
        break;

      // send_message from admin
      case 'send_message':
        if (SharedPreferencesController().isLoggedInFamily == true) {
          // print("send_message");

          Provider.of<intIndexProfile>(context, listen: false)
              .changeIntIndexProfile(1);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainFamily(
                        currentIndex: 0,
                        profileIndex: 1,
                      )));
        }
        if (SharedPreferencesController().isLoggedInDriver == true) {
          // print("send_message");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainDriver(
                        currentIndex: 1,
                      )));
        }
        break;

      //chat
      case 'chat_room':
        // print("chat_room");
        if (SharedPreferencesController().isLoggedInFamily == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ChatFamily(
                        orderNo: '2',
                      )));
        }
        if (SharedPreferencesController().isLoggedInUser == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const Chat(
                        orderNo: '2',
                      )));
        }
        if (SharedPreferencesController().isLoggedInDriver == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainDriver(
                        currentIndex: 4,
                        orderIndex: 1,
                      )));
        }
        break;
    }
  }
}
