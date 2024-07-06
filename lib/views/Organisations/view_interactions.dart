import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Organisations/view_interaction.dart';
import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';

class ViewInteractions extends StatefulWidget {
  final Organisation user;
  final String type;
  final bool all;
  const ViewInteractions({super.key, required this.user, required this.type, required this.all,});

    @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewInteractions> {
  String _searchText = "";
  late Future<List<Interaction>> _elementsFuture;

  @override
  void initState() {
    super.initState();
     _elementsFuture = widget.user.getInteractions(widget.type); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('View ${widget.type.capitalize()}s', style: Theme.of(context).textTheme.headlineSmall),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (text) { // Update _searchText on user input change
                setState(() {
                  _searchText = text;
                });
              },
            ),
            Expanded(
              child: FutureBuilder<List<Interaction>>(
                future: _elementsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No ${widget.type.capitalize()} records found.'));
                  }

                  List<Interaction> elements = snapshot.data!;
                  widget.all ? elements = elements : elements = elements.where((element) => (element as Appointment).approvalStatus==false).toList();
                  elements = elements.where((app) =>
                  app.donor.name!.toLowerCase().contains(_searchText.toLowerCase())).toList();
                  

                  return ListView.builder(
                    itemCount: elements.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${elements[index].donor.name}'),
                          subtitle: widget.type == 'appointment' ?
                              Text('Appointment Date: ${elements[index].getDate()}\nApproval: ${(elements[index] as Appointment).approvalStatus}')
                              :Text('Donation Date: ${elements[index].getDate()}\nAmount: ${(elements[index] as Donation).donationAmount}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewInteraction(user: widget.user, type: widget.type, element: elements[index],),),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          
          ],
        ),
      ),
    );
  }
  
}
