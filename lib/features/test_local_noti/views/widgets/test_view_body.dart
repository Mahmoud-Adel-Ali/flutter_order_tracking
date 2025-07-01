import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/local_notification_services.dart';
import '../notefication_details_view.dart';
import 'my_button.dart';

class TestViewBody extends StatefulWidget {
  const TestViewBody({super.key});

  @override
  State<TestViewBody> createState() => _TestViewBodyState();
}

class _TestViewBodyState extends State<TestViewBody> {
  void listenStreamNotification() {
    LocalNotificationServices.streamController.stream.listen((
      notificationResponse,
    ) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NotificationDetailsView(
            notificationResponse: notificationResponse,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    listenStreamNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Notifications..", style: TextStyle(fontSize: 40)),
          const SizedBox(height: 40),
          MyButton(
            onPressed: () {
              LocalNotificationServices.showBasicNotification(
                const RemoteMessage(
                  notification: RemoteNotification(
                    title: 'New Prescription Ready',
                    body:
                        'Your medication is ready for pickup at your preferred pharmacy.',
                  ),
                ),
              );
            },
            onCancel: () {
              cancelBasicNotification();
            },
            title: "Basic",
          ),
          const SizedBox(height: 40),
          MyButton(
            onPressed: () {
              LocalNotificationServices.showRepeatedNotification();
            },
            onCancel: () {
              cancelRepeatedNotification();
            },
            title: "Repeated",
          ),
          const SizedBox(height: 40),
          MyButton(
            onPressed: () {
              // LocalNotificationServices.dailyScheduledNotification();
              // LocalNotificationServices.showScheduledNotification();
            },
            onCancel: () {
              cancelScheduledNotification();
            },
            title: "Scheduled",
          ),
          const SizedBox(height: 40),
          IconButton(
            onPressed: () {
              cancelBasicNotification();
              cancelRepeatedNotification();
              cancelScheduledNotification();
            },
            icon: const Text("Cancel all"),
          ),
        ],
      ),
    );
  }

  void cancelScheduledNotification() {
    LocalNotificationServices.cancelNotification(2);
  }

  void cancelRepeatedNotification() {
    LocalNotificationServices.cancelNotification(1);
  }

  void cancelBasicNotification() {
    //base notification
    LocalNotificationServices.cancelNotification(0);
  }
}
