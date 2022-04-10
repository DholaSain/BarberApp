import 'package:barber/Utils/global_variables.dart';
import 'package:barber/Views/Widgets/loginnow_box.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isSignedIn.value ? const SizedBox() : LoginNowBox(),
          ],
        ),
      ),
    );
  }
}
