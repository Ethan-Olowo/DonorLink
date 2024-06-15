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
              width: 100,
              height: 100,
              color: Colors.grey,
              child: Center(child: Text('Logo')),
            ),
            SizedBox(height: 20),
            Text('Organisation Details', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/view_financials');
              },
              child: Text('View Finances'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/appointment');
              },
              child: Text('Request Appointment'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/donate');
              },
              child: Text('Donate'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/rate');
              },
              child: Text('Rate'),
            ),
          ],
        ),
      ),
    );
  }
}
