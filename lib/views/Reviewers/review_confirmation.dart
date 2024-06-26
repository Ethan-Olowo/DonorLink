// review_confirmation.dart
import 'package:donorlink/Models/Review.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/views/Reviewers/home_page.dart';
import 'package:flutter/material.dart';

class ReviewConfirmation extends StatelessWidget {
  final Reviewer user;
  final Review rev;
  const ReviewConfirmation({super.key, required this.user, required this.rev});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.grey,
              child: Center(child: Text('Logo')),
            ),
            const SizedBox(height: 20),
            Text(rev.toString()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user,)));
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
