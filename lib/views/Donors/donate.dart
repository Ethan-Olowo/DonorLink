import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Donors/view_interaction.dart';
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
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Donate To ${org.name}', style: Theme.of(context).textTheme.headlineSmall),
                  Text('Donation Method: ${org.paymentMethod}'),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an amount.'; // Return an error message if the amount is empty
                      }if (value is! int){
                        return 'Please enter a whole number amount'; // Return an error message if the amount is not
                      }
                      return null; 
                    },
                  ),
                  TextFormField(
                    controller: _paymentDetailsController,
                    decoration: const InputDecoration(labelText: 'Payment Details'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your payment details.'; // Return an error message if the payment details are empty
                      }
                      return null; 
                    },
                  ),
                ]
              )
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final donationAmount = _amountController.text as int;
                  final donorDetails = _paymentDetailsController.text;
                  
                  Donation don = user.donate(org, donationAmount, donorDetails);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InteractionView(user: user, element: don, New: true, type: 'Donations',)),
                  );
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
