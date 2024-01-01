// To parse this JSON data, do
//
//     final getFavoritesModel = getFavoritesModelFromJson(jsonString);

import 'dart:convert';

import '../GetAllInvoices/get_all_invoices_model.dart';

GetFavoritesModel getFavoritesModelFromJson(String str) => GetFavoritesModel.fromJson(json.decode(str));


class GetFavoritesModel {
    final List<GetAllInvoicesDatum> data;
    final String message;
    final int status;

    GetFavoritesModel({
        required this.data,
        required this.message,
        required this.status,
    });

    factory GetFavoritesModel.fromJson(Map<String, dynamic> json) => GetFavoritesModel(
        data:json["Data"]==null ? []: List<GetAllInvoicesDatum>.from(json["Data"].map((x) => GetAllInvoicesDatum.fromJson(x))),
        message: json["message"]??'',
        status: json["status"]??500,
    );

}
