import 'package:donorlink/Database/database.dart';
import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Approval.dart';
import 'package:donorlink/Models/Donation.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Rating.dart';
import 'package:donorlink/Models/Review.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/Models/User.dart';

class AdminControls extends Database {
  approveReviewer(Approval approval) async {
    final revDoc = db.collection("Users").doc(approval.reviewer.id);

    return await db.runTransaction((transaction) async {
      transaction.update(revDoc, approval.reviewer.toFirestore());
      db.collection("Approvals").add(approval.toFirestore());
    }).then(
      (value) => true,
      onError: (e) => false,
    );
  }

  rejectReviewer(Reviewer reviewer) async {
    final revDoc = db.collection("Users").doc(reviewer.id);
    return await db.runTransaction((transaction) async {
      transaction.update(revDoc, {"approval": 'rejected'});
    }).then(
      (value) => true,
      onError: (e) => false,
    );
  }

  @override
  Future<List<Interaction>> getInteractions(User user, String type) async {
    List<Interaction> inters = [];
    await db
        .collection("Interactions")
        .where("type", isEqualTo: type)
        .get()
        .then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          final data = docSnapshot.data();
          Donor donor = await getUser(data['donor']);
          Organisation org = await getUser(data['org']);
          if (type == 'donation') {
            inters.add(Donation.fromFirestore(docSnapshot, org, donor));
          }
          if (type == 'appointment') {
            inters.add(Appointment.fromFirestore(docSnapshot, org, donor));
          }
          if (type == 'rating') {
            inters.add(Rating.fromFirestore(docSnapshot, org, donor));
          }
        }
      },
    );
    return inters;
  }

  Future<List<Interaction>> getAllInteractions(User user) async {
    List<Interaction> inters = [];
    await db.collection("Interactions").get().then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          final data = docSnapshot.data() as Map<String, dynamic>;
          Donor donor = await getUser(data['donor']);
          Organisation org = await getUser(data['org']);
          if (data['type'] == 'donation') {
            inters.add(Donation.fromFirestore(docSnapshot, org, donor));
          }
          if (data['type'] == 'appointment') {
            inters.add(Appointment.fromFirestore(docSnapshot, org, donor));
          }
          if (data['type'] == 'rating') {
            inters.add(Rating.fromFirestore(docSnapshot, org, donor));
          }
        }
      },
    );
    return inters;
  }

  @override
  Future<List<Financial>> getFinancials(Organisation? org) async {
    List<Financial> financials = [];
    await db.collection("Financials").get().then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          final data = docSnapshot.data() as Map<String, dynamic>;
          Organisation organisation = await getUser(data['org']);
          financials.add(Financial.fromFirestore(docSnapshot, organisation));
        }
      },
    );
    return financials;
  }

  Future<List<User>> getAllUsers() async {
    List<User> users = [];
    await db.collection("Users").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          final data = docSnapshot.data();
          print(data);
          if (data['type'] == 'donor') {
            users.add(Donor.fromFirestore(
              docSnapshot,
            ));
          }
          if (data['type'] == 'organisation') {
            users.add(Organisation.fromFirestore(
              docSnapshot,
            ));
          }
          if (data['type'] == 'reviewer') {
            users.add(Reviewer.fromFirestore(
              docSnapshot,
            ));
          }
        }
      },
    );
    for (User user in users) {
      print(user.toString());
    }
    return users;
  }

  @override
  Future<List<Review>> getReviews(User? user) async {
    List<Review> revs = [];
    if (user != null) {
      await db
          .collection("Reviews")
          .where("org", isEqualTo: user.id)
          .get()
          .then(
        (querySnapshot) async {
          for (var docSnapshot in querySnapshot.docs) {
            final data = docSnapshot.data();
            Reviewer rev = await getUser(data['reviewer']);
            Organisation org = await getUser(data['org']);
            revs.add(Review.fromFirestore(docSnapshot, org, rev));
          }
        },
      );
    } else {
      await db.collection("Reviews").get().then(
        (querySnapshot) async {
          for (var docSnapshot in querySnapshot.docs) {
            final data = docSnapshot.data();
            Reviewer rev = await getUser(data['reviewer']);
            revs.add(
                Review.fromFirestore(docSnapshot, user as Organisation, rev));
          }
        },
      );
    }
    return revs;
  }
}
