import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createOwner(
      {id, email, longitude, latidude, placeName, placeCategory}) async {
    await _firestore.collection("owners").doc(id).set({
      "email": email,
      "placeName": placeName,
      "longitude": longitude,
      "latidude": latidude,
      "placeCategory": placeCategory,
      "id": id,
    });
  }
}
