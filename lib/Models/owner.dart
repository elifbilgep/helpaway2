import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Owner {
  final String email;
  final String id;
  final bool langitude;
  final bool longitude;
  final String placeName;
  final String placeCategory;

  Owner(
      {this.email,
      this.id,
      this.langitude,
      this.longitude,
      this.placeName,
      this.placeCategory});

  factory Owner.createFromFirebase(User user) {
    return Owner(id: user.uid, email: user.email);
  }

  factory Owner.createFromDoc(DocumentSnapshot doc) {
    return Owner(
      id: doc.id,
      langitude: doc.get("langitude"),
      longitude: doc.get("longitude"),
      placeCategory: doc.get("placeCategory"),
      placeName: doc.get("placeName")
    );
  }
}
