import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/User.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:donorlink/views/Admin/home_page.dart';
import 'package:donorlink/views/Admin/view_user.dart';
import 'package:flutter/material.dart';

class ViewUsers extends StatefulWidget {
  final Admin user;
  final String? type;
  const ViewUsers({super.key, required this.user, required this.type});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<ViewUsers> {
  final String _searchText = "";
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'organisation') {
      _usersFuture = widget.user.getHospitals();
    } else if (widget.type == 'reviewer') {
      _usersFuture = widget.user.getReviewers();
    } else if (widget.type == 'donor') {
      _usersFuture = widget.user.getHospitals();
    } else {
      _usersFuture = widget.user.getAllUsers();
    }
  }

  Future<void> _reloadOrganisations() async {
    setState(() {
      _usersFuture = widget.user.getHospitals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(
        leading: widget.type == null
            ? IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(user: widget.user),
                    ),
                  );
                },
              )
            : null,
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
                labelText: 'Search Users',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<User>>(
                future: _usersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No ${widget.type} found.'));
                  }

                  List<User> users = snapshot.data!;
                  users = users
                      .where((org) => org.name!
                          .toLowerCase()
                          .contains(_searchText.toLowerCase()))
                      .toList();

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${users[index].name}'),
                          subtitle: Text(users[index].info()),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewUser(
                                  user: users[index],
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
            ),
          ],
        ),
      ),
    );
  }
}
