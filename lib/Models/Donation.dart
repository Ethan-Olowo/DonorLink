import 'package:cloud_firestore/cloud_firestore.dart';

import 'Interaction.dart';
import 'Organisation.dart';
import 'Donor.dart';

class Donation extends Interaction {
  String transactionId;
  bool completionStatus;
  int donationAmount;

  Donation(super.id, super.org, super.donor, this.transactionId, this.completionStatus, this.donationAmount);

  factory Donation.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
    Donation don = Donation(snapshot.id, data['org'], data['donor'], data['transactionId'], data['completionStatus'], data['donationAmount']);
    don.setDate(data['date']);
    return don;
  }

  void initiateTransaction() { /*...*/ }
  void terminate() { /*...*/ }
  String getTransactionID() { /*...*/ return transactionId; }
  Map<String, dynamic> getTransactionInfo() { /*...*/ return {}; }
  bool getStatus() { /*...*/ return completionStatus; }
  int getAmount() { /*...*/ return donationAmount; }
  void setAmount(int amount) { /*...*/ }
}