import 'package:barber/Models/salon_model.dart';
import 'package:barber/Services/db_services.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:get/get.dart';

class BSalonController extends GetxController {
  Rxn<List<SalonModel>> salonsData = Rxn<List<SalonModel>>();

  List<SalonModel>? get salons => salonsData.value;

  @override
  void onInit() {
    if (isSignedIn.value) {
      // salonsData.bindStream(DBServices().streamOwnerSalons(userID.value));
      salonsData.bindStream(
          Stream.fromFuture(DBServices().getSalonOfOwner(userID.value)));
    }

    super.onInit();
  }
}
