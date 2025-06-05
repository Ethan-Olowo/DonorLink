import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'User.dart';
import 'Financial.dart';

class Hospital extends User {
  String? location;
  double rating;
  int ratings;
  String approval;
  String? image;
  DateTime? approvalDate;

  Hospital(
      super.id,
      super.name,
      super.phone,
      super.email,
      this.location,
      this.rating,
      this.approval,
      this.image,
      this.ratings);

  factory Hospital.fromFirestore(
    DocumentSnapshot snapshot,
  ) {
    final data = snapshot.data() as Map<String, dynamic>;
    Hospital org = Hospital(
        snapshot.id,
        data['name'],
        data['phone'],
        data['email'],
        data['location'],
        data['rating'].toDouble(),
        data['approval'],
        data['image'],
        data['ratings']);
    if (data['approvalDate'] != null) {
      org.approvalDate = data['approvalDate'].toDate();
    }

    return org;
  }

  @override
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = super.toFirestore();
    map.addAll({
      "type": "organisation",
      "rating": rating,
      if (location != null) "location": location,
      "approval": approval,
      if (image != null) "image": image,
      'ratings': ratings,
      if (approvalDate != null) "approvalDate": approvalDate
    });
    return map;
  }

  void setPaymentDetails(String paymentDetails) {/*...*/}
  void setImage(String image) {/*...*/}
  void setPaymentMethod(int method) {/*...*/}
  void setLocation(String location) {/*...*/}
  void setType(String type) {/*...*/}
  String? getLocation() {
    /*...*/ return location;
  }

  Financial submitFinancial(Financial financial) {
    /*...*/ return financial;
  }

  @override
  String toString() {
    return 'Organisation ${super.toString()} \nLocation: $location \nRating: $rating';
  }

  @override
  String info() {
    return ' \nRating: $rating';
  }

  @override
  Future<List<Interaction>> getInteractions(String type) async {
    return await db.getInteractions(this, type);
  }

  Future<List<Financial>> getFinancials() async {
    return await db.getFinancials(this);
  }

  int? remainingDays() {
    DateTime now = DateTime.now();
    int? days = now.difference(approvalDate!).inDays;
    return days + 30;
  }
}
