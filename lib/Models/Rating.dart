import 'package:cloud_firestore/cloud_firestore.dart';
import 'Interaction.dart';


class Rating extends Interaction {
  double rating;
  String comment;

  Rating(super.id, super.org, super.donor, this.rating, this.comment);

  factory Rating.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
    Rating don = Rating(snapshot.id, data['org'], data['donor'], data['rating'], data['comment']);
    don.setDate(data['date']);
    return don;
  }  

  void setRating(double rating) { /*...*/ }
  void setComment(String comment) { /*...*/ }
  double getRating() { /*...*/ return rating; }
  String getComment() { /*...*/ return comment; }

  @override
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = super.toFirestore();
    map.addAll({ 
      "type": "rating",
      "rating": rating,
      "comment": comment,
    });
    return map;
  }

  @override
  String toString(){
    return "${super.toString()} \nRating: $rating\nComment: $comment";
  }
}
