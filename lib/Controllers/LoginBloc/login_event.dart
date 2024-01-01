import 'login_collect_data.dart';

class LoginEvent {}

class LoginEventStart extends LoginEvent {
  final LoginCollectData loginCollectData;
final bool isPhoneLogin;
  LoginEventStart({required this.loginCollectData , this.isPhoneLogin = false});
}
