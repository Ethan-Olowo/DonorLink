import 'package:donorlink/Database/database.dart';
import 'package:donorlink/Models/Organisation.dart';

class Orgcontroller extends Database {

  @override
  Future<List<Organisation>> getOrganisations() async {
    List<Organisation> orgs=[];
    return orgs;
  }

}