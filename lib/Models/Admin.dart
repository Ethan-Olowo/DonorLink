import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donorlink/Database/admin_controller.dart';
import 'package:donorlink/Models/Approval.dart';
import 'package:donorlink/Models/Financial.dart';
import 'package:donorlink/Models/Interaction.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'User.dart';
import 'Review.dart';
import 'Reviewer.dart';

class Admin extends User {
  @override
  var db = Admincontroller();
  Admin(super.id, String super.name, String super.phone, super.email,);

  factory Admin.fromFirestore(DocumentSnapshot snapshot,){
      final data = snapshot.data() as Map<String, dynamic>;
      return Admin(
        snapshot.id , data['name'], data['phone'], data['email'],
      );
    }

  Future<Reviewer?> approveReviewer(Reviewer reviewer) async{ 
    reviewer.approval = 'approved';
    var approval = Approval('',this, reviewer, DateTime.now());
    return await (db as Admincontroller).approveReviewer(this, reviewer, approval);
   }
   void rejectReviewer(Reviewer reviewer) {
    reviewer.approval = 'rejected';
    (db as Admincontroller).rejectReviewer( reviewer);
    }
  
  Future<List<Review>> getReviews(Organisation? org) async { 
    return await (db as Admincontroller).getReviews(org); 
    }
  Future<List<User>> getReviewers() async { 
    return await db.getUsers('reviewer'); 
    }
  
  Future<List<User>> getUnapprovedReviewers() async { 
    var revs = await db.getUsers('reviewer'); 
    return revs.where((rev) => (rev as Reviewer).approval != 'approved').toList();
    }
  
  Future<List<Financial>> getFinancials() async {
    return await db.getFinancials(null);
  }
  @override
  Future<List<Interaction>> getInteractions(String type){
    return db.getInteractions(this,type);
  }

  
  Future<List<Interaction>> getAllInteractions(){
    return (db as Admincontroller ).getAllInteractions(this);
  }

  Future<String> getStats() async {
    Map stats = await db.getStats();
    String output='';
    stats.forEach((k,v)=>output = '$output${(k as String).capitalize()}s : $v,\t');
    return output;
  }

  Future<List<User>>getAllUsers(){
    return (db as Admincontroller).getAllUsers();
  }
  
  @override
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = super.toFirestore();
    map.addAll({"type": "admin",});
    return map;
  }
}
