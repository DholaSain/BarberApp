import 'package:barber/Constants/colors.dart';
import 'package:barber/Views/Account/account_view.dart';
import 'package:barber/Views/Favorites/favt_view.dart';
import 'package:barber/Views/Home/home_view.dart';
import 'package:barber/Views/Inbox/inbox_view.dart';
import 'package:flutter/material.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final isSigned = false;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buildScreens() {
      return [
        HomeView(),
        FavtView(),
        InboxView(),
        AccountView(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Glyphicon.house_fill),
          inactiveIcon: const Icon(Glyphicon.house),
          title: ("Home"),
          activeColorPrimary: kMainColor,
          inactiveColorPrimary: kGreyColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Glyphicon.suit_heart_fill),
          inactiveIcon: const Icon(Glyphicon.suit_heart),
          title: ("Wishlist"),
          activeColorPrimary: kMainColor,
          inactiveColorPrimary: kGreyColor,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Glyphicon.inbox_fill),
          inactiveIcon: const Icon(Glyphicon.inbox),
          title: ("Inbox"),
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
        // decoration: NavBarDecoration(
        //     borderRadius: BorderRadius.circular(20.0),
        //     colorBehindNavBar: kWhiteColor),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn),
        screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 200)),
        navBarStyle: NavBarStyle.style12);
  }
}
