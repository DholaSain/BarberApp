import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String? uid;
  String? customerId;
  String? ownerId;
  String? salonId;
  String? bookingNote;
  String? status;
  String? address;
  double? longitude;
  double? latitude;
  bool? isHomeService;
  DateTime? bookedAt;
  DateTime? bookingForTime;
  double? totalAmount;
  List? services;

  BookingModel({
    this.uid,
    this.customerId,
    this.ownerId,
    this.salonId,
    this.bookingNote,
    this.status,
    this.address,
    this.longitude,
    this.latitude,
    this.isHomeService,
    this.bookedAt,
    this.bookingForTime,
    this.totalAmount,
    this.services,
  });

  BookingModel.fromFirestore(DocumentSnapshot docs) {
    uid = docs.get('uid');
    customerId = docs.get('customerId');
    ownerId = docs.get('ownerId');
    salonId = docs.get('salonId');
    bookingNote = docs.get('bookingNote');
    status = docs.get('status');
    address = docs.get('address');
    longitude = docs.get('longitude');
    latitude = docs.get('latitude');
    isHomeService = docs.get('isHomeService');
    bookedAt = (docs.get('bookedAt') as Timestamp).toDate();
    bookingForTime = (docs.get('bookingForTime') as Timestamp).toDate();
    totalAmount = docs.get('totalAmount');
    services = docs.get('services');
  }

  Map<String, dynamic> toJSON() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['customerId'] = customerId;
    _data['ownerId'] = ownerId;
    _data['salonId'] = salonId;
    _data['bookingNote'] = bookingNote;
    _data['status'] = status;
    _data['address'] = address;
    _data['longitude'] = longitude;
    _data['latitude'] = latitude;
    _data['isHomeService'] = isHomeService;
    _data['bookedAt'] = bookedAt;
    _data['bookingForTime'] = bookingForTime;
    _data['totalAmount'] = totalAmount;
    _data['services'] = services;
    return _data;
  }
}
