

import 'Organisation.dart';
import 'Donor.dart';

abstract class Interaction {
  String id;
  Organisation org;
  Donor donor;
  DateTime date=DateTime.now();

  Interaction(this.id, this.org, this.donor);

  @override
  String toString(){
    return 'Organisation: ${org.name} \nDonor: ${donor.name} \nDate: $date';
  }

  void setOrg(Organisation org) { /*...*/ }
  void setDonor(Donor donor) { /*...*/ }
  void setID(int id) { /*...*/ }
  void setDate(DateTime date) { 
    this.date=date; 
    }
  Organisation getOrg() { /*...*/ return org; }
  Donor getDonor() { /*...*/ return donor; }
  DateTime getDate() { /*...*/ return date; }
  String getID() { /*...*/ return id; }
}
