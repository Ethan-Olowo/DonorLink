// view_donation.dart
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Organisation.dart';

import 'package:flutter/material.dart';

class ViewAppointment extends StatefulWidget {
  final Organisation user;
  final Appointment app;
  const ViewAppointment({super.key, required this.user, required this.app});
@override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewAppointment> {  

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [ 
          Text(widget.app.toString()),

          if(widget.app.approvalStatus==false) ElevatedButton(
              onPressed: () async {
                widget.app.approvalStatus = true;
                await widget.app.updateInteraction()? setState(() {
                  widget.app.approvalStatus = true;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment Approved')));
                }) 
                :ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to Save Changes')));

                
              },
              child: const Text('Confirm'),
            ),
            if(widget.app.approvalStatus==false) ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ignore'),
            ),
        ]
        ),),
    );
  }
}
