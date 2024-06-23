// appointment.dart
import 'package:donorlink/Models/Organisation.dart';
import 'package:flutter/material.dart';

class Appointment extends StatelessWidget {
  final Organisation org;
  const Appointment({super.key, required this.org});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Appointment'),
      ),
      body: Center( 
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Appointment with ${org.name}'),
              const TextField(
                decoration: InputDecoration(labelText: 'Reason'),
              ),
              TextField(
                decoration: const InputDecoration(
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
                child: const Text('Request'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
        
      )
    );
  }
}
