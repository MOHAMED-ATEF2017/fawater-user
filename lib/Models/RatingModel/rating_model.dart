import 'dart:convert';

GetRatingsModel getRatingsModelFromJson(String str) => GetRatingsModel.fromJson(json.decode(str));


class GetRatingsModel {
    final List<RatingDatum> data;
    final String message;
    final int status;

    GetRatingsModel({
        required this.data,
        required this.message,
        required this.status,
    });

    factory GetRatingsModel.fromJson(Map<String, dynamic> json) => GetRatingsModel(
        data:json["Data"] == null ?[]: List<RatingDatum>.from(json["Data"].map((x) => RatingDatum.fromJson(x))),
        message: json["message"]??'',
        status: json["status"]??500,
    );
}

class RatingDatum {
    final String name;
    final String img;
    final String rating;
    final String comment;

    RatingDatum({
        required this.name,
        required this.img,
        required this.rating,
        required this.comment,
    });

    factory RatingDatum.fromJson(Map<String, dynamic> json) => RatingDatum(
        name: json["name"]??'',
        img: json["img"]??'',
        rating: json["rating"]??'',
        comment: json["comment"]??'',
    );

}
