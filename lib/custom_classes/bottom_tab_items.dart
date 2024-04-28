import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pristine_seeds/view/dash_view/dash_board_screen.dart';
import 'package:pristine_seeds/view/menu_view/menu_view_screen.dart';
import 'package:pristine_seeds/view/notification_view/notification_view_screen.dart';
import 'package:pristine_seeds/view/profile_view/profile_view_screen.dart';

class BottomTabItems{
  //List<TabItem> items = [];
  List<TabItem> items = [];

  //tab index
  int visit = 0;

  //tab pages
  List<Widget> allBottomPages = [
    DashBoardScreen(),
    MenuScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];
  final itemst = <Widget>[
    Icon(Icons.dashboard, size: 30),
    Icon(Icons.menu, size: 30),
    Icon(Icons.notifications, size: 30),
    Icon(Icons.person, size: 30),

  ];

  //tabs icons and titles
  List<TabItem> allTabs() {
    return items = [
      TabItem(
        icon: Icons.home,
        title: 'Dash',
      ),
      TabItem(
        icon: Icons.menu,
        title: 'Menu',
      ),
      TabItem(
        icon: Icons.notifications,
        title: 'notification',
      ),
      TabItem(
        icon: Icons.person,
        title: 'Profile',
      ),

    ];
  }
}