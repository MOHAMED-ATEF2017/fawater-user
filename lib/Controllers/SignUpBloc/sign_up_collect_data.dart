import 'dart:io';

import 'package:dio/dio.dart';


class SignUpCollectData {
  String? name, phone, email, password, confirmPassword;
  File? image;
  SignUpCollectData({
    this.confirmPassword,
    this.email,
    this.image,
    this.name,
    this.password,
    this.phone,
  });

  Map<String, dynamic> toJson() => {
    "type_user":1,
    "name":name,
    "phone":phone,
    "email":email,
    "password":password,
    "c_password":confirmPassword,
    'img': image == null ? null : MultipartFile.fromFileSync(image!.path)
  };
}
