import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:flutter/material.dart';

class FinancialDocument extends StatelessWidget {
  final Admin user;
  final Financial fin;
  const FinancialDocument({super.key, required this.user, required this.fin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Bar(),
        body: Column(children: [
          Text('Financial Document from ${fin.org.name}',
              style: Theme.of(context).textTheme.headlineSmall),
          Center(
            //Replace with financial Document according to file location from Firebase cloud scorage
            child: null,
          ),
        ]));
  }
}
