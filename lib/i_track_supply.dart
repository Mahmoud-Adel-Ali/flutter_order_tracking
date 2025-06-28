import 'package:flutter/material.dart';

import 'features/test_push_noti/views/push_notification_view.dart';

class ITrackSupply extends StatelessWidget {
  const ITrackSupply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      debugShowCheckedModeBanner: false,
      home: const PushNotificationView(),
    );
  }
}
