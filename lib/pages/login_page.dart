// lib/pages/login_page.dart

import 'package:appdev/models/inventory.dart';
import 'package:flutter/material.dart';
import 'admin_page.dart'; // Import AdminPage

class LoginPage extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Enter Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Hide the password input
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (passwordController.text == 'your_password') { // Replace 'your_password' with the actual password
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminPage(inventory: Inventory(200), transactions: []), // Pass necessary parameters
                      ),
                    );
                  } else {
                    // Show an error message
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Login Failed"),
                          content: Text("Incorrect password. Please try again."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
