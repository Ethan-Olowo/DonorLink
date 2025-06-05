import 'package:donorlink/Database/database.dart';
import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Patient.dart';
import 'package:donorlink/Models/Hospital.dart';
import 'package:donorlink/Models/User.dart';
import 'package:donorlink/resources/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:donorlink/views/Admin/home_page.dart' as admin;
import 'package:donorlink/views/Patients/home_page.dart' as patient;
import 'package:donorlink/views/Hospitals/home_page.dart' as hospital;
import 'package:donorlink/views/Hospitals/organisation_account.dart';

class RetrieveUser extends LoadingScreen {
  final String userId;
  final BuildContext context;
  const RetrieveUser(this.userId, this.context, {super.key});

  @override
  final String message = 'logging in...';

  @override
  Future<void> await() async {
    Database db = Database();
    User user = await db.getUser(userId);

    if (user is Patient) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => patient.HomePage(
                  user: user,
                )),
      );
    } else if (user is Hospital) {
      Hospital org = user;
      Navigator.push(
        context,
        org.approval == 'approved'
            ? MaterialPageRoute(
                builder: (context) => hospital.HomePage(
                      user: user,
                    ))
            : MaterialPageRoute(
                builder: (context) => OrgAccount(
                      org: user,
                    )),
      );
    } else if (user is Admin) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => admin.HomePage(
                  user: user,
                )),
      );
    }
  }
}
