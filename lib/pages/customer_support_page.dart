// lib/pages/customer_support_page.dart

import 'package:flutter/material.dart';
import 'admin_page.dart'; // Import the AdminPage
import '../models/inventory.dart'; // Import the Inventory model

class CustomerSupportPage extends StatelessWidget {
  final Inventory inventory; // Add inventory parameter
  final List<String> transactions; // Add transactions parameter

  const CustomerSupportPage({super.key, required this.inventory, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Support"),
      ),
      body: Center(
        child: Text(
          "Contact us at support@example.com",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showLoginDialog(context); // Show login dialog when the FAB is pressed
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
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
                      builder: (context) => AdminPage(
                        inventory: inventory, // Pass the inventory
                        transactions: transactions, // Pass the transactions
                      ),
                    ),
                  ); // Navigate to AdminPage
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
