import 'package:barber/Constants/colors.dart';
import 'package:barber/Views/Barber/BAccount/b_account_view.dart';
import 'package:barber/Views/Barber/BBookings/b_booking_view.dart';
import 'package:barber/Views/Barber/BHome/b_home_view.dart';

import 'package:flutter/material.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class BLandingView extends StatefulWidget {
  const BLandingView({Key? key}) : super(key: key);

  @override
  State<BLandingView> createState() => _BLandingViewState();
}

class _BLandingViewState extends State<BLandingView> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buildScreens() {
      return [
        BHomeView(),
        BBookings(),
        BAccountView(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Glyphicon.shop_window),
          inactiveIcon: const Icon(Glyphicon.shop),
          title: ("Home"),
          activeColorPrimary: kMainColor,
          inactiveColorPrimary: kGreyColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Glyphicon.bag_fill),
          inactiveIcon: const Icon(Glyphicon.bag_dash),
          title: ("My Bookings"),
          activeColorPrimary: kMainColor,
          inactiveColorPrimary: kGreyColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Glyphicon.person_fill),
          inactiveIcon: const Icon(Glyphicon.person),
          title: ("Account"),
          activeColorPrimary: kMainColor,
          inactiveColorPrimary: kGreyColor,
        ),
      ];
    }

    return PersistentTabView(context,
        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: kWhiteColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn),
        screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.easeInCirc,
            duration: Duration(milliseconds: 200)),
        navBarStyle: NavBarStyle.style12);
  }
}
