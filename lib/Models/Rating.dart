import 'Interaction.dart';
import 'Organisation.dart';
import 'Donor.dart';

class Rating extends Interaction {
  int rating;
  String comment;

  Rating(int id, Organisation org, Donor donor, DateTime date, this.rating, this.comment)
      : super(id, org, donor, date);

  void setRating(int rating) { /*...*/ }
  void setComment(String comment) { /*...*/ }
  int getRating() { /*...*/ return rating; }
  String getComment() { /*...*/ return comment; }
}
