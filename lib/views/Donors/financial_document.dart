// financial_document.dart
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Financial.dart';
import 'package:flutter/material.dart';

class FinancialDocument extends StatelessWidget {
  final Donor user;
  final Financial fin;
  const FinancialDocument({super.key, required this.user, required this.fin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
      ),
      body: Column(children:[
        Text('Financial Document from ${fin.org.name}', style: Theme.of(context).textTheme.headlineSmall),
        Center(
        //Replace with financial Document according to file location from Firebase cloud scorage
        child: null,
      ),])
    );
  }
}
