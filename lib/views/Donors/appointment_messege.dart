// appointment_message.dart
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/views/Donors/home_page.dart';
import 'package:flutter/material.dart';

class AppointmentMessage extends StatelessWidget {
  final Donor user;
  final Appointment app;
  const AppointmentMessage({super.key, required this.user, required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Message'),
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
              Text(app.toString()),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user,)));
                },
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
