import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Rating.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:donorlink/views/Reviewers/view_interaction.dart';
import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';

class ViewInteractions extends StatefulWidget {
  final Reviewer user;
  final Organisation org;
  final String type;
  const ViewInteractions({
    super.key,
    required this.user,
    required this.org,
    required this.type,
  });

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewInteractions> {
  String _searchText = "";
  late Future<List<Interaction>> _elementsFuture;

  @override
  void initState() {
    super.initState();
    _elementsFuture = widget.org.getInteractions(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('View ${widget.type.capitalize()}s',
                style: Theme.of(context).textTheme.headlineSmall),
            TextField(
              decoration: InputDecoration(
                labelText: 'Search ${widget.type.capitalize()}',
                prefixIcon: const Icon(Icons.search),
              ),
              // Update _searchText on user input change
              onChanged: (text) {
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
                    return Center(
                        child: Text('No ${widget.type} records found.'));
                  }

                  List<Interaction> elements = snapshot.data!;
                  elements = elements
                      .where((element) => element
                          .getDate()
                          .toLowerCase()
                          .contains(_searchText.toLowerCase()))
                      .toList();

                  return ListView.builder(
                    itemCount: elements.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(elements[index].getDate()),
                          subtitle: widget.type == 'appointment'
                              ? Text(
                                  'Approval: ${(elements[index] as Appointment).approvalStatus}')
                              : widget.type == 'donation'
                                  ? Text(
                                      'Amount: ${(elements[index] as Donation).donationAmount}')
                                  : Text(
                                      'Rating: ${(elements[index] as Rating).rating}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewInteraction(
                                  user: widget.user,
                                  inter: elements[index],
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
