
class ChangePasswordStates {}

class ChangePasswordStateStart extends ChangePasswordStates {}

class ChangePasswordStateSuccess extends ChangePasswordStates {
}

class ChangePasswordStateFailed extends ChangePasswordStates {
    final int? errType;
  final String msg;
  final String? field;

  ChangePasswordStateFailed({this.errType,required this.msg, this.field});
}
