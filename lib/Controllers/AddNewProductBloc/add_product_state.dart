 class AddProductStates {}

final class AddProductStateStart extends AddProductStates {}
final class AddProductStateSuccess extends AddProductStates {}
final class AddProductStateFailed extends AddProductStates {
    final int? errType;
  final String msg;
  final String? field;

  AddProductStateFailed({ this.errType, required this.msg,  this.field});

}
