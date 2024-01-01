import 'package:fawatery_user/Controllers/RatingBloc/rating_collect_data.dart';

class RatingEvent {}

class GetRatingEventStart extends RatingEvent {
  final String storeId;

  GetRatingEventStart({required this.storeId});
}

class AddRatingEventStart extends RatingEvent {
  final AddRatingCollectData addRatingCollectData;
  final String storeId;

  AddRatingEventStart(this.storeId, {required this.addRatingCollectData});
}
