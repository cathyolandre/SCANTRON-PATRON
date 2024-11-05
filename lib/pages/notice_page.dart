// lib/pages/notice_page.dart

import 'package:flutter/material.dart';
import 'order_page.dart'; // Import the OrderPage
import 'customer_support_page.dart'; // Import the Customer Support Page
import '../models/inventory.dart'; // Import the Inventory model

class NoticePage extends StatelessWidget {
  final int currentPaperCount; // Accept the current paper count
  final List<String> transactions; // Accept the transactions list

  const NoticePage({
    super.key,
    required this.currentPaperCount,
    required this.transactions, // Constructor now requires transactions
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notice"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOW ON PAPER: $currentPaperCount remaining.",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Space between text and buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderPage(
                      inventory: Inventory(currentPaperCount), // Pass the current paper count
                      transactions: transactions, // Pass the transactions list
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              ),
              child: Text(
                "Yes, I want to order more!",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 10), // Space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerSupportPage(
                      inventory: Inventory(currentPaperCount), // Pass the inventory with the current paper count
                      transactions: transactions, // Pass the transactions list
                    ),
                  ),
                ); // Navigate to Customer Support
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              ),
              child: Text(
                "No, I need support.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
