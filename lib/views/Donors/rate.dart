// rate.dart
import 'package:flutter/material.dart';

class Rate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Organisation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Rate Organisation', style: TextStyle(fontSize: 18)),
            TextField(
              decoration: InputDecoration(labelText: 'Organisation Name'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star_border),
              ],
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Comment'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/rating_confirmation');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
