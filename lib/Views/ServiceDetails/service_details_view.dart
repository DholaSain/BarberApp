import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Models/salon_model.dart';
import 'package:barber/Views/Widgets/mycontainer.dart';
import 'package:barber/Views/Widgets/net_image.dart';
import 'package:flutter/material.dart';

class ServiceDetailsView extends StatelessWidget {
  const ServiceDetailsView({Key? key, required this.service}) : super(key: key);
  final ServicesModel service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: kGreyColor.withOpacity(0.4),
                // width: double.infinity,
                height: 200,
                alignment: Alignment.center,
                child: NetImage(
                  imagePath: service.image ?? '',
                  boxfit: BoxFit.fitWidth,
                )),
            const SizedBox(height: 10),
            MyContainer(
                hMargin: 10,
                hPadding: 10,
                vPadding: 8,
                isShadow: true,
                color: kWhiteColor,
                radius: 10,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(service.name!, style: kH2),
                    const SizedBox(height: 4),
                    Text(service.shortDescription!),
                  ],
                )),
            const SizedBox(height: 20),
            MyContainer(
                hMargin: 10,
                hPadding: 10,
                vPadding: 8,
                isShadow: true,
                color: kWhiteColor,
                radius: 10,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description: ', style: kH3),
                    const SizedBox(height: 4),
                    Text(service.longDescription!),
                  ],
                )),
            const SizedBox(height: 20),
            MyContainer(
                hMargin: 10,
                hPadding: 10,
                vPadding: 8,
                isShadow: true,
                color: kWhiteColor,
                radius: 10,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(child: Text('Rs: ${service.price}', style: kH3)),
                    Expanded(
                        child: Text('Druation: ${service.duration} Mins',
                            style: kH3)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
