import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:flutter/material.dart';

class ViewInteraction extends StatelessWidget {
  final Admin user;
  final Interaction inter;
  const ViewInteraction({super.key, required this.user, required this.inter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(children: [
          if (inter is Appointment) Text('Appointment'),
          Text(inter.toString())
        ])),
      ),
    );
  }
}
