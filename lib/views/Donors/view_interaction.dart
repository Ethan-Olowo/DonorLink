import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/views/Donors/home_page.dart';
import 'package:flutter/material.dart';

class InteractionView extends StatelessWidget {
  final Donor user;
  final Interaction element;
  final bool New;
  final String type;
  const InteractionView({super.key, required this.user, required this.element, required this.New, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
        leading: New ?IconButton( onPressed: () { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user,)));
         }, icon: const Icon(Icons.home),): null
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 100,),
              const SizedBox(height: 20),              
              if(type=='Donations'&& New) Text('Donation Complete', style: Theme.of(context).textTheme.headlineSmall,),
              if(type=='Appointments'&& New) Text('Appointment Requested', style: Theme.of(context).textTheme.headlineSmall,),
              if(type=='Ratings'&& New) Text('Thanks for the Feedback', style: Theme.of(context).textTheme.headlineSmall,),
              if(type=='Donations'&& !New) Text('Donation', style: Theme.of(context).textTheme.headlineSmall,),
              if(type=='Appointments'&& !New) Text('Appointment', style: Theme.of(context).textTheme.headlineSmall,),
              const SizedBox(height: 20),
              Text(element.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
