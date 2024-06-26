import 'package:cloud_firestore/cloud_firestore.dart';

import 'User.dart';
import 'Organisation.dart';
import 'Review.dart';

class Reviewer extends User {
  String approval;

  Reviewer(super.id, super.name, super.phone, super.email, this.approval);

  factory Reviewer.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
      return Reviewer(
        snapshot.id, data['name'], data['phone'], data['email'], data['approval'],
      );
    }
  
  @override
  Map<String, dynamic> toFirestore() {
     Map<String, dynamic> map = super.toFirestore();
     map.addAll({ 
      "type": "reviewer",
      "approval": approval,
    });
    return map;
  }


  void setApproval(bool approval) { /*...*/ }
  String getApproval() { /*...*/ return approval; }

  Review reviewOrganisation(Organisation org, bool app, String comment) {
    var rev = Review('', app, comment, this, org);
    db.addReview(rev);
    return rev;
   }
  List<Review> getReviews() { /*...*/ return []; }
  
  @override
  String toString() {
    return '${super.toString()} \nApproval: $approval';
  }
}
