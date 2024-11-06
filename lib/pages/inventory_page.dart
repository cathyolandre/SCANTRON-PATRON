// lib/pages/inventory_page.dart

import 'package:flutter/material.dart';
import '../models/inventory.dart'; // Import the Inventory model
import 'package:shared_preferences/shared_preferences.dart';

class InventoryPage extends StatefulWidget {
  final Inventory inventory; // Accept the Inventory instance
  final List<String> transactions; // Accept the transactions list

  const InventoryPage({super.key, required this.inventory, required this.transactions});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  late int paperLimit;

  @override
  void initState() {
    super.initState();
    paperLimit = widget.inventory.paperLimit;
    _loadPaperLimit();
  }

  // Load paper limit from SharedPreferences
  Future<void> _loadPaperLimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      paperLimit = prefs.getInt('paperLimit') ?? widget.inventory.paperLimit;
    });
  }

  // Save paper limit to SharedPreferences
  Future<void> _savePaperLimit(int limit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('paperLimit', limit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory Management"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Current Paper Limit: $paperLimit",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showChangeLimitDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text("Change Paper Limit"),
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
          title: const Text("Change Paper Limit"),
          content: TextField(
            controller: limitController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Enter new limit",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  int? newLimit = int.tryParse(limitController.text);
                  if (newLimit != null) {
                    // Log the change in transactions
                    widget.transactions.add("Changed paper limit from $paperLimit to $newLimit on ${DateTime.now().toLocal()}");

                    paperLimit = newLimit; // Update the displayed limit
                    widget.inventory.paperLimit = newLimit; // Update the Inventory instance
                    _savePaperLimit(newLimit); // Persist the new limit

                    // If the limit is 30 or below, return to HelloPage with updated inventory
                    if (newLimit <= 30) {
                      Navigator.pop(context, widget.inventory); // Return updated inventory to HelloPage
                    } else {
                      Navigator.of(context).pop(); // Close the dialog without returning
                    }
                  }
                });
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
