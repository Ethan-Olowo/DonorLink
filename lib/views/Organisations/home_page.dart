import 'package:donorlink/Controllers/Database.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/User.dart';
import 'package:donorlink/views/Donors/view_organisation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User? user;

  HomePage({super.key, required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Database db = Database();
  late Future<List<Organisation>> _organisationsFuture;

  @override
  void initState() {
    super.initState();
    _organisationsFuture = db.getOrganisations(); // Ensure this method returns Future<List<Organisation>>
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
              Navigator.pushNamed(context, '/donor_account');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome $name', style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Donations'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Appointments'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
