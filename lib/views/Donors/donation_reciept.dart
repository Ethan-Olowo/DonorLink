// donation_receipt.dart
import 'package:donorlink/Models/User.dart';
import 'package:donorlink/views/Donors/home_page.dart';
import 'package:flutter/material.dart';

class DonationReceipt extends StatelessWidget {
  final User user;
  const DonationReceipt({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Receipt'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.grey,
                child: Center(child: Text('Logo')),
              ),
              SizedBox(height: 20),
              Text('Donation Successful', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Text('Donation Receipt'),
              Text('Organisation: Red Cross'),
              Text('Amount: KES 2,000'),
              Text('Transaction ID: ABC12345'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user,)));
                },
                child: Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
