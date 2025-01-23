import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Review.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:donorlink/views/Admin/view_review.dart';
import 'package:flutter/material.dart';

class ViewReviews extends StatefulWidget {
  final Admin admin;
  final Reviewer? user;
  const ViewReviews({
    super.key,
    required this.user,
    required this.admin,
  });

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewReviews> {
  String _searchText = "";
  late Future<List<Review>> _elementsFuture;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) _elementsFuture = widget.user!.getReviews();
    if (widget.user == null) _elementsFuture = widget.admin.getReviews(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('View Reviews'),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search Reviews',
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
              child: FutureBuilder<List<Review>>(
                future: _elementsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Reviews found.'));
                  }

                  List<Review> elements = snapshot.data!;
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
                          subtitle: Text(
                              '${elements[index]}\nReviewer: ${elements[index].reviewer.name}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewReview(
                                  user: widget.admin,
                                  rev: elements[index],
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
