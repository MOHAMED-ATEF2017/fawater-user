import 'package:fawatery_user/Controllers/AddRemoveFavoriteBloc/add_remove_favorite_collect_data.dart';

class AddRemoveFavoriteEvent {}

class AddRemoveFavoriteEventStart extends AddRemoveFavoriteEvent {
  final AddRemoveFavoriteCollectDate addRemoveFavoriteCollectDate;

  AddRemoveFavoriteEventStart({required this.addRemoveFavoriteCollectDate});
}
