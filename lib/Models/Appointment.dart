import 'Interaction.dart';
import 'Organisation.dart';
import 'Donor.dart';

class Appointment extends Interaction {
  DateTime approvalDate;
  bool approvalStatus;
  String reason;

  Appointment(int id, Organisation org, Donor donor, DateTime date, this.approvalDate, this.approvalStatus, this.reason)
      : super(id, org, donor, date);

  void setReason(String reason) { /*...*/ }
  String getReason() { /*...*/ return reason; }
  DateTime getApprovalDate() { /*...*/ return approvalDate; }
  bool getStatus() { /*...*/ return approvalStatus; }
  void setApprovalDate(DateTime date) { /*...*/ }
  DateTime getAppointmentDate() { /*...*/ return super.getDate(); }
  void setAppointmentDate(DateTime date) { /*...*/ }
}

