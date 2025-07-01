import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notification_services.dart';

abstract class PushNotificationServirces {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    log('[Push Notification] Initializing...');
    await messaging.requestPermission();

    // When we want to subscribe to a topic
    messaging.subscribeToTopic('all').then((value) {
      log('[Push Notification] Subscribed to topic (all) successfully.');
    });
    // When we want to unsubscribe from a topic
    //messaging.unsubscribeFromTopic('all');

    await messaging.getToken().then((value) {
      sendTokenToServer(value);
    });
    messaging.onTokenRefresh.listen((value) {
      sendTokenToServer(value);
    });
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

  static void sendTokenToServer(String? token) {
    log('[Push Notification] Token: $token');
    // Option one : send token to API
    // Option two : send token to Firebase
  }
}
