import 'package:cloud_firestore/cloud_firestore.dart';

import 'Interaction.dart';
import 'Organisation.dart';
import 'Donor.dart';

class Appointment extends Interaction {
  DateTime approvalDate;
  bool approvalStatus;
  String reason;

  Appointment(super.id, super.org, super.donor, this.approvalDate, this.approvalStatus, this.reason);

  factory Appointment.fromFirestore(DocumentSnapshot snapshot,){
    final data = snapshot.data() as Map<String, dynamic>;
    Appointment app = Appointment(snapshot.id, data['org'], data['donor'], data['approvalDate'], data['approvalStatus'], data['reason']);
    app.setDate(data['date']);
    return app;
  }

  void setReason(String reason) { /*...*/ }
  String getReason() { /*...*/ return reason; }
  DateTime getApprovalDate() { /*...*/ return approvalDate; }
  bool getStatus() { /*...*/ return approvalStatus; }
  void setApprovalDate(DateTime date) { /*...*/ }
  DateTime getAppointmentDate() { /*...*/ return super.getDate(); }
  void setAppointmentDate(DateTime date) { /*...*/ }
}

