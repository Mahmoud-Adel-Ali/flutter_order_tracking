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
      title: "Order Received",
      body: "Your order has been received and is awaiting confirmation.",
    );
    emit(OrderStatusCompleted());
  }

  void completeConfirmed() {
    currentIndex = 2;
    _showNotificaiton(
      title: "Order Confirmed",
      body: "Your order has been confirmed and is being prepared for shipment.",
    );
    emit(OrderStatusCompleted());
  }

  void completeShipped() {
    currentIndex = 3;
    _showNotificaiton(
      title: "Order Shipped",
      body: "Your order is on its way. Track its progress in the app.",
    );
    emit(OrderStatusCompleted());
  }

  void completeDelivered() {
    currentIndex = 4;
    _showNotificaiton(
      title: "Order Delivered",
      body: "Your order has been successfully delivered. Thank you for choosing us!",
    );
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
