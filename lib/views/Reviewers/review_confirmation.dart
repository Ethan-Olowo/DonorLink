// review_confirmation.dart
import 'package:flutter/material.dart';

class ReviewConfirmation extends StatelessWidget {
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
            SizedBox(height: 20),
            Text('Review Confirmation'),
            SizedBox(height: 20),
            Text('Review Details'),
            Text('Organisation: Red Cross'),
            Text('Approval: Approve'),
            Text('Comment: Correct Accounting'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
