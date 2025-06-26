import 'package:flutter/material.dart';

import 'widgets/test_view_body.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text("Flutter Local Notifiations"),
      ),
      body: const TestViewBody(),
    );
  }
}
