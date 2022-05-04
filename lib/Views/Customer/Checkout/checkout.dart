import 'dart:developer';

import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/statuses.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Methods/overlays.dart';
import 'package:barber/Models/booking_model.dart';
import 'package:barber/Models/salon_model.dart';
import 'package:barber/Services/db_services.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:barber/Views/Widgets/buttons.dart';
import 'package:barber/Views/Widgets/mycontainer.dart';
import 'package:barber/Views/Widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class CheckOutView extends StatelessWidget {
  CheckOutView(
      {Key? key,
      required this.servicesCart,
      required this.serviceType,
      required this.ownerId,
      required this.salonId})
      : super(key: key);
  List<ServicesModel> servicesCart;
  int serviceType;
  String ownerId;
  String salonId;
  RxInt typeOfServices = 0.obs;
  RxString locationName = ''.obs;
  final TextEditingController noteController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  late DateTime? bookingdateTime;
  RxBool isEnable = false.obs;
  final double lat = 0.0;
  final double lng = 0.0;
  @override
  Widget build(BuildContext context) {
    double total = 0.0;
    for (var i = 0; i < servicesCart.length; i++) {
      total = total + servicesCart[i].price!;
    }
    switch (serviceType) {
      case 0:
        typeOfServices.value = 0;
        break;
      case 1:
        typeOfServices.value = 1;
        break;
      case 2:
        typeOfServices.value = 0;
        break;
      default:
        typeOfServices.value = serviceType;
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyContainer(
                  hPadding: 10,
                  vPadding: 10,
                  width: double.infinity,
                  isShadow: true,
                  color: kWhiteColor,
                  radius: 12,
                  child: ChildTextField(
                    title: 'Date and Time',
                    titleStyle: kH3,
                    hintText: 'Select Booking Date and Time',
                    controlller: dateTimeController,
                    isReadOnly: true,
                    ontap: () async {
                      bookingdateTime = await showOmniDateTimePicker(
                        context: context,
                        startFirstDate: DateTime.now(),
                        startInitialDate: DateTime.now(),
                        startLastDate:
                            DateTime.now().add(const Duration(days: 30)),
                        primaryColor: kMainColor,
                      );
                      log(bookingdateTime.toString());
                      dateTimeController.text = bookingdateTime != null
                          ? DateFormat('h:mm a - ' 'MMMM d, ' 'yyyy')
                              .format(bookingdateTime!)
                          : dateTimeController.text;
                      checkValidity();
                    },
                  )),
              const SizedBox(height: 10),
              MyContainer(
                  hPadding: 10,
                  vPadding: 10,
                  width: double.infinity,
                  isShadow: true,
                  color: kWhiteColor,
                  radius: 12,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Service Type', style: kH3),
                        const Divider(),
                        serviceType == 0
                            ? const Text('Serivces are only for Salon.')
                            : serviceType == 1
                                ? const Text('Services are only for Home')
                                : Obx(() => Row(children: [
                                      RadioButton(
                                          activeColor: kMainColor,
                                          description: 'Salon',
                                          value: 0,
                                          groupValue: typeOfServices.value,
                                          onChanged: (value) {
                                            typeOfServices.value = value as int;
                                            checkValidity();
                                          }),
                                      RadioButton(
                                          activeColor: kMainColor,
                                          description: 'Home',
                                          value: 1,
                                          groupValue: typeOfServices.value,
                                          onChanged: (value) {
                                            typeOfServices.value = value as int;
                                            checkValidity();
                                          })
                                    ]))
                      ])),
              Obx(() => typeOfServices.value == 1
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: MyContainer(
                          width: double.infinity,
                          isShadow: true,
                          radius: 12,
                          color: kWhiteColor,
                          child: ListTile(
                              title: const Text('Location', style: kH3),
                              subtitle: locationName.value != ''
                                  ? Text(locationName.value)
                                  : const Text('Select Location'),
                              trailing: const Icon(Glyphicon.pin_map),
                              onTap: () async {
                                // try {
                                //   loadingOverlay('Getting Current Location');
                                //   Position position = await determinePosition();

                                //   LocationResult? result = await Get.to(() => PlacePicker(
                                //         "AIzaSyCnsf5dNguOOCv5957qQPynAx2z2JjstM8",
                                //         displayLocation:
                                //             LatLng(position.latitude, position.longitude),
                                //       ));
                                //   lat = result!.latLng!.latitude;
                                //   lng = result.latLng!.longitude;
                                //   Get.back();
                                //   locationName.value = result != null
                                //       ? result.formattedAddress!
                                //       : locationName.value;

                                checkValidity();
                                // } catch (e) {
                                //   Get.back();
                                //   errorOverlay(e.toString());
                                //   log(e.toString());
                                // }
                              })))
                  : const SizedBox()),
              const SizedBox(height: 10),
              MyContainer(
                  hPadding: 10,
                  vPadding: 10,
                  width: double.infinity,
                  isShadow: true,
                  color: kWhiteColor,
                  radius: 12,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Services Details', style: kH3),
                        const Divider(),
                        MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: servicesCart.length,
                                itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(children: [
                                      Expanded(
                                          child:
                                              Text(servicesCart[index].name!)),
                                      Text(servicesCart[index].price.toString())
                                    ])))),
                        const Divider(),
                        Row(children: [
                          const Text('Total', style: kBoldText),
                          const Spacer(),
                          Text('Rs: ' + total.toString(), style: kBoldText)
                        ])
                      ])),
              const SizedBox(height: 10),
              MyContainer(
                  width: double.infinity,
                  isShadow: true,
                  hPadding: 10,
                  vPadding: 10,
                  color: kWhiteColor,
                  radius: 12,
                  child: ChildTextField(
                    title: 'Booking Note',
                    titleStyle: kH3,
                    hintText: 'Please write any specific instructions',
                    lines: 5,
                    controlller: noteController,
                  )),
              const SizedBox(height: 10),
              DynamicHeavyButton(
                width: double.infinity,
                isEnable: isEnable,
                lable: 'Book Now',
                ontap: () async {
                  loadingOverlay('Please Wait');
                  List<String> servicesIds = [];
                  for (var element in servicesCart) {
                    servicesIds.add(element.uid!);
                  }
                  BookingModel bookingModel = BookingModel(
                    customerId: userID.value,
                    bookingNote: noteController.text,
                    ownerId: ownerId,
                    salonId: salonId,
                    status: statusValues.first,
                    address: locationName.value,
                    longitude: lng,
                    latitude: lat,
                    isHomeService: typeOfServices.value == 1 ? true : false,
                    bookedAt: DateTime.now(),
                    bookingForTime: bookingdateTime,
                    totalAmount: total,
                    services: servicesIds,
                  );
                  await DBServices().addBooking(bookingModel);
                  Get.back();
                  Get.back(result: true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkValidity() {
    if (dateTimeController.text.isNotEmpty) {
      if (typeOfServices.value == 1) {
        locationName.isNotEmpty
            ? isEnable.value = true
            : isEnable.value = false;
      } else {
        isEnable.value = true;
      }
    } else {
      isEnable.value = false;
    }
  }
}
