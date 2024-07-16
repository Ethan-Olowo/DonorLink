import 'package:donorlink/Database/database.dart';
import 'package:donorlink/resources/chart.dart';
import 'package:donorlink/resources/logo_loader.dart';
import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';

class Chart extends StatefulWidget {
  final String type;
  final Database db = Database();
  Chart(this.type, {Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Future<Map<String, int>> fetchData() async {
    return widget.db.getStats();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LogoLoader(height: 150);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No ${widget.type.capitalize()} data available.');
        } else {
          Map<String, int> stats = snapshot.data!;

          List useful = [];
          if (widget.type == 'Users') {
            useful = ['donor', 'organisation', 'reviewer', 'admin'];
          }
          if (widget.type == 'Interactions') {
            useful = ['donation', 'appointment', 'rating'];
          }
          if (widget.type == 'Others') {
            useful = [
              'review',
              'financial',
              'approval',
            ];
          }
          Map<String, int> filteredData = Map.fromEntries(
            stats.entries.where((entry) => useful.contains(entry.key)),
          );
          return buildChart(filteredData, context);
        }
      },
    );
  }
}
