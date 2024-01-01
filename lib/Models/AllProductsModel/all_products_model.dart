import 'dart:convert';

GetAllProductsModel getAllProductsModelFromJson(String str) => GetAllProductsModel.fromJson(json.decode(str));


class GetAllProductsModel {
    final List<AllProductsDatum> data;
    final String message;
    final int status;

    GetAllProductsModel({
        required this.data,
        required this.message,
        required this.status,
    });

    factory GetAllProductsModel.fromJson(Map<String, dynamic> json) => GetAllProductsModel(
        data:json["Data"] == null ? []: List<AllProductsDatum>.from(json["Data"].map((x) => AllProductsDatum.fromJson(x))),
        message: json["message"]??'',
        status: json["status"]??500,
    );

}

class AllProductsDatum {
    final int id;
    final String products;

    AllProductsDatum({
        required this.id,
        required this.products,
    });

    factory AllProductsDatum.fromJson(Map<String, dynamic> json) => AllProductsDatum(
        id: json["id"]??0,
        products: json["products"]??'',
    );

}
