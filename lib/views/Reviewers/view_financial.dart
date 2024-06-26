// financial_document.dart
import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:flutter/material.dart';

class FinancialDocument extends StatelessWidget {
  final Reviewer user;
  final Financial fin;
  const FinancialDocument({super.key, required this.user, required this.fin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Financial Document'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 500,
          color: Colors.grey,
          child: Center(child: Text('Financial Document')),
        ),
      ),
    );
  }
}
