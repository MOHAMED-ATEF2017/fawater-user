import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

class HomeModel {
    final String totalInvoice;
    final int numberOfInvoices;
    final int numberOfPurchaseInvoices;
    final int totalPoints;
    final String message;
    final int status;

    HomeModel({
        required this.totalInvoice,
        required this.numberOfInvoices,
        required this.numberOfPurchaseInvoices,
        required this.totalPoints,
        required this.message,
        required this.status,
    });

    factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        totalInvoice: json["total_Invoice"]??'',
        numberOfInvoices: json["number_of_invoices"]??0,
        numberOfPurchaseInvoices: json["number_of_purchase_invoices"]??0,
        totalPoints: json["total_points"]??0,
        message: json["message"]??'',
        status: json["status"]??500,
    );

}
