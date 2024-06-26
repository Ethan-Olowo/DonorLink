import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Reviewer.dart';



class Review {
  String reviewId;
  bool approval;
  DateTime date = DateTime.now();
  String comment;
  Reviewer reviewer;
  Organisation org;

  Review(this.reviewId, this.approval, this.comment, this.reviewer, this.org);

  factory Review.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
      var rev= Review(snapshot.id, data['approval'], data['comment'], data['reviewer'], data['org']);
      rev.date = data['date'];
      return rev;
  }

  Map<String, dynamic> toFirestore() {
    return {
      //id is autogenerated
      "org": org.id,
      "reviewer": reviewer.id,
      "date": date,
      "approval": approval,
      "comment": comment,

    };
  }

  void setApproval(bool approval) { /*...*/ }
  bool getApproval() { /*...*/ return approval; }
  void setComment(String comment) { /*...*/ }
  String getComment() { /*...*/ return comment; }
  Organisation getOrganisation() { /*...*/ return org; }
  DateTime getDate() { /*...*/ return date; }
  void setDate(DateTime date) { /*...*/ }
  Reviewer getReviewer() { /*...*/ return reviewer; }
  void setReviewer(Reviewer reviewer) { /*...*/ }

  @override
  String toString() {
    return 'Organisation: ${org.name}, approval: $approval, comment: $comment';
  }
}
