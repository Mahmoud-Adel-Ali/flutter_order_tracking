import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

abstract class LocalNotificationServices {
  // 📌 Flutter local notification plugin
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final StreamController<NotificationResponse> streamController =
      StreamController<NotificationResponse>.broadcast();

  // 📌 Initialize local notification plugin
  static Future<void> init() async {
    log('[Notification] Initializing...');
    InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onTap,
      onDidReceiveBackgroundNotificationResponse: _onTap,
    );

    log('[Notification] Initialized successfully.');
  }

  // 🖱️ Tap handler
  static void _onTap(NotificationResponse response) {
    log('[Notification] Tapped: ${response.payload}');
    streamController.add(response);
  }

  // 🔔 Basic notification with custom sound
  static Future<void> showBasicNotification(RemoteMessage message) async {
    await flutterLocalNotificationsPlugin.show(
      uuid.v4().hashCode.abs(),
      message.notification?.title, // Notification title
      message.notification?.body, // Notification body
      await _notificationDetails(
        title: message.notification?.title ?? 'No title',
        body: message.notification?.body ?? 'No body',
        imageUrl: message.notification?.android?.imageUrl,
      ),
      payload: message.data['route'] ?? 'default_payload',
    );
  }

  static Future<NotificationDetails> _notificationDetails({
    String? title,
    String? body,
    String? imageUrl,
  }) async {
    return NotificationDetails(
      android: await _androidNotificationDetails(
        title: title,
        body: body,
        imageUrl: imageUrl,
      ),
      iOS: _iosDetails(),
    );
  }

  static _iosDetails() {
    return DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'notification_sound.wav',
    );
  }

  static Future<AndroidNotificationDetails> _androidNotificationDetails({
    String? title,
    String? body,
    String? imageUrl,
  }) async {
    BigPictureStyleInformation? styleInformation;
    if (imageUrl != null) {
      final largeIconPath = await _downloadAndSaveImage(imageUrl, 'largeIcon');
      final bigPicturePath = await _downloadAndSaveImage(
        imageUrl,
        'bigPicture',
      );
      styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        largeIcon: FilePathAndroidBitmap(largeIconPath),
        contentTitle: title,
        summaryText: body,
      );
    }
    // Optional custom sound (make sure you have the file in android/app/src/main/res/raw/)
    final sound = RawResourceAndroidNotificationSound(
      'notification_sound'.split('.').first,
    );

    return AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription:
          'Notifications about order updates and important alerts',
      priority: Priority.high,
      importance: Importance.max,
      sound: sound,
      playSound: true,
      styleInformation: imageUrl == null ? null : styleInformation,
    );
  }

  static Future<String> _downloadAndSaveImage(
    String url,
    String fileName,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
