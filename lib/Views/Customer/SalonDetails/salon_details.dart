import 'package:badges/badges.dart';
import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/services.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Controllers/salon_controller.dart';
import 'package:barber/Models/salon_model.dart';
import 'package:barber/Views/Customer/Checkout/checkout.dart';
import 'package:barber/Views/ServiceDetails/service_details_view.dart';
import 'package:barber/Views/Widgets/mycontainer.dart';
import 'package:barber/Views/Widgets/net_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:url_launcher/url_launcher.dart';

class SalonDetails extends StatelessWidget {
  SalonDetails({Key? key, required this.salonId}) : super(key: key);
  final String salonId;
  final SalonsController salonsCntrlr = Get.find<SalonsController>();
  final CarouselController _controller = CarouselController();
  RxInt current = 0.obs;
  RxList<ServicesModel> servicesCart = <ServicesModel>[].obs;
  RxDouble totalAmount = 0.0.obs;
  late int serviceType;
  late String ownerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          elevation: 0,
          actions: [
            Obx(() => IconButton(
                onPressed: () async {
                  bool? retVal;
                  servicesCart.isNotEmpty
                      ? retVal = await Get.to(() => CheckOutView(
                            servicesCart: servicesCart,
                            serviceType: serviceType,
                            salonId: salonId,
                            ownerId: ownerId,
                          ))
                      : Get.snackbar(
                          'Warning', 'Please select some services before',
                          backgroundColor: kWhiteColor);

                  if (retVal != null && retVal) {
                    servicesCart.value = [];
                  }
                },
                icon: Badge(
                    showBadge: servicesCart.isNotEmpty ? true : false,
                    badgeContent:
                        Text(servicesCart.length.toString(), style: kWhiteText),
                    child: Icon(Glyphicon.cart3,
                        color:
                            servicesCart.isEmpty ? kGreyColor : kWhiteColor))))
          ],
        ),
        body: SingleChildScrollView(child: Obx(() {
          if (salonsCntrlr.salons == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (salonsCntrlr.salons!.isNotEmpty) {
            SalonModel salon = salonsCntrlr.salons!
                .firstWhere((salon) => salonId == salon.uid);
            serviceType = salon.serviceType!;
            ownerId = salon.ownerId!;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: salon.name!,
                    child: SizedBox(
                      height: 280,
                      width: 500,
                      child: CarouselSlider(
                          carouselController: _controller,
                          items: salon.images!.map((image) {
                            return Builder(builder: (BuildContext context) {
                              return NetImage(imagePath: image);
                            });
                          }).toList(),
                          options: CarouselOptions(
                              autoPlay: true,
                              viewportFraction: 1,
                              aspectRatio: 6 / 4,
                              onPageChanged: (index, reason) {
                                current.value = index;
                              })),
                    ),
                  ),
                  Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: salon.images!.asMap().entries.map((entry) {
                        return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(current.value == entry.key
                                            ? 0.9
                                            : 0.4))));
                      }).toList())),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(salon.name!, style: kH2),
                            const SizedBox(height: 8),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingBarIndicator(
                                      rating: salon.rating!,
                                      itemSize: 20,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      itemBuilder: (context, rat) => const Icon(
                                          Glyphicon.star_fill,
                                          color: Color(0xFFFFCA28))),
                                  const SizedBox(width: 4),
                                  Text(salon.rating.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ]),
                            const Divider(),
                            GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse(
                                    'https://www.google.com/maps/search/?api=1&query=${salon.latitude},${salon.longitude}'));
                              },
                              child: MyContainer(
                                color: kWhiteColor,
                                vPadding: 8,
                                hPadding: 12,
                                // margin: 5,
                                radius: 8,
                                isShadow: true,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Get Direction',
                                            style: kBoldText),
                                        Text(salon.streetAddress!,
                                            style: kGreyText),
                                      ],
                                    )),
                                    const Icon(Glyphicon.map)
                                  ],
                                ),
                              ),
                            ),
                            const Divider(),
                            Text(salon.description!),
                            const Divider(),
                            const Text('Services:', style: kH3),
                            salon.services != null
                                ? salon.services!.isNotEmpty
                                    ? ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            const Divider(),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: salon.services!.length,
                                        itemBuilder: (context, index) {
                                          ServicesModel service =
                                              salon.services![index];

                                          return ListTile(
                                              onTap: () {
                                                Get.to(() => ServiceDetailsView(
                                                    service: service));
                                              },
                                              contentPadding: EdgeInsets.zero,
                                              horizontalTitleGap: 10,
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: 0,
                                                      vertical: -2),
                                              leading: SizedBox(
                                                width: 60,
                                                height: 60,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  child: NetImage(
                                                      imagePath:
                                                          service.image ?? ''),
                                                ),
                                              ),
                                              title: Text(service.name!,
                                                  style: kBoldText),
                                              subtitle: Text('Rs: ' +
                                                  service.price.toString()),
                                              trailing: Obx(() => Checkbox(
                                                  checkColor: kWhiteColor,
                                                  activeColor: kMainColor,
                                                  value: servicesCart
                                                      .contains(service),
                                                  onChanged: (value) {
                                                    servicesCart
                                                            .contains(service)
                                                        ? servicesCart
                                                            .remove(service)
                                                        : servicesCart
                                                            .add(service);
                                                    double total = 0.0;
                                                    for (var element
                                                        in servicesCart) {
                                                      total = total +
                                                          element.price!;
                                                    }
                                                    totalAmount.value = total;
                                                  })));
                                        })
                                    : const Text(
                                        'This salon has no Service yet')
                                : const SizedBox(),
                            const Divider()
                          ])),
                  const SizedBox(height: 40)
                ]);
          } else {
            return const Center(child: Text('No data found.'));
          }
        })),
        bottomNavigationBar: SafeArea(
            child: MyContainer(
                color: kMainColor,
                height: 30,
                child: Center(
                    child: Obx(() => Text(
                          'Total: Rs. ' + totalAmount.toStringAsFixed(1),
                          style: const TextStyle(color: kWhiteColor),
                        ))))));
  }
}
