// view_donation.dart
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:flutter/material.dart';

class ViewDonation extends StatelessWidget {
  final Reviewer user;
  final Donation don;
  const ViewDonation({super.key, required this.user, required this.don});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Donation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child:  Text(don.toString())),),
    );
  }
}
