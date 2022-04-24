import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Controllers/b_salon_controller.dart';
import 'package:barber/Models/salon_model.dart';
import 'package:barber/Views/Barber/Salon/add_service.dart';
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
  final BSalonController bSalonCntrlr = Get.find<BSalonController>();
  final CarouselController _controller = CarouselController();
  RxInt current = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (bSalonCntrlr.salons == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (bSalonCntrlr.salons!.isNotEmpty) {
            SalonModel salon = bSalonCntrlr.salons!
                .firstWhere((salon) => salonId == salon.uid);
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
                            return NetImage(
                              imagePath: image,
                              // boxfit: BoxFit.contain,
                            );
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
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                itemBuilder: (context, rat) => const Icon(
                                    Glyphicon.star_fill,
                                    color: Color(0xFFFFCA28))),
                            const SizedBox(width: 4),
                            Text(salon.rating.toString(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Get Direction', style: kBoldText),
                                  Text(salon.streetAddress!, style: kGreyText),
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
                      // const Divider(),
                      salon.services != null
                          ? salon.services!.isNotEmpty
                              ? ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
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
                                      visualDensity: const VisualDensity(
                                          horizontal: 0, vertical: -2),
                                      leading: SizedBox(
                                        width: 60,
                                        height: 60,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: NetImage(
                                              imagePath: service.image ?? ''),
                                        ),
                                      ),
                                      title:
                                          Text(service.name!, style: kBoldText),
                                      subtitle: Text(service.shortDescription!),
                                      trailing: Text(
                                          'Rs: ' + service.price.toString()),
                                    );
                                  },
                                )
                              : const Text('This salon has no Service yet')
                          : const SizedBox(),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AddServiceView(salonId: salon.uid!));
                        },
                        child: MyContainer(
                          color: kMainFadedColor,
                          vPadding: 10,
                          hPadding: 12,
                          radius: 12,
                          isShadow: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Add Service  ', style: kH3),
                              Icon(Glyphicon.node_plus)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            );
          } else {
            return const Center(
              child: Text('No data found.'),
            );
          }
        }),
      ),
    );
  }
}
