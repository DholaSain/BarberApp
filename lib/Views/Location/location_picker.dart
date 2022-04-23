import 'package:barber/Views/Widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationPickerView extends StatelessWidget {
  const LocationPickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LocationPickerView'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Needs Google Maps API'),
            const SizedBox(height: 20),
            DynamicHeavyButton(
                height: 40,
                isEnable: true.obs,
                ontap: () {
                  Map<String, String> data = {
                    'address': 'Gunj Bazar Mughalpura',
                    'city': 'Lahore',
                    'long': '31.5690',
                    'lat': '74.3586',
                  };
                  Get.back(result: data);
                },
                lable: 'Add Demo Location')
          ],
        ),
      ),
    );
  }
}
