import 'package:donorlink/Controllers/Database.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Review.dart';
import 'package:donorlink/Models/Reviewer.dart';

class Admincontroller extends Database {

  Future<List<dynamic>> getUsers(String type) async {
    List<dynamic> users=[];
    await db.collection("Users").where("type", isEqualTo: type).get().then(
    (querySnapshot) {
      //print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        final data = docSnapshot.data();
        switch(data['type']){
          case 'donor':
            users.add(Donor.fromFirestore(docSnapshot,));
            break;
          case 'organisation':
            users.add(Organisation.fromFirestore(docSnapshot,));
            break;
          case 'reviewer':
            users.add(Reviewer.fromFirestore(docSnapshot,));
            break;
        }
        //print('${docSnapshot.id} => ${docSnapshot.data()}');
      }
    },
    //onError: (e) => print("Error completing: $e"),
    
  );
  return users;
  }

  @override
  Future<List<Organisation>> getOrganisations() async {
    List<Organisation> orgs=[];
    await db.collection("Users").where("type", isEqualTo: 'organisation').get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        orgs.add(Organisation.fromFirestore(docSnapshot,));    
      }
    },
    //onError: (e) => print("Error completing: $e"),
    
  );
  
  return orgs;
  }

  Future<List<Review>> getReviews() async {
    List<Review> donations=[];
    await db.collection("Reviews").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          donations.add(Review.fromFirestore(docSnapshot,));    
        }
      },
    );
    return donations;
  }

}