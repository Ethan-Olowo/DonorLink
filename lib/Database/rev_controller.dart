

import 'package:donorlink/Database/database.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Review.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/Models/User.dart';

class RevController extends Database{
  
  @override
  Future<List<Review>> getReviews(User user) async {
    List<Review> revs=[];
    await db.collection("Reviews").where("reviewer", isEqualTo: user.id).get().then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          final data = docSnapshot.data() as Map<String, dynamic>;
          Organisation org = await getUser(data['org']);
          revs.add(Review.fromFirestore(docSnapshot, org ,user as Reviewer));    
        }
      },
    );
    return revs;
  }
}