import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Donors/donor_account.dart';
import 'package:donorlink/views/Donors/view_Interactions.dart';
import 'package:donorlink/views/Donors/view_organisation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Donor user;

  const HomePage({super.key, required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Organisation>> _organisationsFuture;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _organisationsFuture = widget.user.getOrganisations();
  }

  Future<void> _reloadOrganisations() async {
    setState(() {
      _organisationsFuture = widget.user.getOrganisations();
    });
  }

  @override
  Widget build(BuildContext context) {
    String? name = widget.user.name;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DonorAccount(user: widget.user),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadOrganisations,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewInteractions(user: widget.user, type: 'Donations',),
                      ),
                    );
                  },
                  child: const Text('Donations'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewInteractions(user: widget.user, type: 'Appointments',),
                      ),
                    );
                  },
                  child: const Text('Appointments'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Organisations',
                prefixIcon: Icon(Icons.search),
              ),
              // Update _searchText on user input change
              onChanged: (text) { 
                setState(() {
                  _searchText = text;
                });
              },
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
                  organisations = organisations.where((org) =>
                  org.name!.toLowerCase().contains(_searchText.toLowerCase())).toList();

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
                              MaterialPageRoute(
                                builder: (context) => ViewOrganisation(
                                  org: organisations[index],
                                  user: widget.user,
                                ),
                              ),
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
