import 'package:barber/Binding/bindings.dart';
import 'package:barber/Controllers/user_controller.dart';
import 'package:barber/Views/Barber/BLandingView/b_landing_view.dart';
import 'package:barber/Views/Customer/Landing/landing_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final UsersController userCntrlr = Get.find<UsersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (userCntrlr.user == null) {
          Future.delayed(const Duration(seconds: 1)).then((value) =>
              Get.off(() => const LandingView(), binding: InitBinding()));
          return Center(child: Lottie.asset('assets/loadinggirl.json'));
        } else {
          Future.delayed(const Duration(seconds: 1)).then((value) =>
              userCntrlr.user!.isBarber!
                  ? Get.off(() => const BLandingView(), binding: InitBinding())
                  : Get.off(() => const LandingView(), binding: InitBinding()));
          return Center(child: Lottie.asset('assets/loadinggirl.json'));
        }
      }),
    );
  }
}
