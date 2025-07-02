
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/cubit/order_status_cubit.dart';
import '../../manager/functions/status_lable.dart';

class OrderStatusProgressBar extends StatelessWidget {
  const OrderStatusProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<OrderStatusCubit>();
    return BlocBuilder<OrderStatusCubit, OrderStatusState>(
      builder: (context, state) {
        return Row(
          children: cubit.statuses.map((status) {
            int index = cubit.statuses.indexOf(status);
            bool isCompleted = index < cubit.currentIndex;
            bool isCurrent = index == cubit.currentIndex;

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
        );
      },
    );
  }
}
