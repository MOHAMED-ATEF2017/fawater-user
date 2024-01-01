import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

class SignUpModel {
  final String error;
  final String status;
  final String message;
  final SignUpData data;

  SignUpModel({
    required this.error,
    required this.status,
    required this.message,
    required this.data,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        error: json["error"] ?? '',
        status: json["status"] ?? '',
        message: json["message"] ?? '',
        data: SignUpData.fromJson(json["data"] ?? {}),
      );
}

class SignUpData {
  final String name;
  final String email;
  final String phone;
  final String typeUser;
  final dynamic img;
  final int status;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  SignUpData({
    required this.name,
    required this.email,
    required this.phone,
    required this.typeUser,
    required this.img,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory SignUpData.fromJson(Map<String, dynamic> json) => SignUpData(
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        typeUser: json["type_user"] ?? '',
        img: json["img"] ?? '',
        status: json["Status"] ?? 500,
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );
}
