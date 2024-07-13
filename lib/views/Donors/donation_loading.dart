import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/resources/loading_screen.dart';
import 'package:donorlink/views/Donors/view_interaction.dart';
import 'package:donorlink/views/Donors/view_organisation.dart';
import 'package:flutter/material.dart';

class DonationLoading extends LoadingScreen {
  final Donor user;
  final Donation don;
  final BuildContext context;
  DonationLoading(
    this.don,
    this.user,
    this.context, {
    super.key,
  });

  @override
  String message = 'Waiting for Donation response';
  @override
  Future<void> await() async {
    late Donation? donation;
    donation =
        await user.donate(don.org, don.donationAmount, don.paymentMethod);
    if (donation != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InteractionView(
                  user: user,
                  element: donation!,
                  New: true,
                  type: 'donation',
                )),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Donation Failed \nReturning to ${don.org.name} page')));
      await Future.delayed(Duration(seconds: 10));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ViewOrganisation(org: don.org, user: user)));
    }
  }
}
