import 'package:fawatery_user/Models/GetFavoritesModel/get_favorite_model.dart';

class GetFavoritesStates {}

final class GetFavoritesStateStart extends GetFavoritesStates {}

final class GetFavoritesStateSuccess extends GetFavoritesStates {
  final GetFavoritesModel getFavoritesModel;

  GetFavoritesStateSuccess({required this.getFavoritesModel});
}

class GetFavoritesStateFailed extends GetFavoritesStates {
  final int? errType;
  final String msg;
  final String? field;

  GetFavoritesStateFailed({this.errType, required this.msg, this.field});
}
