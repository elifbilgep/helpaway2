import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantItem {
  final String restaurantName;
  final String id;
  final String publisherId;
  final String foodCategory;
  final String foodName;
  final String availableUntil;
  final double latitude;
  final double longitude;

  RestaurantItem(
      {this.restaurantName,
      this.latitude,
      this.longitude,
      this.id,
      this.publisherId,
      this.foodCategory,
      this.foodName,
      this.availableUntil});

  factory RestaurantItem.createFromDoc(DocumentSnapshot doc) {
    return RestaurantItem(
        id: doc.id,
        publisherId: doc.get("publisherId"),
        foodCategory: doc.get("foodCategory"),
        foodName: doc.get("foodName"),
        availableUntil: doc.get("availableUntil"),
        latitude: doc.get("latitude"),
        longitude: doc.get("longitude"),
        restaurantName: doc.get("restaurantName"));

  }
}
