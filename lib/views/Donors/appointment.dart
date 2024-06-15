// appointment.dart
import 'package:flutter/material.dart';

class Appointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Organisation Name'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Reason'),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Appointment Date',
                hintText: 'Select Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime date = DateTime(1900);
                FocusScope.of(context).requestFocus(new FocusNode());

                date = (await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100)))!;

                print(date.toString());
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/appointment_message');
              },
              child: Text('Request'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
