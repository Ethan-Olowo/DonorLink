import 'package:cloud_firestore/cloud_firestore.dart';

import 'Interaction.dart';
import 'Organisation.dart';
import 'Donor.dart';

class Rating extends Interaction {
  int rating;
  String comment;

  Rating(super.id, super.org, super.donor, this.rating, this.comment);

  factory Rating.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
    Rating don = Rating(snapshot.id, data['org'], data['donor'], data['rating'], data['comment']);
    don.setDate(data['date']);
    return don;
  }  

  void setRating(int rating) { /*...*/ }
  void setComment(String comment) { /*...*/ }
  int getRating() { /*...*/ return rating; }
  String getComment() { /*...*/ return comment; }
}
