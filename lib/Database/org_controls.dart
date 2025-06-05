import 'package:donorlink/Database/database.dart';
import 'package:donorlink/Models/Hospital.dart';

class OrganisationControls extends Database {
  @override
  Future<List<Hospital>> getOrganisations() async {
    List<Hospital> orgs = [];
    return orgs;
  }
}
