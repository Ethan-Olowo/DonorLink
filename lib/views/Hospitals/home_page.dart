import 'package:donorlink/Models/Hospital.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:donorlink/views/Hospitals/organisation_account.dart';
import 'package:donorlink/views/Hospitals/view_interactions.dart';
import 'package:donorlink/views/Hospitals/view_financials.dart';
import 'package:donorlink/resources/monthly_interactions_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Hospital user;
  const HomePage({super.key, required this.user});

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
                builder: (context) => OrgAccount(org: user),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Welcome ${user.name}', style: const TextStyle(fontSize: 24)),
            Text('Appointments',
                style: Theme.of(context).textTheme.headlineSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewInteractions(
                          user: user,
                          all: false,
                          type: 'appointment',
                        ),
                      ),
                    );
                  },
                  child: const Text('View Pending'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewInteractions(
                          user: user,
                          all: true,
                          type: 'appointment',
                        ),
                      ),
                    );
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            Text('Financials',
                style: Theme.of(context).textTheme.headlineSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewFinancials(
                          user: user,
                          requests: true,
                        ),
                      ),
                    );
                  },
                  child: const Text('View Requests'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewFinancials(
                          user: user,
                          requests: false,
                        ),
                      ),
                    );
                  },
                  child: const Text('View Submitted'),
                ),
              ],
            ),
            Text('Donations', style: Theme.of(context).textTheme.headlineSmall),
            MonthlyInteractionsChart(org: user, type: 'donation'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewInteractions(
                      user: user,
                      all: true,
                      type: 'donation',
                    ),
                  ),
                );
              },
              child: const Text('View All'),
            ),
          ],
        ),
      ),
    );
  }
}
