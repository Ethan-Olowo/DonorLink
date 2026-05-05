import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/Models/Review.dart';

import 'User.dart';
import 'Financial.dart';


class Organisation extends User {
  String? type;
  String? location;
  double rating;
  int ratings;
  String? paymentMethod;
  String? paymentDetails;
  String approval;
  String? image;
  DateTime? approvalDate;

  Organisation(super.id, super.name, super.phone, super.email, this.type, this.location, this.rating, this.paymentMethod, this.paymentDetails, this.approval, this.image, this.ratings);

  factory Organisation.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
      Organisation org = Organisation(
        snapshot.id, data['name'], data['phone'], data['email'], data['orgtype'], data['location'], data['rating'].toDouble(), data['paymentMethod'], data['paymentDetails'], data['approval'], data['image'], data['ratings']
      );
      if(data['approvalDate']!=null) org.approvalDate = data['approvalDate'].toDate();
      
      return org;
    }
  
  @override
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = super.toFirestore();
     map.addAll({ 
      "type": "organisation",
      "rating": rating,
      if (type != null) "orgtype": type,
      if (location != null) "location": location,
      if (paymentDetails != null) "paymentDetails": paymentDetails,
      if (paymentMethod != null) "paymentMethod": paymentMethod,
      "approval": approval,
      if (image != null) "image": image,
      'ratings': ratings,
      if (approvalDate != null) "approvalDate": approvalDate
    });
    return map;
  }

  void setPaymentDetails(String paymentDetails) { /*...*/ }
  void setImage(String image) { /*...*/ }
  void setPaymentMethod(int method) { /*...*/ }
  void setLocation(String location) { /*...*/ }
  void setType(String type) { /*...*/ }
  String? getLocation() { /*...*/ return location; }
  String? getType() { /*...*/ return type; }
  Financial submitFinancial(Financial financial) { /*...*/ return financial; }
  
  
  @override
  String toString(){
    return 'Organisation ${super.toString()} \nCharity Type: $type \nLocation: $location \nRating: $rating \nPayment Method: $paymentMethod \nPayment Details: $paymentDetails ';
  }

  @override
  String info(){
    return 'Charity type: $type \nRating: $rating';
  }

  @override
  Future<List<Interaction>> getInteractions(String type) async {
    return await db.getInteractions(this, type);
  }

  Future<List<Financial>> getFinancials()async{
    return await db.getFinancials(this);
  }

  Future<List<Review>> getReviews()async{
    return await db.getReviews(this);
  }

  int? remainingDays(){
    DateTime now = DateTime.now();
    int? days = now.difference(approvalDate!).inDays;
    return days + 30;
  }
  
}
