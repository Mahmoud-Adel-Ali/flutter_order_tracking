import 'package:flutter/material.dart';

import 'features/order_tracking/presentation/views/order_tracking_view.dart';

class ITrackSupply extends StatelessWidget {
  const ITrackSupply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const OrderTrackingView(),
    );
  }
}
