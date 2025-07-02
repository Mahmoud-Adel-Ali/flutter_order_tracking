import 'package:flutter/material.dart';

import 'order_status_progress_bar.dart';
import 'order_tracking_buttons.dart';

class OrderTrackingViewBody extends StatelessWidget {
  const OrderTrackingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        Text("Order Status", style: Theme.of(context).textTheme.titleLarge),
        OrderStatusProgressBar(),
        OrderTrackingButtons(),
      ],
    );
  }
}
