import 'package:flutter/material.dart';

import '../../data/enums/order_status.dart';

OrderStatus currentOrderStatus = OrderStatus.confirmed;

class OrderTrackingView extends StatelessWidget {
  const OrderTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Order"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: OrderStatusProgressBar(currentStatus: currentOrderStatus),
      ),
    );
  }
}

class OrderStatusProgressBar extends StatelessWidget {
  final OrderStatus currentStatus;

  const OrderStatusProgressBar({super.key, required this.currentStatus});

  @override
  Widget build(BuildContext context) {
    List<OrderStatus> statuses = [
      OrderStatus.pending,
      OrderStatus.confirmed,
      OrderStatus.shipped,
      OrderStatus.delivered,
    ];

    int currentIndex = statuses.indexOf(currentStatus);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Order Status", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Row(
          children: statuses.map((status) {
            int index = statuses.indexOf(status);
            bool isCompleted = index < currentIndex;
            bool isCurrent = index == currentIndex;

            Color color;
            IconData icon;

            if (isCompleted) {
              color = Colors.green;
              icon = Icons.check_circle;
            } else if (isCurrent) {
              color = Colors.blue;
              icon = Icons.autorenew;
            } else {
              color = Colors.grey;
              icon = Icons.radio_button_unchecked;
            }

            return Expanded(
              child: Column(
                children: [
                  Icon(icon, color: color),
                  const SizedBox(height: 4),
                  Text(
                    statusLabel(status),
                    style: TextStyle(
                      color: color,
                      fontWeight: isCurrent
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String statusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return "Pending";
      case OrderStatus.confirmed:
        return "Confirmed";
      case OrderStatus.shipped:
        return "Shipped";
      case OrderStatus.delivered:
        return "Delivered";
    }
  }
}
