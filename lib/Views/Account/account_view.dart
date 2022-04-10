import 'package:barber/Constants/colors.dart';
import 'package:barber/Constants/text_styles.dart';
import 'package:barber/Controllers/auth_controller.dart';
import 'package:barber/Controllers/user_controller.dart';
import 'package:barber/Utils/global_variables.dart';
import 'package:barber/Views/Auth/login_view.dart';
import 'package:barber/Views/UserProfile/view_n_edit.dart';
import 'package:barber/Views/Widgets/buttons.dart';
import 'package:barber/Views/Widgets/user_circular_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glyphicon/glyphicon.dart';

class AccountView extends StatelessWidget {
  AccountView({Key? key}) : super(key: key);
  final AuthController authController = Get.find<AuthController>();
  final UsersController userCntlrl = Get.find<UsersController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kTransparent,
          elevation: 0,
          iconTheme: iconTheme,
          actions: [
            isSignedIn.value
                ? IconButton(
                    onPressed: () async {
                      await authController.logout();
                    },
                    icon: const Icon(Icons.logout))
                : Container()
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isSignedIn.value
                  ? userWidgets()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Your Profile', style: kH1),
                        const Text(' Log in to use Barberia services.',
                            style: kGreyText),
                        const SizedBox(height: 30),
                        DynamicHeavyButton(
                          isEnable: true.obs,
                          ontap: () {
                            Get.to(() => LoginView());
                          },
                          lable: 'Log in',
                          width: double.infinity,
                          height: 45,
                        ),
                      ],
                    ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              const Text('Support', style: kH1),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {},
                title: const Text('How Barberia works'),
                leading: const Icon(Icons.home_work_rounded),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                title: const Text('Contact Support'),
                leading: const Icon(Icons.support_agent_rounded),
                subtitle: const Text(
                    'Let our team know about concerns related to Barber activities in your area.'),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              const Divider(),
              ListTile(
                onTap: () {},
                title: const Text('Give us feedback'),
                leading: const Icon(Icons.edit_outlined),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget userWidgets() {
    // final user = userCntlrl.user;
    return Obx(
      () => userCntlrl.user!.isBarber!
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BusinessCircularImage(
                  radius: 40,
                  imageURL: userCntlrl.user?.profileImage,
                ),
                const SizedBox(height: 15),
                userCntlrl.user != null
                    ? Text(userCntlrl.user!.businessName!, style: kH1)
                    : const Text(''),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Get.to(() => ViewAndEditProfile());
                    // Get.to(() => UserProfileView(), binding: MyProductBinding());
                  },
                  child: const Text(
                    'View profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const ListTile(
                  leading: Icon(Glyphicon.globe),
                  title: Text('Earn more with our Online platform, Barberia'),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 20),
                const Text('Services', style: kH1),
                const SizedBox(height: 20),
                ListTile(
                  onTap: () {
                    // Get.to(() => Orders(), binding: OrdersBining());
                  },
                  title: const Text('My Services'),
                  leading: const Icon(Icons.line_style_rounded),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    // Get.to(() => ForRentProdcuts(), binding: MyProductBinding());
                  },
                  title: const Text('Bookings'),
                  leading: const Icon(Icons.view_list_rounded),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    // Get.to(() => MyRentProducts(), binding: CustomersOrdersBining());
                  },
                  title: const Text('Add New Service'),
                  leading: const Icon(Icons.real_estate_agent_sharp),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserCircularImage(
                  radius: 60,
                  imageURL: userCntlrl.user?.profileImage,
                ),
                const SizedBox(height: 6),
                userCntlrl.user != null
                    ? Text(
                        '${userCntlrl.user?.firstName} ${userCntlrl.user?.lastName}',
                        style: kH1)
                    : const Text(''),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Get.to(() => ViewAndEditProfile());
                  },
                  child: const Text(
                    'View profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const ListTile(
                  leading: Icon(Glyphicon.globe),
                  title:
                      Text('Find & reserve Best Barber in your area, Online.'),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 20),
                const Text('Services', style: kH1),
                const SizedBox(height: 20),
                ListTile(
                  onTap: () {
                    // Get.to(() => ForRentProdcuts(), binding: MyProductBinding());
                  },
                  title: const Text('Bookings'),
                  leading: const Icon(Icons.view_list_rounded),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
    );
  }
}
