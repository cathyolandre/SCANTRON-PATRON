// lib/pages/view_report_page.dart

import 'package:flutter/material.dart';

class ViewReportPage extends StatelessWidget {
  final List<String> transactions;

  const ViewReportPage({super.key, required this.transactions});

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
            title: Text(transactions[index]),
          );
        },
      ),
    );
  }
}
