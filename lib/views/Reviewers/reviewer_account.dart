// reviewer_account.dart
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/views/Reviewers/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewerAccount extends StatelessWidget {
  final Reviewer reviewer;

  const ReviewerAccount({super.key, required this.reviewer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviewer Account'),
        leading: reviewer.approval == 'approved'? IconButton( onPressed: () { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: reviewer,)));
         }, icon: const Icon(Icons.home),) :null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center( child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
              
            ),
            const SizedBox(height: 20),
            Text(reviewer.toString()),
            const SizedBox(height: 20),

            if (reviewer.approval == 'requested') ElevatedButton(
              onPressed: () {},
              child: const Text('Cancel Request'),
            ), 
            if (reviewer.approval == 'pending') ElevatedButton(
              onPressed: () {},
              child: const Text('Request Approval'),
            ),
            if (reviewer.approval == 'approved'|| reviewer.approval == 'pending') ElevatedButton(
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
    ));
  }
}
