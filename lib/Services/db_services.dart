import 'dart:developer';

import 'package:barber/Methods/overlays.dart';
import 'package:barber/Models/salon_model.dart';
import 'package:barber/Models/user_model.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DBServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String users = 'users';
  static String salons = 'salons';
  static String servicesRef = 'services';

  Future<void> createUser(UsersModel usersModel) async {
    try {
      await firestore
          .collection(users)
          .doc(usersModel.uid)
          .set(usersModel.toJSON());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<UsersModel> getUser(String userID) async {
    try {
      final retrval = await firestore
          .collection(users)
          .doc(userID)
          .get()
          .then((DocumentSnapshot doc) {
        UsersModel data = UsersModel();
        data = UsersModel.fromFirestore(doc);

        return data;
      });
      return retrval;
    } catch (e) {
      Get.snackbar('User failed', e.toString());
      rethrow;
    }
  }

  Future<void> updateUser(UsersModel usersModel) async {
    try {
      await firestore
          .collection(users)
          .doc(userID.value)
          .update(usersModel.toJSONforUpdate());
    } catch (e) {
      errorOverlay(e.toString());
    }
  }

  Future<void> switchProfile(bool status) async {
    try {
      await firestore
          .collection(users)
          .doc(userID.value)
          .update({'isBarber': status});
    } catch (e) {
      errorOverlay(e.toString());
    }
  }

  Future<void> addNewSalon(SalonModel salonModel) async {
    try {
      String uid = firestore.collection(salons).doc().id;
      await firestore.collection(salons).doc(uid).set({
        'uid': uid,
        'ownerId': userID.value,
        'name': salonModel.name,
        'description': salonModel.description,
        'rating': 0.0,
        'streetAddress': salonModel.streetAddress,
        'city': salonModel.city,
        'latitude': salonModel.latitude,
        'longitude': salonModel.longitude,
        'images': salonModel.images,
        'likes': [],
        'isActive': true,
        'isMenSalon': salonModel.isMenSalon,
        'isHomeService': salonModel.isHomeService,
      });
    } catch (e) {
      errorOverlay(e.toString());
      log(e.toString());
    }
  }

  // Stream<List<SalonModel>> streamOwnerSalons(String userId) {
  //   return firestore
  //       .collection(salons)
  //       .snapshots()
  //       .map((QuerySnapshot snapshot) {
  //     List<SalonModel> retVal = [];
  //     List<ServicesModel> services = [];
  //     for (var docs in snapshot.docs) {
  //       retVal.add(SalonModel.fromFirestore(docs, services));
  //     }
  //     return retVal;
  //   });
  // }

  Future<List<SalonModel>> getSalonOfOwner(String userId) async {
    return await firestore
        .collection(salons)
        .where('ownerId', isEqualTo: userId)
        .get()
        .then((QuerySnapshot snapshot) async {
      List<SalonModel> retVal = [];
      for (var docs in snapshot.docs) {
        List<ServicesModel> services = await firestore
            .collection(salons)
            .doc(docs.id)
            .collection(servicesRef)
            .get()
            .then((QuerySnapshot sSnapshot) {
          List<ServicesModel> sRetVal = [];
          for (var service in sSnapshot.docs) {
            sRetVal.add(ServicesModel.fromFirestore(service));
          }
          return sRetVal;
        });
        retVal.add(SalonModel.fromFirestore(docs, services));
      }
      return retVal;
    });
  }

  Future<void> addService(String salonId, ServicesModel servicesModel) async {
    try {
      String uid = firestore
          .collection(salons)
          .doc(salonId)
          .collection(servicesRef)
          .doc()
          .id;
      ServicesModel serviceData = ServicesModel(
        uid: uid,
        name: servicesModel.name,
        shortDescription: servicesModel.shortDescription,
        longDescription: servicesModel.longDescription,
        duration: servicesModel.duration,
        image: servicesModel.image,
        price: servicesModel.price,
      );
      await firestore
          .collection(salons)
          .doc(salonId)
          .collection(servicesRef)
          .doc()
          .set(serviceData.toJSON());
    } catch (e) {
      errorOverlay(e.toString());
      log(e.toString());
    }
  }
}
