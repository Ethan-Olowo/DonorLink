// organisation_account.dart
import 'package:donorlink/Models/Organisation.dart';
import 'package:flutter/material.dart';

class OrganisationAccount extends StatelessWidget {
  final Organisation user;
  const OrganisationAccount({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organisation Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Organisation Name: Red Cross'),
                  Text('Email: redcross@gmail.com'),
                  Text('Phone: +254 765 657 565'),
                  Text('Location: Nairobi'),
                  Text('Approval: Pending'),
                  Text('MPESA: 0798 876 907'),
                  Text('Payment Method: Send Money'),
                  Text('Image: example.png'),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Edit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
