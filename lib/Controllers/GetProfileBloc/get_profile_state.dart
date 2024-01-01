part of 'get_profile_bloc.dart';

class GetProfileStates {}

class GetProfileStateStart extends GetProfileStates {}

class GetProfileStateSuccess extends GetProfileStates {
  final GetProfileModel getProfileModel;

  GetProfileStateSuccess({required this.getProfileModel});
}

class GetProfileStateFailed extends GetProfileStates {
    final int? errType;
  final String msg;
  final String? field;

  GetProfileStateFailed({this.errType,required this.msg, this.field});
}
