
import 'package:fawatery_user/Models/GetProfileModel/get_profile_model.dart';

class UpdateProfileStates {}

class UpdateProfileStateStart extends UpdateProfileStates {}

class UpdateProfileStateSuccess extends UpdateProfileStates {
  GetProfileModel updateProfileModel;

  UpdateProfileStateSuccess({required this.updateProfileModel});
}

class UpdateProfileStateFailed extends UpdateProfileStates {
  final int? errType;
  final String msg;
  final String? field;
  UpdateProfileStateFailed({this.errType, required this.msg, this.field});
}

