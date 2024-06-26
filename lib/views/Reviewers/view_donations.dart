import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/views/Reviewers/view_donation.dart';
import 'package:flutter/material.dart';

class ViewDonations extends StatefulWidget {
  final Reviewer user;
  final Organisation org;
  const ViewDonations({super.key, required this.user, required this.org,});

    @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewDonations> {
  String _searchText = "";
  late Future<List<Donation>> _donationsFuture;

  @override
  void initState() {
    super.initState();
    _donationsFuture = widget.org.getDonations(); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Donations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Donations',
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
              child: FutureBuilder<List<Donation>>(
                future: _donationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Donations found.'));
                  }

                  List<Donation> donations = snapshot.data!;
                  donations = donations.where((don) =>
                  don.getDate().toLowerCase().contains(_searchText.toLowerCase())).toList();

                  return ListView.builder(
                    itemCount: donations.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(donations[index].getDate()),
                          subtitle: Text(
                              'Donation Date: ${donations[index].date}\nAmount: ${donations[index].donationAmount}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewDonation(user: widget.user, don: donations[index]),),
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
