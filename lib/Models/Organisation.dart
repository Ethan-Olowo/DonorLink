import 'User.dart';
import 'Financial.dart';
import 'Rating.dart';
import 'Appointment.dart';
import 'Donation.dart';

class Organisation extends User {
  String type;
  String location;
  int rating;
  int paymentMethod;
  String mpesa;
  String image;

  Organisation(int id, String name, String phone, String email, String password, this.type, this.location, this.rating, this.paymentMethod, this.mpesa, this.image)
      : super(id, name, phone, email, password);

  void setMpesa(String mpesa) { /*...*/ }
  void setImage(String image) { /*...*/ }
  void setPaymentMethod(int method) { /*...*/ }
  void setLocation(String location) { /*...*/ }
  void setType(String type) { /*...*/ }
  String getLocation() { /*...*/ return location; }
  String getType() { /*...*/ return type; }
  Financial submitFinancial(Financial financial) { /*...*/ return financial; }
  List<Rating> getRatings() { /*...*/ return []; }
  List<Appointment> getAppointments() { /*...*/ return []; }
  

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
