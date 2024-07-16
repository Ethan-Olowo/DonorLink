import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Rating.dart';
import 'package:donorlink/Models/Review.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/Models/User.dart';


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
        }else if(data['type']=='admin'){
          user = Admin.fromFirestore(doc);
          return user;
        }else{
          user = 'error Retrieving user';
          return user;
        }
      },
    );
    return user;
    
  }

  Future<List<User>> getUsers(String type) async {
    List<User> users=[];
    await db.collection("Users").where("type", isEqualTo: type).get().then(
    (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        if(type == 'donor')users.add(Donor.fromFirestore(docSnapshot,));
        if(type == 'organisation')users.add(Organisation.fromFirestore(docSnapshot,));
        if(type == 'reviewer')users.add(Reviewer.fromFirestore(docSnapshot,));    
      }
    },    
  );
  return users;
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

  Future<List<Interaction>> getInteractions(User user, String type) async {
    List<Interaction> inters=[];
    await db.collection("Interactions").where("type", isEqualTo: type).where("org", isEqualTo: user.id).get().then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          final data = docSnapshot.data();
          Donor donor = await getUser(data['donor']);
          if(type=='donation')inters.add(Donation.fromFirestore(docSnapshot,user as Organisation, donor));    
          if(type=='appointment')inters.add(Appointment.fromFirestore(docSnapshot,user as Organisation, donor));    
          if(type=='rating')inters.add(Rating.fromFirestore(docSnapshot,user as Organisation, donor));    
        }
      },
    );
    return inters;
  }

  Future<List<Financial>> getFinancials(Organisation? org) async {
    List<Financial> financials=[];
    await db.collection("Financials").where('org', isEqualTo: org!.id).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          financials.add(Financial.fromFirestore(docSnapshot, org));    
        }
      },
    );
    return financials;
  }

  Future<List<Review>> getReviews(User user) async {
    List<Review> revs=[];
    await db.collection("Reviews").where("org", isEqualTo: user.id).get().then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          final data = docSnapshot.data();
          Reviewer rev = await getUser(data['reviewer']);
          revs.add(Review.fromFirestore(docSnapshot, user as Organisation, rev));    
        }
      },
    );
    return revs;
  }

  Future<bool> addUser(User user) async {
    return await db.collection("Users").doc(user.id).set(user.toFirestore()).then(
      (value) =>  true,
      onError: (e) => false,
    );
  }

  Future<bool> addInteraction(Interaction inter) async {
    return await db.collection("Interactions").add(inter.toFirestore()).then(
      (value) =>  true,
      onError: (e) => false,
    );
  }

  Future<bool> updateInteraction(Interaction inter) async {
    return await db.collection("Interactions").doc(inter.id).set(inter.toFirestore()).then(
      (value) =>  true,
      onError: (e) => false,
    );
  }

  
  
  Future<bool> addRating(Rating rating) async {
    Organisation org = await rating.getOrg();
    final orgDoc = db.collection("Users").doc(org.id);
    return await db.runTransaction((transaction) async {
      final snapshot = await transaction.get(orgDoc);
      final newRatings = snapshot.get("ratings") + 1;
      final newAvg = (snapshot.get("rating") * (snapshot.get("ratings")) + rating.rating)/newRatings;
      transaction.update(orgDoc, {"ratings": newRatings,
        'rating': newAvg
        });
      db.collection('Interactions').add(rating.toFirestore());
    }).then(
      (value) =>  true,
      onError: (e) => false,
    );
  }

  Future<bool> addFinancial(Financial fin) async {
    return await db.collection("Financials").add(fin.toFirestore()).then(
      (value) =>  true,
      onError: (e) => false,
    );
  }

  Future<bool> updateFinancial(Financial fin) async {
    return await db.collection("Financials").doc(fin.id).set(fin.toFirestore()).then(
      (value) =>  true,
      onError: (e) => false,
    );
  }

  Future<Map<String, int>> getStats() async {
    Map<String, int> stats = {};
    List<String> users = ['donor','organisation', 'reviewer','admin'];
    List<String> inters = ['donation','rating', 'appointment',];
    for(String user in users){
      await db.collection("Users").where("type", isEqualTo: user).count().get().then(
        (res) => stats.addAll({user: res.count ?? 0}),
      );
    }
    for(String inter in inters){
      await db.collection("Interactions").where("type", isEqualTo: inter).count().get().then(
        (res) => stats.addAll({inter:res.count ?? 0}),
      );
    }
    await db.collection("Reviews").count().get().then(
      (res) => stats.addAll({'review':res.count ?? 0}),
    );
    await db.collection("Financials").count().get().then(
      (res) => stats.addAll({'financial':res.count ?? 0}),
    );
    /*await db.collection("Interactions").where("type", isEqualTo: 'donation').aggregate(sum('donationAmount')).get().then(
      (res) => stats.addAll({'total donations':res.getSum('donationAmount')?.round()}),
    );*/
    return stats;
  }

  /*Future<List<Object>> getDocuments(String collection, List<List<String>> conditions) async {
    List<Donation> donations=[];
    Query<Map<String, dynamic>> query= db.collection(collection);
    for( List<String> condition in conditions){
      query = query.where(condition[0], isEqualTo: condition[1]);
    }
    await query.get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          donations.add(Donation.fromFirestore(docSnapshot,));    
        }
      },
    );
    return donations;
  }
  Future<Financial?> getFinancial(Organisation org, String id) async {
    final docRef = db.collection("Financial").doc(id);
    Financial? financial;
    financial = await docRef.get().then(
      (DocumentSnapshot doc) {
        return Financial.fromFirestore(doc, org);
      });
    return financial;
  }
  */
}
