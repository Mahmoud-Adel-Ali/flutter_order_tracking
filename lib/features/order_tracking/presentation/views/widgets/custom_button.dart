import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor,
    this.color,
  });
  final Function()? onPressed;
  final String text;
  final Color? textColor;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color ?? Theme.of(context).colorScheme.inverseSurface,
      minWidth: MediaQuery.sizeOf(context).width,
      height: 65,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
