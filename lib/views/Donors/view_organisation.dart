import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Donors/appointment.dart';
import 'package:donorlink/views/Donors/donate.dart';
import 'package:donorlink/views/Donors/rate.dart';
import 'package:donorlink/views/Donors/view_financials.dart';
import 'package:flutter/material.dart';

class ViewOrganisation extends StatelessWidget {
  final Organisation org;
  final Donor user;
  const ViewOrganisation({super.key, required this.org, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Organisation'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the column
            children: [
              Container(
                width: 100,
                height: 100,
                child: const Center(child: Image(image: AssetImage('assets/images/Logo.png'))),
              ),
              const SizedBox(height: 20),
              const Text('Organisation Details', style: TextStyle(fontSize: 18)),
              Text(org.toString()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFinancials(user: user, org: org,)));
                },
                child: const Text('View Finances'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentRequest(org: org, user: user,)));
                },
                child: const Text('Request Appointment'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Donate(org: org, user: user,)));
                },
                child: const Text('Donate'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Rate(org: org, user: user,)));
                },
                child: const Text('Rate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
