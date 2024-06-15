import 'User.dart';
import 'Organisation.dart';
import 'Donation.dart';
import 'Appointment.dart';
import 'Rating.dart';
import 'Financial.dart';

class Donor extends User {
  int rating;

  Donor(int id, String name, String phone, String email, String password, this.rating)
      : super(id, name, phone, email, password);

  void setRating(int rating) { /*...*/ }
  int getRating() { /*...*/ return rating; }
  List<Organisation> getOrganisations() { /*...*/ return []; }
  void donate(Donation donation) { /*...*/ }
  void requestAppointment(Appointment appointment) { /*...*/ }
  void rateOrganisation(Rating rating) { /*...*/ }
  
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
