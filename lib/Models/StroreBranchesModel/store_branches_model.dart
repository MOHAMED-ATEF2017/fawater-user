import 'dart:convert';

StoreBranchesModel storeBranchesModelFromJson(String str) => StoreBranchesModel.fromJson(json.decode(str));


class StoreBranchesModel {
    final List<StoreBranchesDatum> data;
    final String message;
    final int status;

    StoreBranchesModel({
        required this.data,
        required this.message,
        required this.status,
    });

    factory StoreBranchesModel.fromJson(Map<String, dynamic> json) => StoreBranchesModel(
        data:json["Data"]==null ? []: List<StoreBranchesDatum>.from(json["Data"].map((x) => StoreBranchesDatum.fromJson(x))),
        message: json["message"]??'',
        status: json["status"]??500,
    );

}

class StoreBranchesDatum {
    final int id;
    final String branch;
    final String address;
    final String latitude;
    final String longitude;

    StoreBranchesDatum({
        required this.id,
        required this.branch,
        required this.address,
        required this.latitude,
        required this.longitude,
    });

    factory StoreBranchesDatum.fromJson(Map<String, dynamic> json) => StoreBranchesDatum(
        id: json["id"]??0,
        branch: json["branch"]??'',
        address: json["address"]??'',
        latitude: json["latitude"]??'',
        longitude: json["longitude"]??'',
    );

}
