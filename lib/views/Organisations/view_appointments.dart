// view_appointments.dart
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Organisations/view_appointment.dart';
import 'package:flutter/material.dart';

class ViewAppointments extends StatefulWidget {
  final Organisation user;
  final bool all;
  const ViewAppointments({super.key, required this.user, required this.all,});

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
  Future<void> _reloadAppointments() async {
    setState(() {
      _appointmentsFuture = widget.user.getAppointments();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.all ?const Text('View Appointments'):const Text('Pending View Appointments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadAppointments,
          ),
        ],
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
                  widget.all ? apps = apps : apps = apps.where((app) => app.approvalStatus==false).toList();
                  apps = apps.where((app) =>
                  app.donor.name!.toLowerCase().contains(_searchText.toLowerCase())).toList();

                  if(apps.isEmpty){
                    return const Center(child: Text('No Appointments found.'));
                  }

                  return ListView.builder(
                    itemCount: apps.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${apps[index].donor.name}'),
                          subtitle: Text(
                              'Appointment Date: ${apps[index].getDate()}\nApproval: ${apps[index].approvalStatus}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewAppointment(user: widget.user, app: apps[index],),),
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
