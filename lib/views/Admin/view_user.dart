import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/Models/User.dart';
import 'package:donorlink/views/Admin/view_interactions.dart';
import 'package:flutter/material.dart';

class ViewUser extends StatelessWidget {
  final Admin admin;
  final User user;
  const ViewUser({super.key, required this.admin, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: Column(
          children: [
            Text(user.toString()),
            const SizedBox(height: 20),
            if( user is Organisation|| user is Donor)Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewInteractions(user: user, type: 'donation', admin: admin, )));
                  },
                  child: const Text('View Donations'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewInteractions(user: user, type: 'appointment', admin: admin, )));
                  },
                  child: const Text('View Appointments'),
                ),
                
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewInteractions(user: user, type: 'rating', admin: admin, )));
                  },
                  child: const Text('View Ratings'),
                ),
              ],
            ),

            if(user is Reviewer||user is Organisation)ElevatedButton(
              onPressed: () {
              },
              child: const Text('View Reviews'),
            ),

            if(user is Reviewer)Column(children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  child: const Text('Approve'),
                ),
                ElevatedButton(
                  onPressed: () {
                  },
                  child: const Text('Reject'),
                ),
            ],),
            
            if(user is Organisation)ElevatedButton(
              onPressed: () {
              },
              child: const Text('View Finances'),
            ),
          ],
        ),
      ),
    ));
  }
}
