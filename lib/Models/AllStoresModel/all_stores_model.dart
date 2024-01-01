import 'dart:convert';

AllStoresModel allStoresModelFromJson(String str) =>
    AllStoresModel.fromJson(json.decode(str));

class AllStoresModel {
  final List<AllStoresDatum> data;
  final String message;
  final int status;

  AllStoresModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory AllStoresModel.fromJson(Map<String, dynamic> json) => AllStoresModel(
        data: json["Data"] == null
            ? []
            : List<AllStoresDatum>.from(
                json["Data"].map((x) => AllStoresDatum.fromJson(x ?? {}))),
        message: json["message"] ?? '',
        status: json["status"] ?? 500,
      );
}

class AllStoresDatum {
  final int id;
  final String store;
  final String img;
  final String address;
  final String latitude;
  final String longitude;
  final String phone;

  AllStoresDatum({
    required this.id,
    required this.store,
    required this.img,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
  });

  factory AllStoresDatum.fromJson(Map<String, dynamic> json) => AllStoresDatum(
        id: json["id"]??0,
        store: json["store"]??'',
        img: json["img"]??'',
        address: json["address"]??'',
        latitude: json["latitude"]??'',
        longitude: json["longitude"]??'',
        phone: json["phone"]??'',
      );
}
