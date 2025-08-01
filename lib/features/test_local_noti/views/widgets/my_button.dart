import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.title,
    this.onPressed,
    this.onCancel,
  });
  final String title;
  final Function()? onPressed;
  final Function()? onCancel;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      color: Theme.of(context).colorScheme.inversePrimary,
      onPressed: onPressed ?? () {},
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onPressed,
        title: Text(
          title,
          style: const TextStyle(fontSize: 25),
          overflow: TextOverflow.clip,
        ),
        leading: const Icon(Icons.notifications_active),
        trailing: IconButton(
          onPressed: onCancel,
          icon: const Icon(Icons.cancel, color: Colors.red),
        ),
      ),
    );
  }
}
