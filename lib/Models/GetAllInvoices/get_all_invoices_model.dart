import 'dart:convert';

GetAllInvoicesModel getAllInvoicesModelFromJson(String str) => GetAllInvoicesModel.fromJson(json.decode(str));

class GetAllInvoicesModel {
    final List<GetAllInvoicesDatum> data;
    final String message;
    final int status;

    GetAllInvoicesModel({
        required this.data,
        required this.message,
        required this.status,
    });

    factory GetAllInvoicesModel.fromJson(Map<String, dynamic> json) => GetAllInvoicesModel(
        data: json["Data"]==null ? []:List<GetAllInvoicesDatum>.from(json["Data"].map((x) => GetAllInvoicesDatum.fromJson(x))),
        message: json["message"]??'',
        status: json["status"]??500,
    );

}

class GetAllInvoicesDatum {
    final String storeName;
    final int invoicesId;
    final String invoicesNumberInvoices;
    final String dateInvoice;
    final String totalInvoice;
    final bool favorite;

    GetAllInvoicesDatum({
        required this.storeName,
        required this.invoicesId,
        required this.invoicesNumberInvoices,
        required this.dateInvoice,
        required this.totalInvoice,
        required this.favorite,
    });

    factory GetAllInvoicesDatum.fromJson(Map<String, dynamic> json) => GetAllInvoicesDatum(
        storeName: json["store_name"]??'',
        invoicesId: json["invoices_id"]??0,
        invoicesNumberInvoices: json["invoices_number_invoices"]??'',
        dateInvoice: json["date_invoice"]??'',
        totalInvoice: json["total_invoice"]??'',
        favorite: json["favorite"] == 'true'?true:false,
    );
}
