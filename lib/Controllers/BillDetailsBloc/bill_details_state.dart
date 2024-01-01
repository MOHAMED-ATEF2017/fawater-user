import 'package:fawatery_user/Models/BillDetailsModel/bill_details_model.dart';

class BillDetailsStates {}

final class BillDetailsStateStart extends BillDetailsStates {}

final class BillDetailsStateSuccess extends BillDetailsStates {
  final BillDetailsModel billDetailsModel;

  BillDetailsStateSuccess({required this.billDetailsModel});
}

class BillDetailsStateFailed extends BillDetailsStates {
    final int? errType;
  final String msg;
  final String? field;

  BillDetailsStateFailed({this.errType,required this.msg, this.field});
}

