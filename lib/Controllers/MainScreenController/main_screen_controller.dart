import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Screens/FavoritesScreen/favorite_screen.dart';
import '../../Screens/HomeScreen/home_screen.dart';
import '../../Screens/NotificationScreen/notification_screen.dart';
import '../../Screens/SettingScreen/setting_screen.dart';

class MainScreenController extends GetxController {
  int currentIndex = 0;
  void changeCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    update();
  }

  List<Widget> bodies = const [
    HomeScreen(),
    FavoriteScreen(),
    NotificationScreen(),
    SettingScreen()
  ];
}
