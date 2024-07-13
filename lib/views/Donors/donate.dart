import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Donors/donation_loading.dart';
import 'package:donorlink/resources/input_validators.dart';
import 'package:flutter/material.dart';

class Donate extends StatelessWidget {
  final Organisation org;
  final Donor user;
  Donate({super.key, required this.org, required this.user});

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _paymentDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(
          image: AssetImage('assets/images/NamedLogo.png'),
          height: 48,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(children: [
                  Text('Donate To ${org.name}',
                      style: Theme.of(context).textTheme.headlineSmall),
                  Text('Donation Method: ${org.paymentMethod}'),
                  TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                      validator: numberValidator),
                  TextFormField(
                      controller: _paymentDetailsController,
                      decoration:
                          const InputDecoration(labelText: 'Payment Details'),
                      validator: nullValidator),
                ])),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                if (_formKey.currentState!.validate()) {
                  final donationAmount = int.parse(_amountController.text);
                  final donorDetails = _paymentDetailsController.text;

                  Donation don = Donation(
                      '', org, user, '', false, donationAmount, donorDetails);
                      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DonationLoading(don, user, context)));
                }
              },
              child: const Text('Donate'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
