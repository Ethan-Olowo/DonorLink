import 'package:donorlink/Database/Database.dart';
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';

class Donorcontroller extends Database {

  @override
  Future<List<Organisation>> getOrganisations() async {
    List<Organisation> orgs=[];
    await db.collection("Users").where("type", isEqualTo: 'organisation').where("approval", isEqualTo: 'approved').get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        orgs.add(Organisation.fromFirestore(docSnapshot,));    
      }
    },
    //onError: (e) => print("Error completing: $e"),
    
    );
    return orgs;
  }

  @override
  Future<List<Donation>> getDonations(String donid) async {
    List<Donation> donations=[];
    await db.collection("Interactions").where("type", isEqualTo: 'donation').where("donor", isEqualTo: donid).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          donations.add(Donation.fromFirestore(docSnapshot,));    
        }
      },
      //onError: (e) => print("Error completing: $e"),
      
    );
    return donations;
  }

  @override
  Future<List<Appointment>> getAppointments(String orgid) async {
    List<Appointment> donations=[];
    await db.collection("Interactions").where("type", isEqualTo: 'appointment').where("donor", isEqualTo: orgid).get().then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          final data = docSnapshot.data() as Map<String, dynamic>;
          Organisation org = await getUser(data['org']);
          Donor donor = await getUser(orgid);
          donations.add(Appointment.fromFirestore(docSnapshot, org, donor));    
        }
      },
      //onError: (e) => print("Error completing: $e"),
    );
    return donations;
  }

}