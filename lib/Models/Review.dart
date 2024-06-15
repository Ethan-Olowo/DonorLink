import 'Reviewer.dart';
import 'Organisation.dart';

class Review {
  int reviewId;
  bool approval;
  DateTime date;
  String comment;
  Reviewer reviewer;
  Organisation organisation;

  Review(this.reviewId, this.approval, this.date, this.comment, this.reviewer, this.organisation);

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
