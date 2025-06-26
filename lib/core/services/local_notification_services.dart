import 'dart:async';
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class LocalNotificationServices {
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
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );

    log('[Notification] Initialized successfully.');
  }

  // 🖱️ Tap handler
  static void onTap(NotificationResponse response) {
    log('[Notification] Tapped: ${response.payload}');
    streamController.add(response);
  }

  // 🔕 Cancel a notification
  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    log('[Notification] Canceled notification ID: $id');
  }

  // 🔔 Basic notification with custom sound
  static Future<void> showBasicNotification() async {
    // final sound = RawResourceAndroidNotificationSound('notification_sound');
    final androidDetails = AndroidNotificationDetails(
      'basic_channel',
      'Basic Notifications',
      priority: Priority.high,
      importance: Importance.max,
      // sound: sound,
    );

    var iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Order Status Update', //title
      'Your order has been shipped!', //body
      details,
      payload: 'basic_notification_payload',
    );
  }

  // 🔁 Repeated notification every minute
  static Future<void> showRepeatedNotification() async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'repeat_channel',
        'Repeated Notifications',
        priority: Priority.high,
        importance: Importance.max,
      ),
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      'Reminder',
      'Check your pending orders.',
      RepeatInterval.everyMinute,
      details,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      payload: 'repeated_notification_payload',
    );
  }

  // ⏰ Scheduled notification (after 5 seconds)
  static Future<void> showScheduledNotification() async {
    await _setupTimezone();
    final scheduleTime = tz.TZDateTime.now(
      tz.local,
    ).add(const Duration(seconds: 5));

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'scheduled_channel',
        'Scheduled Notifications',
        priority: Priority.high,
        importance: Importance.max,
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      'Scheduled Alert',
      'This is your scheduled order update.',
      scheduleTime,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: 'scheduled_notification_payload',
    );
  }

  // 🕖 Daily notification at 8 PM
  static Future<void> showDailyNotification() async {
    await _setupTimezone();
    final now = tz.TZDateTime.now(tz.local);
    var scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      20,
    );

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    final sound = RawResourceAndroidNotificationSound('notification_sound');
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel',
        'Daily Notifications',
        priority: Priority.high,
        importance: Importance.max,
        sound: sound,
      ),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      'Daily Reminder 💊',
      "Don't forget to check your tasks.",
      scheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: 'daily_notification_payload',
    );
  }

  // 🌍 Setup timezone (required for scheduled notifications)
  static Future<void> _setupTimezone() async {
    final String timeZone = await FlutterTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }
}
