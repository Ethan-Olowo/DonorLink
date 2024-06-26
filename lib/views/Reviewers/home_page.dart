// home_page.dart
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/views/Reviewers/reviewer_account.dart';
import 'package:donorlink/views/Reviewers/view_organisation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Reviewer user;
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
    _organisationsFuture = widget.user.getPendingOrganisations();
  }

  Future<void> _reloadOrganisations() async {
    setState(() {
      _organisationsFuture = widget.user.getPendingOrganisations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DonorLink'),
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewerAccount(reviewer: widget.user),
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
          children: [
            const Text('Pending Organisations'),
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
