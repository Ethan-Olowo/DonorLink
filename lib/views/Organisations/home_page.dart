// home_page.dart
import 'package:donorlink/Models/Organisation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Organisation user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Appointments'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/pending_appointments');
                },
                child: Text('View All'),
              ),
            ),
            ListTile(
              title: Text('Donations'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/view_donations');
                },
                child: Text('View All'),
              ),
            ),
            ListTile(
              title: Text('Financials'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/view_financials');
                },
                child: Text('View All'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
