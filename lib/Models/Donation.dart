import 'Interaction.dart';
import 'Organisation.dart';
import 'Donor.dart';

class Donation extends Interaction {
  int transactionId;
  bool completionStatus;
  int donationAmount;

  Donation(int id, Organisation org, Donor donor, DateTime date, this.transactionId, this.completionStatus, this.donationAmount)
      : super(id, org, donor, date);

  void initiateTransaction() { /*...*/ }
  void terminate() { /*...*/ }
  int getTransactionID() { /*...*/ return transactionId; }
  Map<String, dynamic> getTransactionInfo() { /*...*/ return {}; }
  bool getStatus() { /*...*/ return completionStatus; }
  int getAmount() { /*...*/ return donationAmount; }
  void setAmount(int amount) { /*...*/ }
}
