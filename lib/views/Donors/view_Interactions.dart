// view_appointments.dart
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/views/Donors/view_interaction.dart';
import 'package:flutter/material.dart';

class ViewInteractions extends StatefulWidget {
  final Donor user;
  final String type;
  const ViewInteractions({super.key, required this.user, required this.type,});

    @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewInteractions> {
  String _searchText = "";
  late Future<List<Interaction>> _elementsFuture;

  @override
  void initState() {
    super.initState();
    widget.type=='Appointments'?_elementsFuture = widget.user.getAppointments()
    : _elementsFuture = widget.user.getDonations(); 
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
            Text('View ${widget.type}', style: Theme.of(context).textTheme.headlineSmall),
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
                    return Center(child: Text('No ${widget.type} found.'));
                  }

                  List<Interaction> elements = snapshot.data!;
                  elements = elements.where((app) =>
                  app.org.name!.toLowerCase().contains(_searchText.toLowerCase())).toList();

                  return ListView.builder(
                    itemCount: elements.length,
                    itemBuilder: (context, index) {
                      var element;
                      if(widget.type=='Donations'){
                        element = elements[index] as Donation; 
                      }else{
                        element = elements[index] as Appointment; 
                      }
                      return Card(
                        child: ListTile(
                          title: Text('${elements[index].org.name}'),
                          subtitle: element is Appointment ? 
                              Text('Appointment Date: ${element.getDate()}\nApproval: ${element.approvalStatus}')
                              :Text('Donation Date: ${element.date}\nAmount: ${element.donationAmount}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => InteractionView(user: widget.user, type: widget.type, element: element, New: false,),),
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
