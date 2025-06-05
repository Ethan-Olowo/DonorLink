import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Hospital.dart';
import 'package:donorlink/resources/loading_screen.dart';
import 'package:donorlink/views/Admin/home_page.dart';
import 'package:flutter/material.dart';

class ApprovalProcessing extends LoadingScreen {
  final Admin admin;
  final Hospital user;
  final BuildContext context;

  const ApprovalProcessing(this.admin, this.user, this.context, {super.key});

  @override
  final String message = 'Processing Approval';

  @override
  Future<void> await() async {
    var result = await admin.addHospital(user);
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hospital Added')),
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
