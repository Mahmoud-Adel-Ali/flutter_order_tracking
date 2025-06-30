import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

abstract class PushNotificationServirces {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    log('[Push Notification] Initializing...');
    await messaging.requestPermission();
    String? token = await messaging.getToken();
    log('Token: $token');
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

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
}
