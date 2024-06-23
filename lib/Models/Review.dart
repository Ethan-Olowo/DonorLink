import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Reviewer.dart';



class Review {
  String reviewId;
  bool approval;
  DateTime date;
  String comment;
  Reviewer reviewer;
  Organisation organisation;

  Review(this.reviewId, this.approval, this.date, this.comment, this.reviewer, this.organisation);

  factory Review.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
      return Review(snapshot.id, data['approval'], data['date'], data['comment'], data['reviewer'], data['organisation']);
  }

  void setApproval(bool approval) { /*...*/ }
  bool getApproval() { /*...*/ return approval; }
  void setComment(String comment) { /*...*/ }
  String getComment() { /*...*/ return comment; }
  Organisation getOrganisation() { /*...*/ return organisation; }
  DateTime getDate() { /*...*/ return date; }
  void setDate(DateTime date) { /*...*/ }
  Reviewer getReviewer() { /*...*/ return reviewer; }
  void setReviewer(Reviewer reviewer) { /*...*/ }
}
