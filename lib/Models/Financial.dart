import 'package:cloud_firestore/cloud_firestore.dart';

import 'Organisation.dart';


class Financial {
  String location;
  Organisation org;
  String id;
  DateTime date;

  Financial(this.id, this.org, this.date, this.location);

  factory Financial.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
      return Financial(snapshot.id, data['org'], data['date'], data['location']);
  }
  void setLocation(String location) { /*...*/ }
  String getLocation() { /*...*/ return location; }
  void setDate(DateTime date) { /*...*/ }
  String getID() { /*...*/ return id; }
  Organisation getOrganisation() { /*...*/ return org; }
}
