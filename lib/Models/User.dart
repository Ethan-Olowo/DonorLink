
import 'Donation.dart';
import 'Financial.dart';

abstract class User {
  final String? id;
  String? name;
  String? phone;
  String? email;


  User(this.id, this.name, this.phone, this.email,);

  @override
  String toString(){
    return "Name: $name \nPhone number: $phone \nEmail Address: $email";
  }

  List<Donation> getDonations();
  List<Financial> getFinancials();
  Map<String, dynamic> toFirestore();

  
}
