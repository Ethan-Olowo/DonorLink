// donation_receipt.dart
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/views/Donors/home_page.dart';
import 'package:flutter/material.dart';

class DonationReceipt extends StatelessWidget {
  final Donor user;
  final Donation don;
  const DonationReceipt({super.key, required this.user, required this.don});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 100,),
              Text('Donation Successful', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Text(don.toString()),
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
