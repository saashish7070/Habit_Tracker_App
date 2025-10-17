
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class BottomNavBar {
  static final PersistentTabController controller = PersistentTabController(initialIndex: 0);

  static List<PersistentBottomNavBarItem> items(){
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.calendar_today_rounded),title: "Today",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        iconSize: 24
        ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add_box_rounded),title: "Add",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        iconSize: 24
        ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.file_copy),title: "Habits",
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
        iconSize: 24
        )  
    ];
  }
}