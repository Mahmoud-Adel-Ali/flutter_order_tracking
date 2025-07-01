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
    );
  }

  static Future<AndroidNotificationDetails> _androidNotificationDetails({
    String? title,
    String? body,
    String? imageUrl,
  }) async {
    final largeIconPath = await _downloadAndSaveImage(
      imageUrl ?? '',
      'largeIcon',
    );
    final bigPicturePath = await _downloadAndSaveImage(
      imageUrl ?? '',
      'bigPicture',
    );
    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      contentTitle: title,
      summaryText: body,
    );

    // Optional custom sound (make sure you have the file in android/app/src/main/res/raw/)
    // final sound = RawResourceAndroidNotificationSound('notification_sound');

    return AndroidNotificationDetails(
      'basic_channel_id', // Channel ID
      'Order Notifications', // Channel name
      channelDescription:
          'Notifications about order updates and important alerts',
      priority: Priority.high,
      importance: Importance.max,
      // sound: sound,
      styleInformation: styleInformation,
      // Automatically applies big style to long body
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

///////////////////////////////////////////////


  // // 🔕 Cancel a notification
  // static Future<void> cancelNotification(int id) async {
  //   await flutterLocalNotificationsPlugin.cancel(id);
  //   log('[Notification] Canceled notification ID: $id');
  // }

  // // 🔁 Repeated notification every minute
  // static Future<void> showRepeatedNotification() async {
  //   final details = NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'repeat_channel',
  //       'Repeated Notifications',
  //       priority: Priority.high,
  //       importance: Importance.max,
  //     ),
  //   );

  //   await flutterLocalNotificationsPlugin.periodicallyShow(
  //     1,
  //     'Reminder',
  //     'Check your pending orders.',
  //     RepeatInterval.everyMinute,
  //     details,
  //     androidScheduleMode: AndroidScheduleMode.alarmClock,
  //     payload: 'repeated_notification_payload',
  //   );
  // }

  // // ⏰ Scheduled notification (after 5 seconds)
  // static Future<void> showScheduledNotification() async {
  //   await _setupTimezone();
  //   final scheduleTime = tz.TZDateTime.now(
  //     tz.local,
  //   ).add(const Duration(seconds: 5));

  //   final details = NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'scheduled_channel',
  //       'Scheduled Notifications',
  //       priority: Priority.high,
  //       importance: Importance.max,
  //     ),
  //   );

  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     2,
  //     'Scheduled Alert',
  //     'This is your scheduled order update.',
  //     scheduleTime,
  //     details,
  //     androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
  //     payload: 'scheduled_notification_payload',
  //   );
  // }

  // // 🕖 Daily notification at 8 PM
  // static Future<void> showDailyNotification() async {
  //   await _setupTimezone();
  //   final now = tz.TZDateTime.now(tz.local);
  //   var scheduledTime = tz.TZDateTime(
  //     tz.local,
  //     now.year,
  //     now.month,
  //     now.day,
  //     20,
  //   );

  //   if (scheduledTime.isBefore(now)) {
  //     scheduledTime = scheduledTime.add(const Duration(days: 1));
  //   }

  //   final sound = RawResourceAndroidNotificationSound('notification_sound');
  //   final details = NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'daily_channel',
  //       'Daily Notifications',
  //       priority: Priority.high,
  //       importance: Importance.max,
  //       sound: sound,
  //     ),
  //   );

  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     3,
  //     'Daily Reminder 💊',
  //     "Don't forget to check your tasks.",
  //     scheduledTime,
  //     details,
  //     androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
  //     payload: 'daily_notification_payload',
  //   );
  // }

  // // 🌍 Setup timezone (required for scheduled notifications)
  // static Future<void> _setupTimezone() async {
  //   final String timeZone = await FlutterTimezone.getLocalTimezone();
  //   tz.initializeTimeZones();
  //   tz.setLocalLocation(tz.getLocation(timeZone));
  // }
