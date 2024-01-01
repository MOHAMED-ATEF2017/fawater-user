import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));


class NotificationModel {
    final List<NotificationDatum> data;
    final String message;
    final int status;

    NotificationModel({
        required this.data,
        required this.message,
        required this.status,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        data:json["Data"] == null ? []: List<NotificationDatum>.from(json["Data"].map((x) => NotificationDatum.fromJson(x))),
        message: json["message"]??'',
        status: json["status"]??500,
    );

}

class NotificationDatum {
    final int id;
    final String titleNotification;
    final String messageNotification;
    final String numberInvoices;
    final DateTime createdAt;

    NotificationDatum({
        required this.id,
        required this.titleNotification,
        required this.messageNotification,
        required this.numberInvoices,
        required this.createdAt,
    });

    factory NotificationDatum.fromJson(Map<String, dynamic> json) => NotificationDatum(
        id: json["id"]??0,
        titleNotification: json["title_notification"]??'',
        messageNotification: json["message_notification"]??'',
        numberInvoices: json["number_invoices"]??'',
        createdAt:json["created_at"]==null?DateTime.now(): DateTime.parse(json["created_at"]),
    );

}
