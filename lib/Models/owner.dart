import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Owner {
  final String email;
  final String id;
  final double latitude;
  final double longitude;
  final String placeName;
  final String placeCategory;

  Owner(
      {this.email,
      this.id,
      this.latitude,
      this.longitude,
      this.placeName,
      this.placeCategory});

  factory Owner.createFromFirebase(User user) {
    return Owner(id: user.uid, email: user.email);
  }

  factory Owner.createFromDoc(DocumentSnapshot doc) {
    return Owner(
      id: doc.id,
      latitude: doc.get("latitude"),
      longitude: doc.get("longitude"),
      placeCategory: doc.get("placeCategory"),
      placeName: doc.get("placeName"),
    );
  }
}
