import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/views/Reviewers/review.dart';
import 'package:donorlink/views/Reviewers/view_interactions.dart';
import 'package:donorlink/views/Reviewers/view_financials.dart';
import 'package:flutter/material.dart';

class ViewOrganisation extends StatelessWidget {
  final Reviewer user;
  final Organisation org;
  const ViewOrganisation({super.key, required this.user, required this.org});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
        //title: const Text('View Organisation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: Column(
          children: [
             Text(org.toString()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewInteractions(user: user, org: org, type: 'donation', )));
              },
              child: const Text('View Donations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewInteractions(user: user, org: org, type: 'appointment', )));
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
                                  org: org,
                                  type: 'rating',
                                )));
                  },
                  child: const Text('View ratings'),
                ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFinancials(user: user, org: org,)));
              },
              child: const Text('View Finances'),
            ),
            ElevatedButton(
              onPressed: () async {
                Financial fin = Financial('', org, '');
                await fin.upload()? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Financial Requested')))
                :ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unable to Create Request')));
              },
              child: const Text('Request Financial Document'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewOrg(user: user, org: org,)));
              },
              child: const Text('Review'),
            ),
          ],
        ),
      ),
    ));
  }
}
