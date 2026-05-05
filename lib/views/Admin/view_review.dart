import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Review.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:flutter/material.dart';

class ViewReview extends StatelessWidget {
  final Admin user;
  final Review rev;
  const ViewReview({super.key, required this.user, required this.rev});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child:
                Column(children: [const Text('Review'), Text(rev.toString())])),
      ),
    );
  }
}
