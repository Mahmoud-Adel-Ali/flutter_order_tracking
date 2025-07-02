import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_order_tracking/core/services/local_notification_services.dart';

import '../../../data/enums/order_status.dart';

part 'order_status_state.dart';

class OrderStatusCubit extends Cubit<OrderStatusState> {
  OrderStatusCubit() : super(OrderStatusInitial());
  List<OrderStatus> statuses = [
    OrderStatus.pending,
    OrderStatus.confirmed,
    OrderStatus.shipped,
    OrderStatus.delivered,
  ];

  int currentIndex = 0, initialIndex = 0;

  void completePending() {
    currentIndex = 1;
    _showNotificaiton(
      title: "Order Pending",
      body: "Your order has been Pending and is being processed",
    );
    emit(OrderStatusCompleted());
  }

  void completeConfirmed() {
    currentIndex = 2;
    emit(OrderStatusCompleted());
  }

  void completeShipped() {
    currentIndex = 3;
    emit(OrderStatusCompleted());
  }

  void completeDelivered() {
    currentIndex = 4;
    emit(OrderStatusCompleted());
  }

  void reset() {
    currentIndex = initialIndex;
    emit(OrderStatusInitial());
  }

  void _showNotificaiton({required String title, required String body}) {
    LocalNotificationServices.showBasicNotification(
      RemoteMessage(
        notification: RemoteNotification(title: title, body: body),
      ),
    );
  }
}
