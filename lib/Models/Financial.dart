import 'Organisation.dart';


class Financial {
  String location;
  Organisation org;
  int id;
  DateTime date;

  Financial(this.id, this.org, this.date, this.location);

  void setLocation(String location) { /*...*/ }
  String getLocation() { /*...*/ return location; }
  void setDate(DateTime date) { /*...*/ }
  int getID() { /*...*/ return id; }
  Organisation getOrganisation() { /*...*/ return org; }
}
