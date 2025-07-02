import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/cubit/order_status_cubit.dart';

class CustomFloatingActionButtonIcon extends StatelessWidget {
  const CustomFloatingActionButtonIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xFF009688),
      onPressed: () {
        context.read<OrderStatusCubit>().reset();
      },
      child: const Icon(Icons.refresh, color: Colors.white),
    );
  }
}
