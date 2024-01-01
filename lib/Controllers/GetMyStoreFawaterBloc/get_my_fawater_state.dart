import 'package:fawatery_user/Models/GetAllInvoices/get_all_invoices_model.dart';

class GetMyStoreFawaterStates {}

final class GetMyStoreFawaterStateStart extends GetMyStoreFawaterStates {}

final class GetMyStoreFawaterStateSuccess extends GetMyStoreFawaterStates {
  final GetAllInvoicesModel invoicesModel;

  GetMyStoreFawaterStateSuccess({required this.invoicesModel});
}

final class GetMyStoreFawaterStateFailed extends GetMyStoreFawaterStates {
  final int? errType;
  final String msg;
  final String? field;

  GetMyStoreFawaterStateFailed({
    this.errType,
    required this.msg,
    this.field,
  });
}
