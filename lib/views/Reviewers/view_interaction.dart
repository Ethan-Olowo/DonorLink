// view_donation.dart
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/Models/Rating.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:flutter/material.dart';

class ViewInteraction extends StatelessWidget {
  final Reviewer user;
  final Interaction inter;
  const ViewInteraction({super.key, required this.user, required this.inter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: Column(children: [  
          if(inter is Donation)Text('Donation'),
          if(inter is Appointment)Text('Appointment'),
          if (inter is Rating) Text('Rating'),
          Text(inter.toString())])),),
    );
  }
}
