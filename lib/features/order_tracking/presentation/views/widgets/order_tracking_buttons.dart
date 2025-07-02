import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/cubit/order_status_cubit.dart';
import 'custom_button.dart';

class OrderTrackingButtons extends StatelessWidget {
  const OrderTrackingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        CustomButton(
          text: "Complete Pending",
          color: Colors.orange,
          onPressed: () {
            context.read<OrderStatusCubit>().completePending();
          },
        ),
        CustomButton(
          text: "Complete Confirmed",
          color: Colors.blue,
          onPressed: () {
            context.read<OrderStatusCubit>().completeConfirmed();
          },
        ),
        CustomButton(
          text: "Complete Shipped",
          color: Colors.teal,
          onPressed: () {
            context.read<OrderStatusCubit>().completeShipped();
          },
        ),
        CustomButton(
          text: "Complete Delivered",
          color: Colors.green,
          onPressed: () {
            context.read<OrderStatusCubit>().completeDelivered();
          },
        ),
      ],
    );
  }
}
