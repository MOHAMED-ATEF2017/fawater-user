class AddRemoveFavoriteStates {}

final class AddRemoveFavoriteStateStart extends AddRemoveFavoriteStates {}

final class AddRemoveFavoriteStateSuccess extends AddRemoveFavoriteStates {}

final class AddRemoveFavoriteStateFailed extends AddRemoveFavoriteStates {
  final int? errType;
  final String msg;
  final String? field;
  AddRemoveFavoriteStateFailed({this.errType, required this.msg, this.field});
}
