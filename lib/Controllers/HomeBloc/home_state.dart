import 'package:fawatery_user/Models/GetAllInvoices/get_all_invoices_model.dart';
import 'package:fawatery_user/Models/HomeModel/home_model.dart';

import '../../Models/AllStoresModel/all_stores_model.dart';

class HomeStates {
}

final class HomeStateMatagerStart extends HomeStates {}

final class HomeStateInvoicesStart extends HomeStates {}

final class HomeStateGetDataStart extends HomeStates {}

final class HomeStateMatagerSuccess extends HomeStates {
  final AllStoresModel allStoresModel;

  HomeStateMatagerSuccess({required this.allStoresModel});
}

final class HomeStateSearchMatagerSuccess extends HomeStates {
  final AllStoresModel allStoresModel;

  HomeStateSearchMatagerSuccess({required this.allStoresModel});
}

final class HomeStateInvoicesSuccess extends HomeStates {
  final GetAllInvoicesModel getAllInvoicesModel;

  HomeStateInvoicesSuccess({required this.getAllInvoicesModel});
}
final class HomeStateGetDataSuccess extends HomeStates {
  final HomeModel homeModel;

  HomeStateGetDataSuccess({required this.homeModel});
}

final class HomeStateFailed extends HomeStates {
  final int? errType;
  final String msg;
  final String? field;

  HomeStateFailed({this.errType, required this.msg, this.field});
}

final class HomeStateChangeGroupValue extends HomeStates {
  String groupValue;
  HomeStateChangeGroupValue({required this.groupValue});
}
