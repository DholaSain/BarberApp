import 'dart:developer';

import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/statuses.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Controllers/salon_controller.dart';
import 'package:barber/Methods/status_update.dart';
import 'package:barber/Models/booking_model.dart';
import 'package:barber/Models/salon_model.dart';
import 'package:barber/Views/Widgets/buttons.dart';
import 'package:barber/Views/Widgets/mycontainer.dart';
import 'package:barber/Views/Widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:intl/intl.dart';

class BookingDetails extends StatelessWidget {
  BookingDetails({Key? key, required this.booking}) : super(key: key);
  final BookingModel booking;
  final SalonsController salonsController = Get.find<SalonsController>();
  double ratingValue = 5.0;
  final TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SalonModel salon = salonsController.salons!
        .firstWhere((salons) => salons.uid == booking.salonId);
    List<ServicesModel> services = [];

    for (int i = 0; i < booking.services!.length; i++) {
      services.add(salon.services!
          .firstWhere((element) => element.uid == booking.services![i]));
    }

    double total = 0.0;
    for (var i = 0; i < services.length; i++) {
      total = total + services[i].price!;
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking Details'),
          elevation: 1,
          backgroundColor: booking.status == statusValues[2]
              ? kErrorColor
              : booking.status == statusValues[3]
                  ? kAmberColor
                  : kMainColor,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 10),
          MyContainer(
              isShadow: true,
              hPadding: 10,
              vPadding: 10,
              hMargin: 10,
              radius: 8,
              color: kWhiteColor,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      const Text('Booking', style: kH3),
                      const Spacer(),
                      Text(booking.status!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: booking.status == statusValues[2]
                                  ? kErrorColor
                                  : booking.status == statusValues[3]
                                      ? kAmberColor
                                      : kMainColor))
                    ]),
                    const Divider(),
                    Row(children: [
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text('Date:'),
                            Text(
                                DateFormat('MMMM d, ' 'yyyy')
                                    .format(booking.bookingForTime!),
                                style: kBoldText)
                          ])),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text('Time:'),
                            Text(
                                DateFormat('h:mm a')
                                    .format(booking.bookingForTime!),
                                style: kBoldText)
                          ]))
                    ])
                  ])),
          const SizedBox(height: 10),
          MyContainer(
              isShadow: true,
              hPadding: 10,
              vPadding: 10,
              hMargin: 10,
              radius: 8,
              color: kWhiteColor,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Details', style: kH3),
                        // const Spacer(),
                        Text(
                          DateFormat('h:mm a - MMMM d, ' 'yyyy')
                              .format(booking.bookedAt!),
                        )
                      ],
                    ),
                    const Divider(),
                    MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: services.length,
                            itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(children: [
                                  Expanded(child: Text(services[index].name!)),
                                  Text(services[index].price.toString())
                                ])))),
                    const Divider(),
                    Row(children: [
                      const Text('Total', style: kBoldText),
                      const Spacer(),
                      Text('AED ' + total.toString(), style: kBoldText)
                    ]),
                    booking.bookingNote != ''
                        ? Column(
                            children: [
                              const Divider(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Note: ', style: kBoldText),
                                  Expanded(child: Text(booking.bookingNote!)),
                                ],
                              )
                            ],
                          )
                        : const SizedBox(),
                  ])),
          const SizedBox(height: 10),
          MyContainer(
              isShadow: true,
              hPadding: 10,
              vPadding: 10,
              hMargin: 10,
              radius: 8,
              color: kWhiteColor,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Location', style: kH3),
                          DynamicHeavyButton(
                            height: 30,
                            isEnable: true.obs,
                            radius: 8,
                            ontap: () async {
                              // final availableMaps =
                              //     await mapL.MapLauncher.installedMaps;
                              // if (availableMaps.isEmpty) {
                              //   Get.snackbar(
                              //       'Error', 'Please install Map app first.');
                              // } else if (availableMaps.length == 1) {
                              //   bool? googleMap =
                              //       await mapL.MapLauncher.isMapAvailable(
                              //           mapL.MapType.google);
                              //   if (googleMap!) {
                              //     await mapL.MapLauncher.showMarker(
                              //       mapType: mapL.MapType.google,
                              //       coords: mapL.Coords(booking.latitude!,
                              //           booking.longitude!),
                              //       title: booking.address!,
                              //       description: 'description',
                              //     );
                              //   } else if (Platform.isAndroid) {
                              //     await mapL.MapLauncher.showMarker(
                              //       mapType: mapL.MapType.google,
                              //       coords: mapL.Coords(booking.latitude!,
                              //           booking.longitude!),
                              //       title: booking.address!,
                              //       description: 'description',
                              //     );
                              //   } else if (Platform.isIOS) {
                              //     await mapL.MapLauncher.showMarker(
                              //       mapType: mapL.MapType.apple,
                              //       coords: mapL.Coords(booking.latitude!,
                              //           booking.longitude!),
                              //       title: booking.address!,
                              //       description: 'description',
                              //     );
                              //   }
                              // } else {
                              //   openMapsSheet(context, availableMaps);
                              // }
                            },
                            // lable: 'Get Direction',
                            child: Row(children: const [
                              Text('Get Direction   ', style: kWhiteText),
                              Icon(Icons.directions,
                                  color: kWhiteColor, size: 20)
                            ]),
                          )
                        ]),
                    const Divider(),
                    const SizedBox(
                      height: 250,
                      width: double.infinity,

                      child: Text('Map Will be here'),
                      // child: GoogleMap(
                      //   initialCameraPosition: customerPosition,
                      //   markers: <Marker>{
                      //     Marker(
                      //         markerId: const MarkerId('a'),
                      //         position:
                      //             LatLng(booking.latitude!, booking.longitude!))
                      //   },
                      //   myLocationButtonEnabled: true,
                      //   myLocationEnabled: true,
                      //   zoomGesturesEnabled: true,
                      //   zoomControlsEnabled: false,
                      // ),
                    )
                  ])),
          booking.status == statusValues[0]
              ? DynamicHeavyButton(
                  color: kAmberColor,
                  horizontalMargin: 10,
                  isEnable: true.obs,
                  verticalMargin: 10,
                  ontap: () {
                    statusUpdateDialogBox(
                        context,
                        'By Cancelling booking, you won\'t be able to undo this action',
                        'Cancel Booking',
                        statusValues[3],
                        booking.uid!);
                  },
                  lable: 'Cancel Booking',
                  width: double.infinity,
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          booking.status == statusValues[1]
              ? MyContainer(
                  isShadow: true,
                  hPadding: 10,
                  vPadding: 10,
                  hMargin: 10,
                  radius: 8,
                  color: kWhiteColor,
                  child: booking.isSalonRated!
                      ? const Text('Thanks for Feedback')
                      : Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text('Please rate the Salon',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            const SizedBox(height: 8),
                            RatingBar.builder(
                                initialRating: 5,
                                allowHalfRating: true,
                                itemBuilder: ((context, index) => const Icon(
                                    Glyphicon.star_fill,
                                    color: kMainColor)),
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                itemSize: 35,
                                onRatingUpdate: (value) {
                                  ratingValue = value;
                                  log(ratingValue.toString());
                                }),
                            // const SizedBox(height: 10),
                            const Divider(),
                            ChildTextField(
                              title: 'Review',
                              titleStyle: kH4,
                              hintText: 'Please write feedback',
                              lines: 3,
                              controlller: reviewController,
                            ),
                            const SizedBox(height: 10),
                            DynamicHeavyButton(
                                width: double.infinity,
                                isEnable: true.obs,
                                ontap: () async {},
                                lable: 'Submit Review')
                          ],
                        ))
              : const SizedBox(),
          const SizedBox(height: 60),
        ])));
  }
}
