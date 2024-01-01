import '../../Models/LoginModel/login_model.dart';

class LoginStates {}

class LoginStateStart extends LoginStates {}

class LoginStateSuccess extends LoginStates {
  LoginModel loginModel;

  LoginStateSuccess({required this.loginModel});
}

class LoginStateFailed extends LoginStates {
  final int? errType;
  final String msg;
  final String? field;
  LoginStateFailed({this.errType, required this.msg, this.field});
}

class LoginWithEmailState extends LoginStates {

  
}
class LoginWithPhoneState extends LoginStates {

  
}
