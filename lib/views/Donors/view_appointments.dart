// view_appointments.dart
import 'package:flutter/material.dart';

class ViewAppointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Appointments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Appointments',
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
                      subtitle: Text('Reason\nDate\nApproval Status'),
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
