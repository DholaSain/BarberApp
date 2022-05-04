import 'package:barber/Models/booking_model.dart';
import 'package:barber/Services/db_services.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:get/get.dart';

class BookingsController extends GetxController {
  Rxn<List<BookingModel>> bookingsData = Rxn<List<BookingModel>>();

  List<BookingModel>? get bookings => bookingsData.value;

  @override
  void onInit() {
    if (isSignedIn.value) {
      bookingsData
          .bindStream(DBServices().bookingsStreamCustomer(userID.value));
    }
    super.onInit();
  }
}
