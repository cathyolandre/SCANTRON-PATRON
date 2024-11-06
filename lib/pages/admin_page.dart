// lib/pages/admin_page.dart

import 'package:flutter/material.dart';
import 'inventory_page.dart'; // Import the InventoryPage
import 'view_report_page.dart'; // Import the ViewReportPage
import '../models/inventory.dart'; // Ensure to import the Inventory model
import 'notice_page.dart'; // Import the NoticePage
import 'hello_page.dart'; // Import the HelloPage
import 'package:shared_preferences/shared_preferences.dart';

class AdminPage extends StatefulWidget {
  final Inventory inventory; // Add the inventory parameter
  final List<String> transactions; // Add transactions parameter

  const AdminPage({super.key, required this.inventory, required this.transactions}); // Include inventory and transactions in the constructor

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late int paperLimit;

  @override
  void initState() {
    super.initState();
    paperLimit = widget.inventory.paperLimit;
    _loadPaperLimit();
    _loadTransactions();
  }

  // Load paper limit from SharedPreferences
  Future<void> _loadPaperLimit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      paperLimit = prefs.getInt('paperLimit') ?? widget.inventory.paperLimit;
    });
  }

  // Load transaction log from SharedPreferences
  Future<void> _loadTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.transactions.addAll(prefs.getStringList('transactions') ?? []);
    });
  }

  // Save updated transaction log to SharedPreferences
  Future<void> _saveTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('transactions', widget.transactions);
  }

  // Save updated paper limit to SharedPreferences
  Future<void> _savePaperLimit(int limit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('paperLimit', limit);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check the paper limit here
        if (paperLimit <= 30) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NoticePage(
                currentPaperCount: paperLimit,
                transactions: widget.transactions,
              ),
            ),
          );
          return false; // Prevent default back navigation
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HelloPage()),
          );
          return false; // Prevent default back navigation
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ADMIN PAGE",
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 20), // Space between text and buttons

              // Button for viewing reports with an icon
              SizedBox(
                width: 100, // Set width for the button
                height: 100, // Set height for the button
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the View Report Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewReportPage(transactions: widget.transactions), // Pass transactions
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 35, 64), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                    ),
                  ),
                  child: Icon(
                    Icons.assessment, // Report icon
                    color: Colors.white, // Icon color
                    size: 40, // Icon size
                  ),
                ),
              ),
              SizedBox(height: 10), // Space between buttons

              // Button for managing users with an icon
              SizedBox(
                width: 100, // Set width for the button
                height: 100, // Set height for the button
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for managing users
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 69, 3), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                    ),
                  ),
                  child: Icon(
                    Icons.person, // Person icon
                    color: Colors.white, // Icon color
                    size: 40, // Icon size
                  ),
                ),
              ),
              SizedBox(height: 10), // Space between buttons

              // Button for inventory management with an icon
              SizedBox(
                width: 100, // Set width for the button
                height: 100, // Set height for the button
                child: ElevatedButton(
                  onPressed: () async {
                    // Navigate to the InventoryPage and await changes
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InventoryPage(
                          inventory: widget.inventory,
                          transactions: widget.transactions,
                        ),
                      ),
                    );

                    // If inventory was updated, refresh paper limit and save
                    if (result != null && result is Inventory) {
                      setState(() {
                        paperLimit = result.paperLimit;
                      });
                      _savePaperLimit(paperLimit);
                      _saveTransactions(); // Save transactions after any changes
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 56, 34, 0), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Rounded corners
                    ),
                  ),
                  child: Icon(
                    Icons.list_alt, // Inventory icon
                    color: Colors.white, // Icon color
                    size: 40, // Icon size
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
