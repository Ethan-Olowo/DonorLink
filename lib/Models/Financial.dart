import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donorlink/Database/Database.dart';
import 'package:intl/intl.dart';
import 'Organisation.dart';


class Financial {
  Database db = Database();
  String? location;
  Organisation org;
  String? id;
  DateTime date=DateTime.now();

  Financial(this.id, this.org, this.location);

  factory Financial.fromFirestore(DocumentSnapshot snapshot,Organisation org){
      final data = snapshot.data() as Map<String, dynamic>;
      Financial fin= Financial(snapshot.id, org, data['location']);
      if(data['date']!=null)fin.setDate(data['date'].toDate());
      return fin;
  }

  Map<String, dynamic> toFirestore() {
    return {
      //id is autogenerated
      "org": org.id,
      "date": date,
      "location": location
    };
  }

  String getDate() { 
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    return formatted;
   }
  void setLocation(String location) { /*...*/ }
  String? getLocation() { /*...*/ return location; }
  void setDate(DateTime date) { 
    this.date = date;
   }
  String? getID() { /*...*/ return id; }
  Organisation getOrganisation() { /*...*/ return org; }

  Future<bool> upload() async {
    if(id!=null||id==''){
      return await db.addFinancial(this);
    }else{
      return await db.updateFinancial(this);
    }
  }
}
