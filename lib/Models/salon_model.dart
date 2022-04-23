import 'package:cloud_firestore/cloud_firestore.dart';

class SalonModel {
  String? uid;
  String? ownerId;
  String? name;
  String? description;
  double? rating;
  String? streetAddress;
  String? city;
  String? latitude;
  String? longitude;
  List<ServicesModel>? services;
  List? images;
  List? likes;
  bool? isActive;
  bool? isMenSalon;

  bool? isHomeService;

  SalonModel({
    this.uid,
    this.ownerId,
    this.name,
    this.description,
    this.rating,
    this.streetAddress,
    this.city,
    this.latitude,
    this.longitude,
    this.services,
    this.images,
    this.likes,
    this.isActive,
    this.isMenSalon,
    this.isHomeService,
  });

  SalonModel.fromFirestore(
      DocumentSnapshot docs, List<ServicesModel>? servicess) {
    uid = docs.get('uid');
    ownerId = docs.get('ownerId');
    name = docs.get('name');
    description = docs.get('description');
    rating = docs.get('rating');
    streetAddress = docs.get('streetAddress');
    city = docs.get('city');
    latitude = docs.get('latitude');
    longitude = docs.get('longitude');
    images = docs.get('images');
    likes = docs.get('likes');
    isActive = docs.get('isActive');
    isMenSalon = docs.get('isMenSalon');
    isHomeService = docs.get('isHomeService');
    services = servicess;
  }
}

class ServicesModel {
  String? uid;
  String? name;
  String? shortDescription;
  String? longDescription;
  int? duration;
  String? image;
  double? price;

  ServicesModel({
    this.uid,
    this.name,
    this.shortDescription,
    this.longDescription,
    this.image,
    this.duration,
    this.price,
  });

  ServicesModel.fromFirestore(DocumentSnapshot docs) {
    uid = docs.id;
    name = docs.get('name');
    shortDescription = docs.get('shortDescription');
    longDescription = docs.get('longDescription');
    image = docs.get('image');
    duration = docs.get('duration');
    price = docs.get('price');
  }

  Map<String, dynamic> toJSON() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['name'] = name;
    _data['shortDescription'] = shortDescription;
    _data['longDescription'] = longDescription;
    _data['image'] = image;
    _data['duration'] = duration;
    _data['price'] = price;
    return _data;
  }
}
