// donate.dart
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/User.dart';
import 'package:donorlink/views/Donors/donation_reciept.dart';
import 'package:flutter/material.dart';

class Donate extends StatelessWidget {
  final Organisation org;
  final User user;
  const Donate({super.key, required this.org, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate To ${org.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'MPESA Number'),
            ),
            ElevatedButton(
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DonationReceipt(user: user,)));     
              },
              child: const Text('Donate'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
