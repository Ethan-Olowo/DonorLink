// reviewer_account.dart
import 'package:donorlink/Models/Reviewer.dart';
import 'package:flutter/material.dart';

class ReviewerAccount extends StatelessWidget {
  final Reviewer reviewer;

  const ReviewerAccount({super.key, required this.reviewer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviewer Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(reviewer.toString()),
            const SizedBox(height: 20),

            //Edit this to check if approval is pending 
            reviewer.approval
                ? ElevatedButton(
                    onPressed: () {},
                    child: const Text('Cancel Request'),
                  )
                : ElevatedButton(
                    onPressed: () {},
                    child: const Text('Request Approval'),
                  ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
