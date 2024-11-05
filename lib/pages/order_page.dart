// lib/pages/order_page.dart

import 'package:flutter/material.dart';
import '../models/inventory.dart'; // Import the Inventory model

class OrderPage extends StatefulWidget {
  final Inventory inventory; // Accept the inventory

  const OrderPage({super.key, required this.inventory});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _counter = 0; // Initialize the counter
  List<String> transactions = []; // List to store print transactions

  void _incrementCounter() {
    setState(() {
      if (_counter < widget.inventory.paperLimit) { // Ensure counter does not exceed paper limit
        _counter++;
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--; // Ensure counter doesn't go below 0
    });
  }

  void _printReceipt() {
    // Store the current count in a temporary variable
    final int printCount = _counter; 

    // Deduct from inventory
    widget.inventory.deductPaper(printCount);
    
    // Record the transaction
    transactions.add("Printed $printCount Scantrons");

    // Show receipt dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Receipt Printed"),
          content: Text("You have printed $printCount Scantrons."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pop(context); // Go back to HelloPage
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );

    // Reset counter after printing
    setState(() {
      _counter = 0; // Reset counter after printing
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SCANTRON ORDER",
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Space between text and counter row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
                  ),
                  child: Text(
                    "-",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 20), // Space between button and counter
                Text(
                  '$_counter',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 20), // Space between counter and button
                ElevatedButton(
                  onPressed: _incrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
                  ),
                  child: Text(
                    "+",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Space between counter and print button
            ElevatedButton(
              onPressed: _counter >= 1 ? _printReceipt : null, // Disable if counter is less than 1
              style: ElevatedButton.styleFrom(
                backgroundColor: _counter >= 1 ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey, // Change color if disabled
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              ),
              child: Text(
                "CONFIRM",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
