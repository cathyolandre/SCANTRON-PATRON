// lib/pages/hello_page.dart

import 'package:flutter/material.dart';
import 'order_page.dart'; // Ensure you import the OrderPage
import 'admin_page.dart'; // Ensure you import the AdminPage
import '../models/inventory.dart'; // Import the Inventory model

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Inventory inventory = Inventory(200); // Define your paper limit here
    final List<String> transactions = []; // Initialize the transactions list

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SCANTRON PATRON",
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Space between text and rounded square
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            SizedBox(height: 20), // Space between the container and buttons

            // Button to navigate to OrderPage with inventory and transactions
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderPage(inventory: inventory, transactions: transactions)), // Pass inventory and transactions
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
              ),
              child: Text(
                "ORDER",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showLoginDialog(context, inventory, transactions); // Show login dialog instead of directly navigating
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }

  void _showLoginDialog(BuildContext context, Inventory inventory, List<String> transactions) {
    final TextEditingController passwordController = TextEditingController();
    const String correctPassword = "1234"; // Set your desired password here

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Admin Login"),
          content: TextField(
            controller: passwordController,
            decoration: InputDecoration(hintText: "Enter password"),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (passwordController.text == correctPassword) {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminPage(inventory: inventory, transactions: transactions), // Navigate to AdminPage
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Incorrect password")),
                  );
                }
              },
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
