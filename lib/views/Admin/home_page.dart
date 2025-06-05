// home_page.dart
import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/User.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:donorlink/views/Admin/admin_account.dart';
import 'package:donorlink/views/Admin/view_financials.dart';
import 'package:donorlink/views/Admin/view_interactions.dart';
import 'package:donorlink/views/Admin/view_user.dart';
import 'package:donorlink/views/Admin/view_users.dart';
import 'package:donorlink/resources/report_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Admin user;

  const HomePage({super.key, required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> _reviewersFuture;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _reviewersFuture = widget.user.getHospitals();
  }

  Future<void> _reloadReviewers() async {
    setState(() {
      _reviewersFuture = widget.user.getHospitals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminAccount(user: widget.user),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadReviewers,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Welcome ${widget.user.name}',
                  style: const TextStyle(fontSize: 24)),
              Text('Unapproved Reviewers',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Search Reviewers',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
              ),
              FutureBuilder<List<User>>(
                future: _reviewersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No Unapproved Reviewers.'));
                  }

                  List<User> reviewers = snapshot.data!;

                  reviewers = reviewers
                      .where((rev) => rev.name!
                          .toLowerCase()
                          .contains(_searchText.toLowerCase()))
                      .toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reviewers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${reviewers[index].name}'),
                          subtitle: Text(reviewers[index].info()),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewUser(
                                  user: reviewers[index],
                                  admin: widget.user,
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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewUsers(
                        user: widget.user,
                        type: 'reviewer',
                      ),
                    ),
                  );
                },
                child: const Text('View All Reviewers'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Users',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 20,
              ),
              Chart('Users'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewUsers(
                        user: widget.user,
                        type: 'organisation',
                      ),
                    ),
                  );
                },
                child: const Text('View Organisations'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewUsers(
                        user: widget.user,
                        type: 'donor',
                      ),
                    ),
                  );
                },
                child: const Text('View Donors'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Interactions',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 20,
              ),
              Chart('Interactions'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewInteractions(
                          user: widget.user,
                          type: 'donation',
                          admin: widget.user),
                    ),
                  );
                },
                child: const Text('View Donations'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewInteractions(
                        user: widget.user,
                        type: 'appointment',
                        admin: widget.user,
                      ),
                    ),
                  );
                },
                child: const Text('View Appointments'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewInteractions(
                          user: widget.user,
                          type: 'rating',
                          admin: widget.user),
                    ),
                  );
                },
                child: const Text('View Ratings'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Others',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 20,
              ),
              Chart('Others'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewFinancials(
                        user: widget.user,
                        org: null,
                      ),
                    ),
                  );
                },
                child: const Text('View Financials'),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<String>(
                future: widget.user.getStats(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No Stats Available.'));
                  }

                  return ListTile(
                    title: Text(
                      'System Stats Summary',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(snapshot.data!),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
