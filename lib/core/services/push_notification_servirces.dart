import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notification_services.dart';

abstract class PushNotificationServirces {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    log('[Push Notification] Initializing...');
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    log('Token: $token');
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    //On Foreground Message
    forgroundMessageHandler();

    log('[Push Notification] Initialized successfully.');
  }

  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    //title, body
    log(
      '[Push Notification] Background message: ${message.notification?.title}',
    );
    log(
      '[Push Notification] Background message: ${message.notification?.body}',
    );
  }

  static void forgroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //local notification
      LocalNotificationServices.showBasicNotification(message);
    });
  }
}
