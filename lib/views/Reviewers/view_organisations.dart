import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/views/Reviewers/home_page.dart';
import 'package:donorlink/views/Reviewers/view_organisation.dart';
import 'package:flutter/material.dart';

class ViewOrganisations extends StatefulWidget {
  final Reviewer user;
  const ViewOrganisations({super.key, required this.user});

    @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewOrganisations> {
  String _searchText = "";
   late Future<List<Organisation>> _organisationsFuture;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('DonorLink'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(user: widget.user),
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
