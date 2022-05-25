import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Controllers/b_salon_controller.dart';
import 'package:barber/Views/Barber/Salon/add_salon.dart';
import 'package:barber/Views/Barber/Salon/b_salon_details.dart';
import 'package:barber/Views/Widgets/buttons.dart';
import 'package:barber/Views/Widgets/salon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BHomeView extends StatelessWidget {
  BHomeView({Key? key}) : super(key: key);
  final BSalonController bSalonCntrlr = Get.put(BSalonController());
  @override
  Widget build(BuildContext context) {
    // getCollectionData();
    return Scaffold(
      appBar: AppBar(title: const Text('My Salons')),
      body: Obx(() {
        if (bSalonCntrlr.salons == null) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (bSalonCntrlr.salons!.isNotEmpty) {
          return Column(
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: bSalonCntrlr.salons!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SalonCardFull(
                          salon: bSalonCntrlr.salons![index],
                          images: bSalonCntrlr.salons![index].images!,
                          ontap: () {
                            Get.to(() => BSalonDetails(
                                salonId: bSalonCntrlr.salons![index].uid!));
                          }),
                    );
                  }),
              Container(
                margin: const EdgeInsets.all(15),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [kMainColor, Color(0xFF006B9D)],
                  ),
                ),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => AddSalonView());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('assets/pattern1.png'),
                            opacity: 0.15,
                            fit: BoxFit.cover),
                        color: kMainColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: kWhiteColor,
                      ),
                      child: const Text(
                        'Add another Salon',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
              ),
              SvgPicture.asset(
                'assets/closedshop.svg',
                height: 350,
              ),
              const Text('You don\'t have any salon yet', style: kGreyText),
              const SizedBox(height: 20),
              DynamicHeavyButton(
                  height: 40,
                  isEnable: true.obs,
                  ontap: () {
                    Get.to(() => AddSalonView());
                  },
                  lable: 'Add a Salon'),
              const SizedBox(height: 40),
            ],
          );
        }
      }),
    );
  }
}

// Future<void> getCollectionData() async {
//   await FirebaseFirestore.instance
//       .collectionGroup('testsub')
//       .get()
//       .then((QuerySnapshot snapshot) {
//     final docs = snapshot.docs;
//     for (var data in docs) {
//       print(data.data());
//       print(data.reference);
//     }
//   });
// }


