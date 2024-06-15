import 'Organisation.dart';
import 'Donor.dart';

abstract class Interaction {
  int id;
  Organisation org;
  Donor donor;
  DateTime date;

  Interaction(this.id, this.org, this.donor, this.date);

  void setOrg(Organisation org) { /*...*/ }
  void setDonor(Donor donor) { /*...*/ }
  void setID(int id) { /*...*/ }
  Organisation getOrg() { /*...*/ return org; }
  Donor getDonor() { /*...*/ return donor; }
  DateTime getDate() { /*...*/ return date; }
  int getID() { /*...*/ return id; }
}
