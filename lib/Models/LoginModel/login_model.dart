import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));


class LoginModel {
    final bool success;
    final String message;
    final int status;
    final String token;
    final int userId;

    LoginModel({
        required this.success,
        required this.message,
        required this.status,
        required this.token,
        required this.userId,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"]??false,
        message: json["message"]??'',
        status: json["status"]??400,
        token: json["token"]??'',
        userId: json["user_id"]??0,
    );

}
