import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Models/salon_model.dart';
import 'package:barber/Views/Widgets/net_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:glyphicon/glyphicon.dart';

class SalonCardFull extends StatelessWidget {
  const SalonCardFull({
    Key? key,
    required this.salon,
    required this.images,
    this.ontap,
    this.onLike,
  }) : super(key: key);

  final SalonModel salon;
  final List<dynamic> images;
  final VoidCallback? ontap;
  final Future<bool?> Function(bool)? onLike;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: kGreyColor,
                spreadRadius: -1,
                blurRadius: 2,
                offset: Offset(1, 1))
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: salon.name!,
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CarouselSlider(
                      items: images.map((image) {
                        return Builder(builder: (BuildContext context) {
                          return SizedBox(
                            width: double.infinity,
                            child: NetImage(imagePath: image),
                          );
                        });
                      }).toList(),
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1.0,
                      )),
                ),
              ),
            ),
            // const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(salon.name!,
                      maxLines: 1, overflow: TextOverflow.ellipsis, style: kH3),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(style: kGreyText, children: [
                              TextSpan(text: salon.streetAddress! + ', '),
                              TextSpan(text: salon.city),
                            ])),
                      ),
                      Icon(
                          salon.isMenSalon!
                              ? Glyphicon.gender_male
                              : Glyphicon.gender_female,
                          size: 20,
                          color: kMainColor),
                      const SizedBox(width: 4),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(salon.price.toString() + ' /' + salon.priceUnit,
                  //         maxLines: 1,
                  //         overflow: TextOverflow.ellipsis,
                  //         style: kBoldText),
                  //     // AvailableBadge(isAvailable: salon.isAvailable)
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
