import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Patient.dart';
import 'package:donorlink/Models/Hospital.dart';
import 'package:donorlink/Models/User.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:donorlink/views/Admin/approval_processing.dart';
import 'package:donorlink/views/Admin/view_interactions.dart';
import 'package:flutter/material.dart';

class ViewUser extends StatefulWidget {
  final Admin admin;
  final User user;
  const ViewUser({super.key, required this.admin, required this.user});

  @override
  _ViewUserState createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(user.toString()),
              const SizedBox(height: 20),
              if (user is Hospital || user is Patient)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewInteractions(
                              user: user,
                              type: 'donation',
                              admin: widget.admin,
                            ),
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
                              user: user,
                              type: 'appointment',
                              admin: widget.admin,
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
                              user: user,
                              type: 'rating',
                              admin: widget.admin,
                            ),
                          ),
                        );
                      },
                      child: const Text('View Ratings'),
                    ),
                  ],
                ),
              if (user is Hospital && (user as Hospital).approval != 'approved')
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // route to loading page instead
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ApprovalProcessing(
                                widget.admin, user as Hospital, context),
                          ),
                        );
                      },
                      child: const Text('Approve'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Reject'),
                    ),
                  ],
                ),
              if (user is Hospital)
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('View Finances'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
