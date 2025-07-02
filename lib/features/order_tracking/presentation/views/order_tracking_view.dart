import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/cubit/order_status_cubit.dart';
import 'widgets/custom_floating_action_button_icon.dart';
import 'widgets/order_tracking_view_body.dart';

class OrderTrackingView extends StatelessWidget {
  const OrderTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderStatusCubit>(
      create: (context) => OrderStatusCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order Tracker"),
          centerTitle: true,
          backgroundColor: Color(0xFF1976D2),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: OrderTrackingViewBody(),
        ),
        floatingActionButton: CustomFloatingActionButtonIcon(),
      ),
    );
  }
}
