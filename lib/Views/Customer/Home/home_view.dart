import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Controllers/salon_controller.dart';
import 'package:barber/Controllers/user_controller.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:barber/Views/Auth/signup_view.dart';
import 'package:barber/Views/Widgets/loginnow_box.dart';
import 'package:barber/Views/Widgets/mycontainer.dart';
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
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topLeft,
                image: AssetImage('assets/backgroundblur.png'),
                fit: BoxFit.fitWidth)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text('Welcome to Barberia',
                    style: kH1.copyWith(color: kDarkBlueColor)),
                const SizedBox(height: 4),
                const Text(
                    'This is an application for you to book salon services online'),
                const SizedBox(height: 20),
                MyContainer(
                    isShadow: true,
                    color: kFadedColor,
                    hPadding: 15,
                    vPadding: 10,
                    radius: 12,
                    child: Row(
                      children: const [
                        Text('Search', style: kBoldText),
                        Spacer(),
                        Icon(Glyphicon.search)
                      ],
                    )),
                isSignedIn.value ? const SizedBox() : const LoginNowBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
