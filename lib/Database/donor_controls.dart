import 'package:donorlink/Database/database.dart';
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Patient.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/Models/Hospital.dart';
import 'package:donorlink/Models/Rating.dart';
import 'package:donorlink/Models/User.dart';

class DonorControls extends Database {
  @override
  Future<List<Hospital>> getOrganisations() async {
    List<Hospital> orgs = [];
    await db
        .collection("Users")
        .where("type", isEqualTo: 'organisation')
        .where("approval", isEqualTo: 'approved')
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          orgs.add(Hospital.fromFirestore(
            docSnapshot,
          ));
        }
      },
      //onError: (e) => print("Error completing: $e"),
    );
    return orgs;
  }

  @override
  Future<List<Interaction>> getInteractions(User user, String type) async {
    List<Interaction> inters = [];
    await db
        .collection("Interactions")
        .where("type", isEqualTo: type)
        .where("donor", isEqualTo: user.id)
        .get()
        .then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          final data = docSnapshot.data();
          Hospital org = await getUser(data['org']);
          if (type == 'donation') {
            inters
                .add(Donation.fromFirestore(docSnapshot, org, user as Patient));
          }
          if (type == 'appointment') {
            inters.add(
                Appointment.fromFirestore(docSnapshot, org, user as Patient));
          }
          if (type == 'rating') {
            inters.add(Rating.fromFirestore(docSnapshot, org, user as Patient));
          }
        }
      },
    );
    return inters;
  }
}
