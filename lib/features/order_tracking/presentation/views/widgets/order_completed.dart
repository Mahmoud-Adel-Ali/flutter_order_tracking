import 'package:flutter/material.dart';

class OrderCompleted extends StatelessWidget {
  const OrderCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
            const SizedBox(height: 16),
            const Text(
              "Order Completed",
              style: TextStyle(
                color: Colors.green,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your order has been delivered successfully.\nThank you for choosing us!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              icon: const Icon(
                Icons.receipt_long_outlined,
                color: Colors.white,
                size: 32,
              ),
              label: const Text(
                "View Invoice",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () {
                // TODO: Navigate to invoice screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
