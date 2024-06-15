// appointment_message.dart
import 'package:flutter/material.dart';

class AppointmentMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Message'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.grey,
                child: Center(child: Text('Logo')),
              ),
              SizedBox(height: 20),
              Text('Appointment Requested', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Text('Appointment Details'),
              Text('Organisation: Red Cross'),
              Text('Date: 11/11/2025'),
              Text('Reason: Visit'),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
