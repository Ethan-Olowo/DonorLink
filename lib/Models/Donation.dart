import 'package:cloud_firestore/cloud_firestore.dart';

import 'Interaction.dart';

class Donation extends Interaction {
  String paymentMethod;
  String transactionId;
  bool completionStatus;
  int donationAmount;

  Donation(super.id, super.org, super.donor, this.transactionId, this.completionStatus, this.donationAmount, this.paymentMethod);

  factory Donation.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
    Donation don = Donation(snapshot.id, data['org'], data['donor'], data['transactionId'], data['completionStatus'], data['donationAmount'], data['paymentMethod']);
    don.setDate(data['date'].toDate());
    return don;
  }

  void initiateTransaction() { /*...*/ }
  void terminate() { /*...*/ }
  String getTransactionID() { /*...*/ return transactionId; }
  Map<String, dynamic> getTransactionInfo() { /*...*/ return {}; }
  bool getStatus() { /*...*/ return completionStatus; }
  int getAmount() { /*...*/ return donationAmount; }
  void setAmount(int amount) { /*...*/ }
  
  @override
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = super.toFirestore();
    map.addAll({
      "type": "donation",
      "transactionId": transactionId,
      "completionStatus": completionStatus,
      "donationAmount": donationAmount,   
      "paymentMethod": paymentMethod
    });
    return map;
  }
  
  @override
  String toString(){
    return "${super.toString()} \ntransactionId: $transactionId \ndonationAmount: $donationAmount";
  }
 
}
