import 'package:fawatery_user/Models/AllProductsModel/all_products_model.dart';

final class GetAllProductsState {}

final class GetAllProductsStateStart extends GetAllProductsState {}
final class GetAllProductsSearchStateStart extends GetAllProductsState {}

final class GetAllProductsStateSuccess extends GetAllProductsState {
  final GetAllProductsModel getAllProductsModel;

  GetAllProductsStateSuccess({required this.getAllProductsModel});
}

final class GetAllProductsSearchStateSuccess extends GetAllProductsState {
  final GetAllProductsModel getAllProductsModel;

  GetAllProductsSearchStateSuccess({required this.getAllProductsModel});
}

final class GetAllProductsStateFailed extends GetAllProductsState {
  final int? errType;
  final String msg;
  final String? field;

  GetAllProductsStateFailed({this.errType, required this.msg, this.field});
}

final class GetAllStateChangeGroupValue extends GetAllProductsState {
   String groubValue;
  GetAllStateChangeGroupValue({required this.groubValue});
}
