import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/owner.dart';
import '../Models/restaurantItem.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createOwner(
      {id, email, latitude, longitude, placeName, placeCategory,}) async {
    await _firestore.collection("owners").doc(id).set({
      "email": email,
      "placeName": placeName,
      "latitude": latitude,
      "longitude": longitude,
      "placeCategory": placeCategory,
      "id": id,
    });
  }

  Future<void> createFoodItem(
      {id, publisherId, foodCategory, foodName, availableUntil,latitude, longitude,restaurantName}) async {
    await _firestore.collection("RestaurantItems").doc(id).set({
      "publisherId": publisherId,
      "foodCategory": foodCategory,
      "foodName": foodName,
      "availableUntil": availableUntil,
      "latitude" : latitude,
      "longitude" : longitude,
      "restaurantName" : restaurantName,
    });
  }

  Future<Owner> bringUser(id) async {
    DocumentSnapshot doc = await _firestore.collection("owners").doc(id).get();
    if (doc.exists) {
      Owner owner = Owner.createFromDoc(doc);
      print("owner " + owner.id);
      return owner;
    }
    return null;
  }

  Future<List<RestaurantItem>> bringOwnerFoods(id) async {
    var snapshot = await _firestore
        .collection("RestaurantItems")
        .where("publisherId", isEqualTo: id)
        .get();
    var foods =
        snapshot.docs.map((doc) => RestaurantItem.createFromDoc(doc)).toList();

    return foods;
  }

  bringAllFoods() async {
    var snapshot = await _firestore.collection("RestaurantItems").get();
    var allFoods =
        snapshot.docs.map((doc) => RestaurantItem.createFromDoc(doc)).toList();

    return allFoods;
  }
}
