import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  String? uid;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? email;
  String? profileImage;
  DateTime? createdAt;
  DateTime? dob;
  String? aboutMe;
  bool? isRegistered;
  bool? isDeactivated;
  bool? isBarber;
  String? businessName;
  String? streetAddress;
  String? city;
  String? province;

  UsersModel({
    this.uid,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.createdAt,
    this.dob,
    this.profileImage,
    this.aboutMe,
    this.isRegistered,
    this.isDeactivated,
    this.isBarber,
    this.city,
    this.businessName,
    this.province,
    this.streetAddress,
  });

  UsersModel.fromFirestore(DocumentSnapshot docs) {
    uid = docs.get('uid');
    phoneNumber = docs.get('phoneNumber');
    firstName = docs.get('firstName');
    lastName = docs.get('lastName');
    email = docs.get('email');
    createdAt = (docs.get('createdAt') as Timestamp).toDate();
    dob = (docs.get('dob') as Timestamp).toDate();
    profileImage = docs.get('profileImage');
    aboutMe = docs.get('aboutMe');
    isRegistered = docs.get('isRegistered');
    isDeactivated = docs.get('isDeactivated');
    isBarber = docs.get('isBarber');
    city = docs.get('city');
    businessName = docs.get('businessName');
    province = docs.get('province');
    streetAddress = docs.get('streetAddress');
  }

  Map<String, dynamic> toJSON() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['phoneNumber'] = phoneNumber;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['createdAt'] = createdAt;
    _data['dob'] = dob;
    _data['profileImage'] = profileImage;
    _data['aboutMe'] = aboutMe;
    _data['isRegistered'] = isRegistered;
    _data['isDeactivated'] = isDeactivated;
    _data['isBarber'] = isBarber;
    _data['city'] = city;
    _data['businessName'] = businessName;
    _data['province'] = province;
    _data['streetAddress'] = streetAddress;
    return _data;
  }

  Map<String, dynamic> toJSONforUpdate() {
    final _data = <String, dynamic>{};
    uid != null ? _data['uid'] = uid : null;
    phoneNumber != null ? _data['phoneNumber'] = phoneNumber : null;
    firstName != null ? _data['firstName'] = firstName : null;
    lastName != null ? _data['lastName'] = lastName : null;
    email != null ? _data['email'] = email : null;
    dob != null ? _data['dob'] = dob : null;
    profileImage != null ? _data['profileImage'] = profileImage : null;
    aboutMe != null ? _data['aboutMe'] = aboutMe : null;
    isRegistered != null ? _data['isRegistered'] = isRegistered : null;
    isDeactivated != null ? _data['isDeactivated'] = isDeactivated : null;
    isBarber != null ? _data['isBarber'] = isBarber : null;
    city != null ? _data['city'] = city : null;
    businessName != null ? _data['businessName'] = businessName : null;
    province != null ? _data['province'] = province : null;
    streetAddress != null ? _data['streetAddress'] = streetAddress : null;
    return _data;
  }
}
