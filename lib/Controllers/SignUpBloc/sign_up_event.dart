import 'package:fawatery_user/Controllers/SignUpBloc/sign_up_collect_data.dart';

class SignUpEvent {}

class SignUpEventStart extends SignUpEvent {
  final SignUpCollectData signUpCollectData;

  SignUpEventStart({required this.signUpCollectData});
}
