// financial_document.dart
import 'package:flutter/material.dart';

class FinancialDocument extends StatelessWidget {
  const FinancialDocument({super.key});

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
