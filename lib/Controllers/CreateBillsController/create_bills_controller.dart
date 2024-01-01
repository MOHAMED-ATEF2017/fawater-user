import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBillsController extends GetxController {
  TextEditingController dateController = TextEditingController();
  void changeDateController(String value) {
    dateController = TextEditingController(text: value);
    update();
  }
}
