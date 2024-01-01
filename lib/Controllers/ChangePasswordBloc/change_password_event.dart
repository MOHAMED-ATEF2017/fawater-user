import 'package:fawatery_user/Controllers/ChangePasswordBloc/change_password_collect_data.dart';

class ChangePasswordEvent {}

class ChangePasswordEventStart extends ChangePasswordEvent {
  final ChangePasswordCollectData changePasswordCollectData;

  ChangePasswordEventStart({required this.changePasswordCollectData});
}
