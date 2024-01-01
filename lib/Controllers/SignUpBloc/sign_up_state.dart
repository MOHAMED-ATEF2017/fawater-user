import 'package:fawatery_user/Models/SignUpModel/sign_up_model.dart';

class SignUpStates {}

final class SignUpStateStart extends SignUpStates {}

final class SignUpStateSuccess extends SignUpStates {
  final SignUpModel signUpModel;

  SignUpStateSuccess({required this.signUpModel});
}

final class SignUpStateFailed extends SignUpStates {
  final int? errType;
  final String msg;
  final String? field;

  SignUpStateFailed({this.errType, required this.msg, this.field});
}
