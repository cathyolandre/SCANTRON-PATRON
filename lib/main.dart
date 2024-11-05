// lib/main.dart

import 'package:flutter/material.dart';
import 'pages/hello_page.dart';
import 'pages/notice_page.dart';
import 'models/inventory.dart'; // Import the Inventory model

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scantron Ordering System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InitialPage(), // Set the initial page to our new logic
    );
  }
}

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Inventory inventory = Inventory(200); // Initialize with your current limit

    // Check the paper limit and navigate accordingly
    if (inventory.paperLimit <= 30) {
      return NoticePage(currentPaperCount: inventory.paperLimit, transactions: [],); // Show NoticePage if limit is low
    } else {
      return HelloPage(); // Show HelloPage otherwise
    }
  }
}
