import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:image_enhancer/splash_screen/splash_screen.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification({
    required String title,
    required String body,
    required String payLoad,
  }) async {
    return notificationsPlugin.show(
        0, title, body, await notificationDetails());
  }

  ///
  ///
  void firebaseNotification() {
    //////////////////////////////////////////////////////////////////////////
    ///  This method call when app in terminated state and you get a notification
    //////////////////////////////////////////////////////////////////////////
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) async {
        log("FirebaseMessaging.onMessageOpenedApp.listen");
        RemoteNotification? notification = message?.notification;

        if (notification != null) {
          Map data = message!.data;
          log(data.toString());
          if (data["message_notification"] == "true") {
          } else {
            showNotification(
              title: notification.title ?? "",
              body: notification.body ?? "",
              payLoad: message.data.toString(),
            );
            Get.to(() => SplashScreen());
          }
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        Map data = message.data;
        log(data.toString());
        if (data["message_notification"] == "true") {
        } else {
          showNotification(
            title: notification.title ?? "",
            body: notification.body ?? "",
            payLoad: message.data.toString(),
          );
        }
      }
    });

    ////////////////////////////////////////////////////////////////////////////
    // 3. This method only call when App in background and not terminated(not closed)
    ////////////////////////////////////////////////////////////////////////////
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        /* -------------------------------------------------------------------------- */
        /*                            navigate accordingly                            */
        /* -------------------------------------------------------------------------- */

        log("FirebaseMessaging.onMessageOpenedApp.listen");
        RemoteNotification? notification = message.notification;

        if (notification != null) {
          Map data = message.data;
          log(data.toString());
          if (data["message_notification"] == "true") {
          } else {
            showNotification(
              title: notification.title ?? "",
              body: notification.body ?? "",
              payLoad: message.data.toString(),
            );
            Get.to(() => SplashScreen());
          }
        }
      },
    );
  }
}
