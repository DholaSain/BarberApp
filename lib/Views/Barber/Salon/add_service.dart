import 'dart:developer';
import 'dart:io';

import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/services.dart';
import 'package:barber/Controllers/b_salon_controller.dart';
import 'package:barber/Methods/overlays.dart';
import 'package:barber/Methods/validator.dart';
import 'package:barber/Models/salon_model.dart';
import 'package:barber/Services/db_services.dart';
import 'package:barber/Services/storage_service.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:barber/Utils/image_picker.dart';
import 'package:barber/Views/Widgets/buttons.dart';
import 'package:barber/Views/Widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glyphicon/glyphicon.dart';

class AddServiceView extends StatelessWidget {
  AddServiceView({Key? key, required this.salonId}) : super(key: key);
  final String salonId;
  final RxBool isEnable = false.obs;
  final RxString image = ''.obs;
  final RxString serviceName = ''.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sDesController = TextEditingController();
  final TextEditingController lDesController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Service')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                image.value = await ImagePickerService().imageFromGellery();
              },
              child: Container(
                  color: kGreyColor.withOpacity(0.4),
                  width: double.infinity,
                  height: 200,
                  alignment: Alignment.center,
                  child: Obx(() => image.value != ''
                      ? SizedBox(
                          width: double.infinity,
                          child:
                              Image.file(File(image.value), fit: BoxFit.cover))
                      : const Icon(Glyphicon.image, size: 40))),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          DropDownField(
                              listOfSelection: serviceNamesList,
                              onchange: (val) {
                                serviceName.value = val ?? '';
                                nameController.text = val ?? '';
                                checkValidity();
                              },
                              // validators: requiredValidator,
                              hint: 'Select Service',
                              title: 'Service Name'),
                          Obx(
                            () => serviceName.value == serviceNamesList.last
                                ? Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      TextAirField(
                                        title: 'Name',
                                        lines: 1,
                                        controlller: nameController,
                                        validators: requiredValidator,
                                        onchange: (a) {
                                          checkValidity();
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                          ),
                          const SizedBox(height: 10),
                          TextAirField(
                              title: 'Short Description',
                              controlller: sDesController,
                              validators: requiredValidator,
                              onchange: (a) {
                                checkValidity();
                              },
                              lines: 2),
                          const SizedBox(height: 10),
                          TextAirField(
                              title: 'Long Description',
                              controlller: lDesController,
                              validators: requiredValidator,
                              onchange: (a) {
                                checkValidity();
                              },
                              lines: 4),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextAirField(
                                  title: 'Duration',
                                  validators: requiredValidator,
                                  controlller: durationController,
                                  prefix: 'Minutes: ',
                                  inputType: TextInputType.number,
                                  onchange: (a) {
                                    checkValidity();
                                  },
                                  formater: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextAirField(
                                  title: 'Price',
                                  validators: requiredValidator,
                                  controlller: priceController,
                                  prefix: 'Rs: ',
                                  inputType: TextInputType.number,
                                  onchange: (a) {
                                    checkValidity();
                                  },
                                  formater: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: DynamicHeavyButton(
          lable: 'Add Service',
          horizontalMargin: 15,
          verticalMargin: 8,
          isEnable: isEnable,
          onDisableTap: () {
            _formKey.currentState?.validate();
          },
          ontap: () async {
            loadingOverlay('Saving');
            String imageUrl = '';
            if (image.value != '') {
              imageUrl = await StorageService().imgageUpload(
                  'Salons/${userID.value}/Services/', image.value);
            }
            ServicesModel servicesModel = ServicesModel(
              name: nameController.text,
              shortDescription: sDesController.text,
              longDescription: lDesController.text,
              image: imageUrl,
              duration: int.parse(durationController.text),
              price: double.parse(priceController.text),
            );
            await DBServices().addService(salonId, servicesModel);
            Get.back();
            Get.find<BSalonController>().onInit();
            Get.back();
          },
        ),
      ),
    );
  }

  void checkValidity() {
    if (nameController.text.isNotEmpty &&
        sDesController.text.isNotEmpty &&
        lDesController.text.isNotEmpty &&
        durationController.text.isNotEmpty &&
        priceController.text.isNotEmpty) {
      log('valid');
      isEnable.value = true;
    } else {
      isEnable.value = false;
      log('invalid');
    }
  }
}
