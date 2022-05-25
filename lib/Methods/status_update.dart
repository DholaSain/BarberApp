import 'package:barber/Services/db_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void statusUpdateDialogBox(BuildContext context, String description,
    String buttonName, String status, String bookingId) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Are you sure?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [Text(description)],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(buttonName),
              onPressed: () async {
                await DBServices().updateBookingStatus(bookingId, status);
                Navigator.of(context).pop();
                Get.back();
              },
            ),
          ],
        );
      });
}
