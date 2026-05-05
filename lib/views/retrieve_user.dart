import 'package:donorlink/Database/database.dart';
import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/Models/User.dart';
import 'package:donorlink/resources/loading_screen.dart';
import 'package:donorlink/views/Reviewers/reviewer_account.dart';
import 'package:flutter/material.dart';
import 'package:donorlink/views/Admin/home_page.dart' as admin;
import 'package:donorlink/views/Donors/home_page.dart' as donor;
import 'package:donorlink/views/Organisations/home_page.dart' as organisation;
import 'package:donorlink/views/Organisations/organisation_account.dart';
import 'package:donorlink/views/Reviewers/home_page.dart' as reviewer;

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

    if (user is Donor) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => donor.HomePage(
                  user: user,
                )),
      );
    } else if (user is Organisation) {
      Organisation org = user;
      Navigator.push(
        context,
        org.approval == 'approved'
            ? MaterialPageRoute(
                builder: (context) => organisation.HomePage(
                      user: user,
                    ))
            : MaterialPageRoute(
                builder: (context) => OrgAccount(
                      org: user,
                    )),
      );
    } else if (user is Reviewer) {
      Reviewer us = user;
      Navigator.push(
        context,
        us.approval == 'approved'
            ? MaterialPageRoute(
                builder: (context) => reviewer.HomePage(
                      user: us,
                    ))
            : MaterialPageRoute(
                builder: (context) => ReviewerAccount(
                      reviewer: us,
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
