import 'package:flutter/material.dart';

class PushNotificationView extends StatelessWidget {
  const PushNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text("Flutter Push Notifiations"),
      ),
    );
  }
}
