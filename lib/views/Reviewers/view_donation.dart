// view_donation.dart
import 'package:flutter/material.dart';

class ViewDonation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Donation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            height: 200,
            width: 200,
            color: Colors.grey,
            child: Center(child: Text('Donation Details')),
          ),
        ),
      ),
    );
  }
}
