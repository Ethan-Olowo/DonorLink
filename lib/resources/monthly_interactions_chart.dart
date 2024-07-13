import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Rating.dart';
import 'package:donorlink/resources/chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:string_capitalize/string_capitalize.dart';

class MonthlyInteractionsChart extends StatefulWidget {
  final Organisation org;
  final String type;
  const MonthlyInteractionsChart(
      {super.key, required this.org, required this.type});

  @override
  _MonthlyInteractionsChartState createState() =>
      _MonthlyInteractionsChartState();
}

class _MonthlyInteractionsChartState extends State<MonthlyInteractionsChart> {
  Map<String, double> getMonthlyRatings(List interactions) {
    Map<String, double> monthlyInteractions = {};
    Map<String, int> counts = {};
    for (Interaction inter in interactions) {
      String month = DateFormat('MMM yyyy').format(inter.date);
      if (!monthlyInteractions.containsKey(month)) {
        monthlyInteractions[month] = 0;
        counts[month] = 0;
      }
      monthlyInteractions[month] =
          monthlyInteractions[month]! + (inter as Rating).rating;
      counts[month] = counts[month]! + 1;
    }
    for (String month in monthlyInteractions.keys) {
      monthlyInteractions[month] =
          (monthlyInteractions[month]! / counts[month]!);
    }
    return monthlyInteractions;
  }

  Map<String, double> getMonthlyDonations(List interactions) {
    Map<String, double> monthlyInteractions = {};
    for (Interaction inter in interactions) {
      String month = DateFormat('MMM yyyy').format(inter.date);
      if (!monthlyInteractions.containsKey(month)) {
        monthlyInteractions[month] = 0;
      }
      monthlyInteractions[month] =
          monthlyInteractions[month]! + (inter as Donation).donationAmount;
    }
    return monthlyInteractions;
  }

  Map<String, double> getMonthlyAppointments(List interactions) {
    Map<String, double> monthlyInteractions = {};
    Map<String, int> counts = {};
    for (Interaction inter in interactions) {
      String month = DateFormat('MMM yyyy').format(inter.date);
      if (!monthlyInteractions.containsKey(month)) {
        monthlyInteractions[month] = 0;
        counts[month] = 0;
      }
      monthlyInteractions[month] = monthlyInteractions[month]! + 1;
    }
    return monthlyInteractions;
  }

  Future<Map<String, double>> fetchInteractionsByMonth() async {
    List<Interaction> interactions =
        await widget.org.getInteractions(widget.type);
    Map<String, double> monthlyInteractions = {};
    if (widget.type == 'donation')
      monthlyInteractions = getMonthlyDonations(interactions);
    if (widget.type == 'appointment')
      monthlyInteractions = getMonthlyDonations(interactions);
    if (widget.type == 'rating')
      monthlyInteractions = getMonthlyDonations(interactions);
    return monthlyInteractions;
  }

  @override
  Widget build(BuildContext context) {
    // Interactions bar chart by months
    return FutureBuilder<Map<String, double>>(
      future: fetchInteractionsByMonth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No ${widget.type.capitalize()} data available.');
        } else {
          Map<String, double> monthlyInteractions = snapshot.data!;
          return buildChart(monthlyInteractions, context);
        }
      },
    );
  }
}
