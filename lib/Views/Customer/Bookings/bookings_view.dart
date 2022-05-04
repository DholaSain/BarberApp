import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/statuses.dart';
import 'package:barber/Controllers/bookings_controller.dart';
import 'package:barber/Models/booking_model.dart';
import 'package:barber/Models/system_overlay.dart';
import 'package:barber/Views/Customer/Bookings/bookings_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ticket_material/ticket_material.dart';

import '../../../Constants/text_styles.dart';

class BookingsView extends StatelessWidget {
  BookingsView({Key? key}) : super(key: key);

  final BookingsController bookingsCntrlr = Get.put(BookingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (bookingsCntrlr.bookings == null) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (bookingsCntrlr.bookings!.isNotEmpty) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: bookingsCntrlr.bookings!.length,
            itemBuilder: (context, index) {
              BookingModel booking = bookingsCntrlr.bookings![index];
              return Padding(
                padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                child: TicketMaterial(
                  radiusBorder: 12,
                  height: 100,
                  useAnimationScaleOnTap: false,
                  tapHandler: () {
                    Get.to(() => BookingDetails(booking: booking));
                  },
                  colorBackground: booking.status == statusValues[2]
                      ? kErrorColor
                      : booking.status == statusValues[3]
                          ? kAmberColor
                          : kMainColor,
                  leftChild: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Total Services: ' +
                                booking.services!.length.toString(),
                            style: kH3.copyWith(color: kWhiteColor)),
                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  const Text('Booking Date', style: kWhiteText),
                                  Text(
                                      DateFormat('MMMM d, ' 'yyyy')
                                          .format(booking.bookingForTime!),
                                      style: kWhiteText.copyWith(
                                          fontWeight: FontWeight.bold))
                                ])),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Booking Time', style: kWhiteText),
                                  Text(
                                      DateFormat('h:mm a')
                                          .format(booking.bookingForTime!),
                                      style: kWhiteText.copyWith(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  rightChild: RotatedBox(
                    quarterTurns: 3,
                    child: Center(
                      child: Text(
                        'Rs: ${booking.totalAmount!.toInt()}',
                        style: kH4.copyWith(color: kWhiteColor),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SvgPicture.asset('assets/images/Eyes-cuate.svg'),
                SvgPicture.asset(
                  'assets/images/girlblow.svg',
                  width: 350,
                ),
                Text('There are no bookings yet.', style: kGreyText),
              ],
            ),
          );
        }
      }),
    );
  }
}
