// view_appointments.dart
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:flutter/material.dart';

class ViewAppointments extends StatefulWidget {
  final Donor user;
  const ViewAppointments({super.key, required this.user,});

    @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewAppointments> {
  String _searchText = "";
  late Future<List<Appointment>> _appointmentsFuture;

  @override
  void initState() {
    super.initState();
    _appointmentsFuture = widget.user.getAppointments(); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Appointments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Appointments',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (text) { // Update _searchText on user input change
                setState(() {
                  _searchText = text;
                });
              },
            ),
                        Expanded(
              child: FutureBuilder<List<Appointment>>(
                future: _appointmentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Appointments found.'));
                  }

                  List<Appointment> apps = snapshot.data!;
                  apps = apps.where((app) =>
                  app.org.name!.toLowerCase().contains(_searchText.toLowerCase())).toList();

                  return ListView.builder(
                    itemCount: apps.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${apps[index].org.name}'),
                          subtitle: Text(
                              'Appointment Date: ${apps[index].getDate()}\nApproval: ${apps[index].approvalStatus}'),
                          onTap: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewAppointments(user: widget.user,),),
                            );*/
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
