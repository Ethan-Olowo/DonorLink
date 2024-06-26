// donor_account.dart
import 'package:donorlink/Models/Donor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonorAccount extends StatelessWidget {
  final Donor? user;
  const DonorAccount({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donor Account'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 20),
              Text(user.toString()),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Edit'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('Log Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
