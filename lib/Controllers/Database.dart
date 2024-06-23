import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/Models/User.dart';


// ignore_for_file: file_names

class Database {
  final db = FirebaseFirestore.instance;
  
  Future<dynamic> getUser(String id) async {
    final docRef = db.collection("Users").doc(id);
    dynamic user;
    user = await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        if(data['type']=='donor'){
          user = Donor.fromFirestore(doc,);
          return user;
        }else if(data['type']=='organisation'){
          user = Organisation.fromFirestore(doc);
          return user;
        }else if(data['type']=='reviewer'){
          user = Reviewer.fromFirestore(doc);
          return user;
        }else if(data['type']=='Admin'){
          user = Admin.fromFirestore(doc);
        }
      },
    );
    return user;
    
  }

  Future<Financial?> getFinancial(String org, String id) async {
    final docRef = db.collection("Users").doc(org).collection("Financial").doc(id);
    Financial? financial;
    financial = await docRef.get().then(
      (DocumentSnapshot doc) {
        return Financial.fromFirestore(doc);
      });
    return financial;
  }

  Future<List<Organisation>> getOrganisations() async {
    List<Organisation> orgs=[];
    await db.collection("Users").where("type", isEqualTo: 'organisation').get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        orgs.add(Organisation.fromFirestore(docSnapshot,));    
      }
    },
  );
  
  return orgs;
  }

  Future<List<Donation>> getDonations(String orgid) async {
    List<Donation> donations=[];
    await db.collection("Interactions").where("type", isEqualTo: 'donation').where("org", isEqualTo: orgid).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          donations.add(Donation.fromFirestore(docSnapshot,));    
        }
      },
    );
    return donations;
  }

  Future<List<Appointment>> getAppointments(String orgid) async {
    List<Appointment> appointments=[];
    await db.collection("Interactions").where("type", isEqualTo: 'appointment').where("org", isEqualTo: orgid).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          appointments.add(Appointment.fromFirestore(docSnapshot,));    
        }
      },
    );
    return appointments;
  }

  Future<List<Financial>> getFinancials(String orgid) async {
    List<Financial> financials=[];
    await db.collection("Users").doc(orgid).collection("Financials").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          financials.add(Financial.fromFirestore(docSnapshot,));    
        }
      },
    );
    return financials;
  }

  void addUser(User user, String type){
    db.collection("Users").doc(user.id).set(user.toFirestore());
  }
}
