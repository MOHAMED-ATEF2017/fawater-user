import 'dart:io';

import 'package:dio/dio.dart';

class UpdateProfileCollectData {
   String? userId, name, idNationalities, phoneNumber, email;
   File? image;

  UpdateProfileCollectData(
      {this.userId,
      this.image,
      this.name,
      this.idNationalities,
      this.phoneNumber,
      this.email});

  Map<String, dynamic> mapToJson() => {
        'user_id': userId,
        'name': name,
        'id_nationalities': idNationalities,
        'phone': phoneNumber,
        'email': email,
        'img':
            image == null ? null : MultipartFile.fromFileSync(image!.path),
      };
}
