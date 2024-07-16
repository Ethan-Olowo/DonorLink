import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/resources/loading_screen.dart';
import 'package:donorlink/views/Admin/home_page.dart';
import 'package:flutter/material.dart';

class ApprovalProcessing extends LoadingScreen {
  final Admin admin;
  final Reviewer user;
  final BuildContext context;

  ApprovalProcessing(this.admin, this.user, this.context, {super.key});

  @override
  final String message = 'Processing Approval';

  @override
  Future<void> await() async {
    var result = await admin.approveReviewer(user);
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reviewer Approved')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: admin),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Approval Failed')),
      );
      Navigator.of(context).pop();
    }
  }
}
