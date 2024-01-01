// To parse this JSON data, do
//
//     final billDetailsModel = billDetailsModelFromJson(jsonString);

import 'dart:convert';

BillDetailsModel billDetailsModelFromJson(String str) =>
    BillDetailsModel.fromJson(json.decode(str));

class BillDetailsModel {
  final List<StoreDatum> storeData;
  final List<ProductDatum> productData;
  final List<UserDatum> userData;
  final List<InvoiceDatum> invoiceData;
  final String message;
  final int status;

  BillDetailsModel({
    required this.storeData,
    required this.productData,
    required this.userData,
    required this.invoiceData,
    required this.message,
    required this.status,
  });

  factory BillDetailsModel.fromJson(Map<String, dynamic> json) =>
      BillDetailsModel(
        storeData: json["store_data"] == null
            ? []
            : List<StoreDatum>.from(
                json["store_data"].map((x) => StoreDatum.fromJson(x))),
        productData: json["product_data"] == null
            ? []
            : List<ProductDatum>.from(
                json["product_data"].map((x) => ProductDatum.fromJson(x))),
        userData: json["user_data"] == null
            ? []
            : List<UserDatum>.from(
                json["user_data"].map((x) => UserDatum.fromJson(x))),
        invoiceData: json["invoice_data"] == null
            ? []
            : List<InvoiceDatum>.from(
                json["invoice_data"].map((x) => InvoiceDatum.fromJson(x))),
        message: json["message"] ?? '',
        status: json["status"] ?? 500,
      );
}

class InvoiceDatum {
  final String totalInvoice;
  final dynamic favorite;
  final String numberInvoices;

  InvoiceDatum({
    required this.totalInvoice,
    required this.favorite,
    required this.numberInvoices,
  });

  factory InvoiceDatum.fromJson(Map<String, dynamic> json) => InvoiceDatum(
        totalInvoice: json["total_invoice"] ?? '',
        favorite: json["favorite"] ?? '',
        numberInvoices: json["number_invoices"] ?? '',
      );
}

class ProductDatum {
  final String productsName;
  final String productQuantity;
  final String productPrice;

  ProductDatum({
    required this.productsName,
    required this.productQuantity,
    required this.productPrice,
  });

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
        productsName: json["products_name"] ?? '',
        productQuantity: json["product_quantity"] ?? '',
        productPrice: json["product_price"] ?? '',
      );
}

class StoreDatum {
  final String storeName;
  final String phone;
  final String address;
  final DateTime dateInvoice;
  final DateTime createdAt;

  StoreDatum({
    required this.storeName,
    required this.phone,
    required this.address,
    required this.dateInvoice,
    required this.createdAt,
  });

  factory StoreDatum.fromJson(Map<String, dynamic> json) => StoreDatum(
        storeName: json["store_name"] ?? '',
        phone: json["phone"] ?? '',
        address: json["address"] ?? '',
        dateInvoice: json["date_invoice"] == null
            ? DateTime.now()
            : DateTime.parse(json["date_invoice"]),
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
      );
}

class UserDatum {
  final String name;
  final String phone;

  UserDatum({
    required this.name,
    required this.phone,
  });

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
        name: json["name"] ?? '',
        phone: json["phone"] ?? '',
      );
}
