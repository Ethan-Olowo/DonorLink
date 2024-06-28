// home_page.dart
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/views/Organisations/organisation_account.dart';
import 'package:donorlink/views/Organisations/view_appointments.dart';
import 'package:donorlink/views/Organisations/view_donations.dart';
import 'package:donorlink/views/Organisations/view_financials.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  final Organisation user;
  const HomePage({super.key, required this.user});

  Future<Map<String, int>> fetchDonationsByMonth() async {
    List<Donation> donations = await user.getDonations();
    Map<String, int> monthlyDonations = {};
    for (Donation donation in donations) {
      String month = DateFormat('MMM yyyy').format(donation.date);
      if (!monthlyDonations.containsKey(month)) {
        monthlyDonations[month] = 0;
      }
      monthlyDonations[month] = monthlyDonations[month]! + donation.donationAmount;
    }
    return monthlyDonations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
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
            const Text('Appointments'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAppointments(user: user, all: false),
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
                        builder: (context) => ViewAppointments(user: user, all: true),
                      ),
                    );
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const Text('Financials'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewFinancials(user: user, requests: true, ),
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
                        builder: (context) => ViewFinancials(user: user, requests: false, ),
                      ),
                    );
                  },
                  child: const Text('View Submitted'),
                ),
              ],
            ),
            const Text('Donations'),
            // Donations bar chart by months
            FutureBuilder<Map<String, int>>(
              future: fetchDonationsByMonth(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No donations data available.');
                } else {
                  Map<String, int> monthlyDonations = snapshot.data!;
                  List<BarChartGroupData> barGroups = [];
                  int index = 0;
                  monthlyDonations.entries.forEach((entry) {
                    barGroups.add(
                      BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: entry.value.toDouble(),
                            color: Colors.blue,
                          ),
                        ],
                        showingTooltipIndicators: [0],
                      ),
                    );
                    index++;
                  });

                  return AspectRatio(
                    aspectRatio: 1.7,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: monthlyDonations.values.reduce((a, b) => a > b ? a : b).toDouble(),
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              String month = monthlyDonations.keys.elementAt(group.x.toInt());
                              return BarTooltipItem(
                                '$month\n',
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: rod.toY.toString(),
                                    style: const TextStyle(
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(value.toInt().toString(),
                                    style: const TextStyle(color: Colors.black));
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                String month = monthlyDonations.keys.elementAt(value.toInt());
                                return Text(month,
                                    style: const TextStyle(color: Colors.black));
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(
                            bottom: BorderSide(width: 1),
                            left: BorderSide(width: 1),
                          ),
                        ),
                        barGroups: barGroups,
                      ),
                    ),
                  );
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewDonations(user: user),
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
