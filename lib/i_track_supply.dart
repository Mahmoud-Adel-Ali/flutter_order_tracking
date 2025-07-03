import 'package:flutter/material.dart';

import 'core/utils/app_routes.dart';

class ITrackSupply extends StatelessWidget {
  const ITrackSupply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashView,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
