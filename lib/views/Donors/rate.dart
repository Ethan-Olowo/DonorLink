// rate.dart
import 'package:donorlink/Models/Organisation.dart';
import 'package:flutter/material.dart';

class Rate extends StatelessWidget {
  final Organisation org;
  const Rate({super.key, required this.org});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Organisation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Rate ${org.name}', style: TextStyle(fontSize: 18)),
            
            const TextField(
              decoration: InputDecoration(labelText: 'Rate'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Comment'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/rating_confirmation');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
