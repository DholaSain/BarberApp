import 'dart:developer';
import 'dart:io';

import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Controllers/b_salon_controller.dart';
import 'package:barber/Methods/overlays.dart';
import 'package:barber/Methods/validator.dart';
import 'package:barber/Models/salon_model.dart';
import 'package:barber/Services/db_services.dart';
import 'package:barber/Services/storage_service.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:barber/Utils/image_picker.dart';
import 'package:barber/Views/Location/location_picker.dart';
import 'package:barber/Views/Widgets/buttons.dart';
import 'package:barber/Views/Widgets/mycontainer.dart';
import 'package:barber/Views/Widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:group_radio_button/group_radio_button.dart';

class AddSalonView extends StatelessWidget {
  AddSalonView({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  RxBool isHomeService = false.obs;
  RxBool isMenSalon = true.obs;
  RxString address = ''.obs;
  RxString city = ''.obs;
  RxString long = ''.obs;
  RxString lat = ''.obs;
  RxList<String> images = <String>[].obs;

  final _formKey = GlobalKey<FormState>();
  RxBool isEnable = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Salon'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              MyContainer(
                  hPadding: 10,
                  vPadding: 10,
                  width: double.infinity,
                  isShadow: true,
                  color: kWhiteColor,
                  radius: 12,
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Row(
                          children: [
                            Text('Salon Images 1 - 8 (${images.length})',
                                style: kH3),
                            const Spacer(),
                            const Icon(Glyphicon.images)
                          ],
                        ),
                        onTap: () async {
                          int totalImages = images.length;
                          if (totalImages < 8) {
                            log('photos');
                            String paths =
                                await ImagePickerService().imageFromGellery();
                            if (paths != '') {
                              images.add(paths);
                              checkValidity();
                            }
                          } else {
                            Get.snackbar('Warning',
                                'You\'ve selected maximum images\nTo change image, click on image and remove.',
                                backgroundColor: kWhiteColor);
                          }
                        },
                      ),
                      const Divider(),
                      Container(
                          alignment: Alignment.center,
                          height: 100,
                          child: Obx(() => images.isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: images.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(
                                            SafeArea(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                        leading: const Icon(
                                                            Icons.delete),
                                                        onTap: () {
                                                          images.remove(
                                                              images[index]);
                                                          checkValidity();
                                                          Get.back();
                                                        },
                                                        title: const Text(
                                                            "Remove")),
                                                    const Divider(),
                                                    ListTile(
                                                        leading: const Icon(
                                                            Icons.close),
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        title: const Text(
                                                            "Cancel"))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            elevation: 20.0,
                                            enableDrag: true,
                                            backgroundColor: Colors.white,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30.0),
                                              topRight: Radius.circular(30.0),
                                            )));
                                      },
                                      child: Container(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          width: 120,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                                File(images[index]),
                                                fit: BoxFit.cover),
                                            // child: NetImage(imagePath: oldImages[index]),
                                          )),
                                    );
                                  })
                              : const Text('Please Select at least 1 image'))),
                    ],
                  )),
              const SizedBox(height: 20),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextAirField(
                        title: 'Name',
                        controlller: nameController,
                        validators: requiredValidator,
                        onchange: (value) {
                          checkValidity();
                        },
                      ),
                      const SizedBox(height: 20),
                      TextAirField(
                          title: 'Description',
                          hintText: 'Add a description about your salon',
                          controlller: descController,
                          validators: requiredValidator,
                          onchange: (a) {
                            checkValidity();
                          },
                          lines: 4),
                    ],
                  )),
              const SizedBox(height: 20),
              Obx(() => GestureDetector(
                    onTap: () async {
                      final result =
                          await Get.to(() => const LocationPickerView());
                      try {
                        address.value = result['address'];
                        city.value = result['city'];
                        long.value = result['long'];
                        lat.value = result['lat'];
                        checkValidity();
                      } catch (e) {
                        Get.snackbar('Failed', 'Location Failed',
                            backgroundColor: kWhiteColor,
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    child: MyContainer(
                        width: double.infinity,
                        isShadow: true,
                        color: kWhiteColor,
                        radius: 12,
                        hPadding: 10,
                        vPadding: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Location', style: kH3),
                            const Divider(),
                            address.value == ''
                                ? const Text('Click to Pick Location')
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Address: ${address.value}'),
                                      Text('City: ${city.value}'),
                                      Text(
                                          'Longitude: ${long.value}, Latitude: ${lat.value}')
                                    ],
                                  )
                          ],
                        )),
                  )),
              const SizedBox(height: 20),
              Obx(() => MyContainer(
                    width: double.infinity,
                    isShadow: true,
                    color: kWhiteColor,
                    radius: 12,
                    child: CheckboxListTile(
                        title: const Text('Home Service? '),
                        activeColor: kMainColor,
                        value: isHomeService.value,
                        onChanged: (value) {
                          isHomeService.value = value!;
                        }),
                  )),
              const SizedBox(height: 20),
              Obx(() => MyContainer(
                    width: double.infinity,
                    isShadow: true,
                    color: kWhiteColor,
                    radius: 12,
                    child: ListTile(
                      title: const Text('Salon for?'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioButton(
                              activeColor: kMainColor,
                              description: 'Male',
                              value: true,
                              groupValue: isMenSalon.value,
                              onChanged: (value) {
                                isMenSalon.value = value as bool;
                              }),
                          RadioButton(
                              activeColor: kMainColor,
                              description: 'Female',
                              value: false,
                              groupValue: isMenSalon.value,
                              onChanged: (value) {
                                isMenSalon.value = value as bool;
                              }),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: DynamicHeavyButton(
            isEnable: isEnable,
            ontap: () async {
              loadingOverlay('Saving');
              try {
                List<String> imagesURLs = [];
                for (var i = 0; i < images.length; i++) {
                  String url = await StorageService()
                      .imgageUpload('Salons/${userID.value}/', images[i]);
                  imagesURLs.add(url);
                  url = '';
                }
                SalonModel salonModel = SalonModel(
                  name: nameController.text,
                  description: descController.text,
                  streetAddress: address.value,
                  city: city.value,
                  latitude: lat.value,
                  longitude: long.value,
                  images: imagesURLs,
                  isHomeService: isHomeService.value,
                  isMenSalon: isMenSalon.value,
                );
                await DBServices().addNewSalon(salonModel);
                Get.back();
                Get.find<BSalonController>().onInit();
                Get.back();
              } catch (e) {
                Get.back();
                errorOverlay(e.toString());
                log(e.toString());
              }
            },
            lable: 'Add Salon'),
      )),
    );
  }

  void checkValidity() {
    if (nameController.text.isNotEmpty &&
        descController.text.isNotEmpty &&
        address.value.isNotEmpty &&
        images.isNotEmpty) {
      log('valid');
      isEnable.value = true;
    } else {
      isEnable.value = false;
      log('invalid');
    }
  }
}
