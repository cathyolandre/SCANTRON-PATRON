// lib/pages/order_page.dart

import 'package:flutter/material.dart';
import '../models/inventory.dart'; // Import the Inventory model
import '../pages/notice_page.dart'; // Import the NoticePage

class OrderPage extends StatefulWidget {
  final Inventory inventory; // Accept the inventory
  final List<String> transactions; // Accept the transactions list

  const OrderPage({super.key, required this.inventory, required this.transactions}); // Include transactions in the constructor

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _counter = 0; // Initialize the counter

  void _incrementCounter() {
    setState(() {
      if (_counter < widget.inventory.paperLimit && widget.inventory.paperLimit > 5) { // Ensure counter does not exceed paper limit and is above 5
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
    final int printCount = _counter;

    // Deduct from inventory
    widget.inventory.deductPaper(printCount);

    // Record the transaction with date and time
    String transaction = "Printed $printCount Scantrons at ${DateTime.now()}";
    widget.transactions.add(transaction); // Add transaction to the list

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

                // Check the current paper count after printing
                if (widget.inventory.paperLimit <= 30) { // Check the paper limit
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoticePage(currentPaperCount: widget.inventory.paperLimit, transactions: [],), // Pass current paper count
                    ),
                  );
                } else {
                  Navigator.pop(context); // Go back to HelloPage
                }
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
                  onPressed: widget.inventory.paperLimit > 5 ? _incrementCounter : null, // Disable if paper limit is 5 or below
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.inventory.paperLimit > 5 ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey,
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
                backgroundColor: _counter >= 1 ? const Color.fromARGB(255, 0, 0, 0) : Colors.grey,
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
