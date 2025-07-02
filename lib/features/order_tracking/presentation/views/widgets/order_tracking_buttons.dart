import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/cubit/order_status_cubit.dart';
import 'custom_button.dart';
import 'order_completed.dart';

class OrderTrackingButtons extends StatelessWidget {
  const OrderTrackingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<OrderStatusCubit>();
    return BlocBuilder<OrderStatusCubit, OrderStatusState>(
      builder: (context, state) {
        return SizedBox(
          width: double.maxFinite,
          child: cubit.currentIndex == 0
              ? CustomButton(
                  text: "Waiting for Confirmation",
                  color: Colors.orange,
                  onPressed: () {
                    context.read<OrderStatusCubit>().completePending();
                  },
                )
              : cubit.currentIndex == 1
              ? CustomButton(
                  text: "Preparing Your Order",
                  color: Colors.blue,
                  onPressed: () {
                    context.read<OrderStatusCubit>().completeConfirmed();
                  },
                )
              : cubit.currentIndex == 2
              ? CustomButton(
                  text: "Track Shipment",
                  color: Colors.teal,
                  onPressed: () {
                    context.read<OrderStatusCubit>().completeShipped();
                  },
                )
              : cubit.currentIndex == 3
              ? CustomButton(
                  text: "View Invoice",
                  color: Colors.green,
                  onPressed: () {
                    context.read<OrderStatusCubit>().completeDelivered();
                  },
                )
              : const OrderCompleted(),
        );
      },
    );
  }
}
