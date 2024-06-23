import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donorlink/Controllers/Database.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Review.dart';

class Revcontroller extends Database {
  
  Future<List<Organisation>> getPendingOrganisations() async {
    List<Organisation> orgs=[];
    await db.collection("Users").where("type", isEqualTo: 'organisation').where("approval", isEqualTo: 'pending').get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        orgs.add(Organisation.fromFirestore(docSnapshot,));    
      }
    },
    //onError: (e) => print("Error completing: $e"),
    
  );
  
  return orgs;
  }

  Future<Review?> getReview( String id) async {
    final docRef = db.collection("Reviews").doc(id);
    Review? review;
    review = await docRef.get().then(
      (DocumentSnapshot doc) {
        review = Review.fromFirestore(doc);
        return review;
      });
    return review;
  }

  Future<List<Review>> getReviews(String orgid) async {
    List<Review> revs=[];
    await db.collection("Reviews").where("org", isEqualTo: orgid).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          revs.add(Review.fromFirestore(docSnapshot,));    
        }
      },
    );
    return revs;
  }

}