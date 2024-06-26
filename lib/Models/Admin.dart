import 'package:cloud_firestore/cloud_firestore.dart';

import 'User.dart';
import 'Review.dart';
import 'Reviewer.dart';

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
  
  List<Review> getReviews() { /*...*/ return []; }
  List<Reviewer> getReviewers() { /*...*/ return []; }
  
  @override
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = super.toFirestore();
    map.addAll({"type": "admin",});
    return map;
  }
}
