class CreateInvoiceStates {}

final class CreateInvoiceByDetailsStateStart extends CreateInvoiceStates {}

final class CreateInvoiceByDetailsStateSuccess extends CreateInvoiceStates {}

final class CreateInvoiceByImageStateStart extends CreateInvoiceStates {}

final class CreateInvoiceByImageStateSuccess extends CreateInvoiceStates {}

final class CreateInvoiceStateFailed extends CreateInvoiceStates {
  final int? errType;
  final String msg;
  final String? field;

  CreateInvoiceStateFailed({this.errType, required this.msg, this.field});
}
