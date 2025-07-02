import 'package:flutter/material.dart';

import '../../../features/order_tracking/presentation/views/order_tracking_view.dart';
import '../../../features/splash/presentation/view/splash_view.dart';

class AppRoutes {
  static const String splashView = 'splashView';
  static const String orderTrackingView = 'orderTrackingView';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashView:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case orderTrackingView:
        return MaterialPageRoute(builder: (context) => const OrderTrackingView());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
        );
    }
  }
}
