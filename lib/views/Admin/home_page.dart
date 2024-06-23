// home_page.dart
import 'package:donorlink/Models/User.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final User? user;
  
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Pending Reviewers'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/view_reviewers');
                },
                child: Text('View All'),
              ),
            ),
            ListTile(
              title: Text('System Stats'),
            ),
            ListTile(
              title: Text('System Reports'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/system_reports');
                },
                child: Text('View All'),
              ),
              subtitle: Container(
                height: 100,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
