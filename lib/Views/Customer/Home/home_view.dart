import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/services.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Controllers/salon_controller.dart';
import 'package:barber/Controllers/user_controller.dart';
import 'package:barber/Models/salon_model.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:barber/Views/Customer/SalonDetails/salon_details.dart';
import 'package:barber/Views/Widgets/loginnow_box.dart';
import 'package:barber/Views/Widgets/mycontainer.dart';
import 'package:barber/Views/Widgets/salon_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glyphicon/glyphicon.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final UsersController userContrlr = Get.find<UsersController>();
  final SalonsController salonsCntrlr = Get.put(SalonsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topLeft, image: AssetImage('assets/backgroundblur.png'), fit: BoxFit.fitWidth)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text('Welcome to Barberia', style: kH1.copyWith(color: kDarkBlueColor)),
                const SizedBox(height: 4),
                const Text('This is an application for you to book salon services online'),
                const SizedBox(height: 20),
                MyContainer(
                    isShadow: true,
                    color: kFadedColor,
                    hPadding: 15,
                    vPadding: 10,
                    radius: 12,
                    child: Row(
                      children: const [Text('Search', style: kBoldText), Spacer(), Icon(Glyphicon.search)],
                    )),
                const SizedBox(height: 20),
                Text('Categories', style: kBoldText.copyWith(fontSize: 22)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 35,
                  child: ListView.builder(
                    itemCount: serviceNamesList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Chip(
                          label: Text(serviceNamesList[index]),
                          backgroundColor: kWhiteColor,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text('Salons', style: kBoldText.copyWith(fontSize: 22)),
                const SizedBox(height: 10),
                Obx(() {
                  if (salonsCntrlr.salons == null) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  } else if (salonsCntrlr.salons!.isNotEmpty) {
                    return MediaQuery.removePadding(
                        removeTop: true,
                        removeLeft: true,
                        removeRight: true,
                        context: context,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: salonsCntrlr.salons!.length,
                          itemBuilder: (context, index) {
                            final SalonModel salon = salonsCntrlr.salons![index];
                            return SalonCardFull(
                              salon: salon,
                              images: salon.images!,
                              ontap: () {
                                Get.to(() => SalonDetails(salonId: salon.uid!));
                              },
                            );
                          },
                        ));
                  } else {
                    return const Center(
                      child: Text('No data found.'),
                    );
                  }
                }),
                isSignedIn.value ? const SizedBox() : const LoginNowBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
