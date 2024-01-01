import 'package:fawatery_user/Controllers/CreateInvoiceBloc/create_invoice_collect_data.dart';

final class CreateInvoiceEvent {}

final class CreateInvoiceByDetailsEventStart extends CreateInvoiceEvent {
  final CreateInvoiceCollectData createInvoiceCollectData;

  CreateInvoiceByDetailsEventStart({required this.createInvoiceCollectData});
}

final class CreateInvoiceByImageEventStart extends CreateInvoiceEvent {
  final CreateInvoiceCollectData createInvoiceCollectData;

  CreateInvoiceByImageEventStart({required this.createInvoiceCollectData});
}
// final class CreateInvoiceEventFailed extends CreateInvoiceEvent {}
