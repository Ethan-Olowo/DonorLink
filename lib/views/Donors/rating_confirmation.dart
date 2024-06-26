// rating_confirmation.dart
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Rating.dart';
import 'package:donorlink/views/Donors/home_page.dart';
import 'package:flutter/material.dart';

class RatingConfirmation extends StatelessWidget {
  final Donor user;
  final Rating rating;
  const RatingConfirmation({super.key, required this.user, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating Confirmation'),
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
              Text('Thanks for the Feedback', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Text(rating.toString()),
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
