// view_financial.dart
import 'package:flutter/material.dart';

class ViewFinancial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Financial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            height: 200,
            width: 200,
            color: Colors.grey,
            child: Center(child: Text('Financial Document')),
          ),
        ),
      ),
    );
  }
}
