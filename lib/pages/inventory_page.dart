// lib/pages/inventory_page.dart

import 'package:flutter/material.dart';
import '../models/inventory.dart'; // Import the Inventory model

class InventoryPage extends StatefulWidget {
  final Inventory inventory; // Accept the Inventory instance

  const InventoryPage({super.key, required this.inventory});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Management"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Current Paper Limit: ${widget.inventory.paperLimit}",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showChangeLimitDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text("Change Paper Limit"),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeLimitDialog(BuildContext context) {
    TextEditingController limitController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Paper Limit"),
          content: TextField(
            controller: limitController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Enter new limit",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  int? newLimit = int.tryParse(limitController.text);
                  if (newLimit != null) {
                    widget.inventory.paperLimit = newLimit; // Update the limit
                  }
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
