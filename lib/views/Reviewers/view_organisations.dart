// view_organisation.dart
import 'package:flutter/material.dart';

class ViewOrganisation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Organisation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.grey,
              child: Center(child: Text('Organisation Details')),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/view_donations');
              },
              child: Text('View Donations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/view_financials');
              },
              child: Text('View Finances'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/review');
              },
              child: Text('Review'),
            ),
          ],
        ),
      ),
    );
  }
}
