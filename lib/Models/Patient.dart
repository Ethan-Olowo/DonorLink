import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donorlink/Database/donor_controls.dart';
import 'package:donorlink/Models/Interaction.dart';

import 'User.dart';
import 'Hospital.dart';
import 'Appointment.dart';
import 'Rating.dart';

class Patient extends User {
  double rating;
  @override
  var db = DonorControls();

  Patient(
      {required String id,
      required String name,
      required String phone,
      required String email,
      required this.rating})
      : super(
          id,
          name,
          phone,
          email,
        );

  factory Patient.fromFirestore(
    DocumentSnapshot snapshot,
  ) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Patient(
      id: snapshot.id,
      name: data['name'],
      phone: data['phone'],
      email: data['email'],
      rating: data['rating'].toDouble(),
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = super.toFirestore();
    map.addAll({
      "type": "donor",
      "rating": rating,
    });
    return map;
  }

  Future<Appointment?> requestAppointment(
      Hospital org, DateTime appointmentDate, String reason) async {
    Appointment app =
        Appointment('', org, this, null, false, reason, appointmentDate);
    if (await db.addInteraction(app)) {
      return app;
    } else {
      return null;
    }
  }

  Future<Rating?> rateOrganisation(
      Hospital org, double score, String comment) async {
    Rating rating = Rating('', org, this, score, comment);
    if (await db.addRating(rating)) {
      return rating;
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return "Donor ${super.toString()}\nRating: $rating";
  }

  @override
  String info() {
    return 'rating: $rating';
  }

  @override
  Future<List<Interaction>> getInteractions(String type) async {
    return await db.getInteractions(this, type);
  }
}
