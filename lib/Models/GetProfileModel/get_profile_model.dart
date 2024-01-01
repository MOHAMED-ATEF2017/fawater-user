import 'dart:convert';

GetProfileModel getProfileModelFromJson(String str) => GetProfileModel.fromJson(json.decode(str));


class GetProfileModel {
    final List<GetProfileDatum> data;
    final String message;
    final int status;

    GetProfileModel({
        required this.data,
        required this.message,
        required this.status,
    });

    factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
        data:json["Data"]==null ?[]: List<GetProfileDatum>.from(json["Data"].map((x) => GetProfileDatum.fromJson(x))),
        message: json["message"]??'',
        status: json["status"]??400,
    );
}

class GetProfileDatum {
    final int id;
    final String name;
    final String email;
    final String phone;
    final String img;

    GetProfileDatum({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.img,
    });

    factory GetProfileDatum.fromJson(Map<String, dynamic> json) => GetProfileDatum(
        id: json["id"]??0,
        name: json["name"]??'',
        email: json["email"]??'',
        phone: json["phone"]??'',
        img: json["img"]??'',
    );

}
