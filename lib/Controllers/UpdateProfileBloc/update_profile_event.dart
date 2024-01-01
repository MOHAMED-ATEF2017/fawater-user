
import '../GetProfileBloc/get_profile_collect_data.dart';

class UpdateProfileEvent {}

class UpdateProfileEventStart extends UpdateProfileEvent {
  final UpdateProfileCollectData updateProfileCollectData;
  UpdateProfileEventStart( this.updateProfileCollectData ,);
}
