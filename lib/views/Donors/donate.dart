// donate.dart
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Donors/donation_reciept.dart';
import 'package:flutter/material.dart';

class Donate extends StatelessWidget {
  final Organisation org;
  final Donor user;
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
            Form(child: Column(
              children: [TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an Amount.'; // Return an error message if the name is empty
                  }
                  return null; 
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'MPESA Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your MPESA phone Number.'; // Return an error message if the name is empty
                  }
                  return null; 
                },
              ),
              ]
            )
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
