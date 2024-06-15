// donate.dart
import 'package:flutter/material.dart';

class Donate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'MPESA Number'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/donation_receipt');
              },
              child: Text('Donate'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
