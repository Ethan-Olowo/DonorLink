import 'User.dart';
import 'Organisation.dart';
import 'Rating.dart';
import 'Review.dart';
import 'Donation.dart';
import 'Financial.dart';

class Reviewer extends User {
  bool approval;

  Reviewer(int id, String name, String phone, String email, String password, this.approval)
      : super(id, name, phone, email, password);

  void setApproval(bool approval) { /*...*/ }
  bool getApproval() { /*...*/ return approval; }
  void reviewOrganisation(Organisation org) { /*...*/ }
  List<Organisation> getOrganisations() { /*...*/ return []; }
  List<Rating> getRatings() { /*...*/ return []; }
  List<Review> getReviews() { /*...*/ return []; }
  
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
}
