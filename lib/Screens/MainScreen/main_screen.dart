// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/MainScreenController/main_screen_controller.dart';
import '../../Modules/MainScreenModules/bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainScreenController>(
      init: MainScreenController(),
      builder: (_) {
        return Scaffold(
          body:_.bodies[_.currentIndex],
            bottomNavigationBar: MainScreenBottomNavigationBar(
          controller: _,
        ));
      },
    );
  }
}

