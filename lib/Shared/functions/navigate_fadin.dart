import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavigation {
  static Future<dynamic>? fadeInGetOffAllNavigateFunction(Widget screenName) =>
      Get.offAll(screenName,
          duration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn);
  static Future<dynamic>? fadeInGetToNavigateFunction(Widget screenName) =>
      Get.to(screenName,
          duration: const Duration(milliseconds: 350),
          transition: Transition.fadeIn);
}
