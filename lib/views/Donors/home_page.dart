import 'package:donorlink/Controllers/Database.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/User.dart';
import 'package:donorlink/views/Donors/donor_account.dart';
import 'package:donorlink/views/Donors/view_appointments.dart';
import 'package:donorlink/views/Donors/view_donations.dart';
import 'package:donorlink/views/Donors/view_organisation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User? user;

  const HomePage({super.key, required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database db = Database();
  late Future<List<Organisation>> _organisationsFuture;

  @override
  void initState() {
    super.initState();
    _organisationsFuture = db.getOrganisations(); 
  }

  @override
  Widget build(BuildContext context) {
    String? name = widget.user?.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DonorLink'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DonorAccount(user: widget.user)));    
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome $name', style: const TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDonations()));
                  },
                  child: const Text('Donations'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAppointments()));
                  },
                  child: const Text('Appointments'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Search Organisations',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Organisation>>(
                future: _organisationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No organisations found.'));
                  }

                  List<Organisation> organisations = snapshot.data!;

                  return ListView.builder(
                    itemCount: organisations.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${organisations[index].name}'),
                          subtitle: Text(
                              'Charity type: ${organisations[index].type}\nRating: ${organisations[index].rating}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewOrganisation(org: organisations[index], user: widget.user!,),),
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
