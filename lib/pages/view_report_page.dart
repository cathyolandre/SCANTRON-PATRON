// lib/pages/view_report_page.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewReportPage extends StatefulWidget {
  final List<String> transactions;

  const ViewReportPage({super.key, required this.transactions});

  @override
  _ViewReportPageState createState() => _ViewReportPageState();
}

class _ViewReportPageState extends State<ViewReportPage> {
  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  // Load transaction log from SharedPreferences
  Future<void> _loadTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.transactions.addAll(prefs.getStringList('transactions') ?? []);
    });
  }

  // Save the transactions list to SharedPreferences
  Future<void> _saveTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('transactions', widget.transactions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Log"),
      ),
      body: ListView.builder(
        itemCount: widget.transactions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.transactions[index]),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Save transactions when the page is disposed to persist data
    _saveTransactions();
    super.dispose();
  }
}
