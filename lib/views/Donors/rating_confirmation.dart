// rating_confirmation.dart
import 'package:flutter/material.dart';

class RatingConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rating Confirmation'),
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
              Text('Rating Details'),
              Text('Organisation: Red Cross'),
              Text('Rating: 4.5'),
              Text('Comment: Clean'),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
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
