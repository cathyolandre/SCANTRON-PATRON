// lib/pages/view_report_page.dart

import 'package:flutter/material.dart';

class ViewReportPage extends StatelessWidget {
  final List<String> transactions; // Accept the transactions list

  const ViewReportPage({super.key, required this.transactions}); // Constructor that takes transactions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Log"),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(transactions[index]), // Display each transaction
          );
        },
      ),
    );
  }
}
