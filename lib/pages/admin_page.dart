// lib/pages/admin_page.dart

import 'package:flutter/material.dart';
import 'inventory_page.dart'; // Import the InventoryPage
import '../models/inventory.dart'; // Ensure to import the Inventory model

class AdminPage extends StatelessWidget {
  final Inventory inventory; // Add the inventory parameter

  const AdminPage({super.key, required this.inventory}); // Include inventory in the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to the Admin Page!",
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20), // Space between text and buttons

            // Button for viewing reports with an icon
            SizedBox(
              width: 100, // Set width for the button
              height: 100, // Set height for the button
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality for viewing reports
                  // Navigator.push(...); // Example for navigation to another page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
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
                  backgroundColor: Colors.green, // Button color
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
                    MaterialPageRoute(builder: (context) => InventoryPage(inventory: inventory)), // Pass inventory
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Button color
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
    );
  }
}
