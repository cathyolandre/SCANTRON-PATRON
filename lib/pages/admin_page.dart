// lib/pages/admin_page.dart

import 'package:flutter/material.dart';
import 'inventory_page.dart'; // Import the InventoryPage
import 'view_report_page.dart'; // Import the ViewReportPage
import '../models/inventory.dart'; // Ensure to import the Inventory model
import 'notice_page.dart'; // Import the NoticePage
import 'hello_page.dart'; // Import the HelloPage

class AdminPage extends StatelessWidget {
  final Inventory inventory; // Add the inventory parameter
  final List<String> transactions; // Add transactions parameter

  const AdminPage({super.key, required this.inventory, required this.transactions}); // Include inventory and transactions in the constructor

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check the paper limit here
        if (inventory.paperLimit <= 30) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NoticePage(
                currentPaperCount: inventory.paperLimit,
                transactions: transactions,
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
                        builder: (context) => ViewReportPage(transactions: transactions), // Pass transactions
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
                    // Navigator.push(...); // Example for navigation to another page
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
                  onPressed: () {
                    // Navigate to the InventoryPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InventoryPage(inventory: inventory, transactions: transactions), // Pass inventory and transactions
                      ),
                    );
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
