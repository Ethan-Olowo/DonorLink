import 'User.dart';
import 'Organisation.dart';
import 'Review.dart';
import 'Reviewer.dart';
import 'Donation.dart';
import 'Financial.dart';

class Admin extends User {
  Admin(int id, String name, String phone, String email, String password)
      : super(id, name, phone, email, password);

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
}
