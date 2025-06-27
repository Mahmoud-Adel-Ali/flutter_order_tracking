import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationDetailsView extends StatelessWidget {
  const NotificationDetailsView({
    super.key,
    required this.notificationResponse,
  });
  final NotificationResponse notificationResponse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Details')),
      body: Center(
        child: Column(
          children: [
            Text(notificationResponse.id!.toString()),
            const SizedBox(height: 25),
            Text(notificationResponse.actionId.toString()),
            const SizedBox(height: 25),
            Text(notificationResponse.payload.toString()),
          ],
        ),
      ),
    );
  }
}
