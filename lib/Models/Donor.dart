import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donorlink/Database/DonorController.dart';

import 'User.dart';
import 'Organisation.dart';
import 'Donation.dart';
import 'Appointment.dart';
import 'Rating.dart';

class Donor extends User {
  int rating;
  @override
  var db = Donorcontroller();

  Donor({required String id, required String name, required String phone, required String email, required this.rating})
      : super(id, name, phone, email,);


  factory Donor.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
      return Donor(
        id: snapshot.id , name: data['name'], phone: data['phone'], email: data['email'], rating:data[ 'rating'],
      );
    }
  
  @override
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = super.toFirestore();
     map.addAll({ 
      "type": "donor",
      "rating": rating,
    });
    return map;
  }

  void setRating(int rating) {
    this.rating=rating;
  }
  int getRating() {
    return rating; 
  }

  Donation donate(Organisation org, int donationAmount, ){ 
    //prompt transaction via Mpesa
    Donation don = Donation('', org, this, '', false, donationAmount);
    db.addInteraction(don);
    return don;
   }
  Future<Appointment?> requestAppointment( Organisation org, DateTime appointmentDate, String reason) async {
    Appointment app = Appointment('', org, this, null, false, reason, appointmentDate);
    if( await db.addInteraction(app)){
      return app;
    }else{
      return null;
    }
  }

  Future<Rating?> rateOrganisation(Organisation org, double score, String comment) async { 
    Rating rating = Rating('',org, this, score, comment );
    if(await db.addRating(rating)){
      return rating;
    }else{
      return null;
    }
    
   }
  

@override
  String toString(){
  return "Donor ${super.toString()}\nRating: $rating";
}

  Future<List<Donation>> getDonations() async {
    return await db.getDonations(id);
  }

  Future<List<Appointment>> getAppointments() async {
    return await db.getAppointments(id);
  }
  
}
