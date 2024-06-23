import 'package:cloud_firestore/cloud_firestore.dart';

import 'User.dart';
import 'Organisation.dart';
import 'Review.dart';
import 'Reviewer.dart';
import 'Donation.dart';
import 'Financial.dart';

class Admin extends User {
  Admin(String id, String name, String phone, String email,)
      : super(id, name, phone, email,);

  factory Admin.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
      return Admin(
        snapshot.id , data['name'], data['phone'], data['email'],
      );
    }

  void approveReviewer(Reviewer reviewer) { /*...*/ }
  List<Organisation> getOrganisations() { /*...*/ return []; }
  List<Review> getReviews() { /*...*/ return []; }
  List<Reviewer> getReviewers() { /*...*/ return []; }
  
    @override
  List<Donation> getDonations() {
    // TODO: implement getDonations
    throw UnimplementedError();
  }
  
  @override
  List<Financial> getFinancials() {
    // TODO: implement getFinancials
    throw UnimplementedError();
  }
  
  @override
  Map<String, dynamic> toFirestore() {
    // TODO: implement toFirestore
    throw UnimplementedError();
  }
}
