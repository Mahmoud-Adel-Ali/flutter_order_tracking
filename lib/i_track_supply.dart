import 'package:flutter/material.dart';

import 'features/test_local_noti/views/test_view.dart';

class ITrackSupply extends StatelessWidget {
  const ITrackSupply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      debugShowCheckedModeBanner: false,
      home: TestView(),
    );
  }
}
