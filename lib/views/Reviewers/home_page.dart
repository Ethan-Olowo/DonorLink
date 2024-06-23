// home_page.dart
import 'package:donorlink/Models/Reviewer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Reviewer user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Pending Organisations'),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Search Organisations',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Organisation Name'),
                      subtitle: Text('Location\nCharity Type\nRating'),
                      onTap: () {
                        Navigator.pushNamed(context, '/view_organisation');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
