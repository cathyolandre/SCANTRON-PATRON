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

            // Button to navigate to OrderPage with inventory
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderPage(inventory: inventory)), // Pass inventory
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
            SizedBox(height: 10), // Space between the two buttons
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminPage(inventory: inventory)), // Pass inventory
          );
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
