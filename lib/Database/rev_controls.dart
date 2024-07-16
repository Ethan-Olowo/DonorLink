import 'package:donorlink/Database/database.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Review.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/Models/User.dart';

class RevControls extends Database {
  @override
  Future<List<Review>> getReviews(User user) async {
    List<Review> revs = [];
    await db
        .collection("Reviews")
        .where("reviewer", isEqualTo: user.id)
        .get()
        .then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          final data = docSnapshot.data();
          Organisation org = await getUser(data['org']);
          revs.add(Review.fromFirestore(docSnapshot, org, user as Reviewer));
        }
      },
    );
    return revs;
  }

  Future<bool> addReview(Review rev) async {
    final orgDoc = db.collection("Users").doc(rev.org.id);
    return await db.runTransaction((transaction) async {
      if (rev.approval == true) {
        transaction
            .update(orgDoc, {"approval": 'approved', 'approvalDate': rev.date});
      } else {
        transaction.update(orgDoc, {"approval": 'rejected'});
      }
      db.collection("Reviews").add(rev.toFirestore());
    }).then(
      (value) => true,
      onError: (e) => false,
    );
  }
}
