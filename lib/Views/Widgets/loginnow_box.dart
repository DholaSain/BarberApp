import 'package:barber/Constants/colors.dart';
import 'package:barber/Views/Auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoginNowBox extends StatelessWidget {
  const LoginNowBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login for more access',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: kWhiteColor),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Get.to(() => LoginView());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: kWhiteColor,
              ),
              child: const Text(
                'Log in now',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
