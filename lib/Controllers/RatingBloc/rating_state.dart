import 'package:fawatery_user/Models/RatingModel/rating_model.dart';

class RatingStates {}

final class GetRatingStateStart extends RatingStates {}

final class GetRatingStateSuccess extends RatingStates {
  final GetRatingsModel getRatingsModel;

  GetRatingStateSuccess({required this.getRatingsModel});
}

final class AddRatingStateStart extends RatingStates{}
final class AddRatingStateSuccess extends RatingStates{}

final class GetRatingStateFailed extends RatingStates{
    final int? errType;
  final String msg;
  final String? field;

  GetRatingStateFailed({ this.errType, required this.msg,  this.field});

}

final class AddRatingStateFailed extends RatingStates{
    final int? errType;
  final String msg;
  final String? field;

  AddRatingStateFailed({ this.errType, required this.msg,  this.field});

}

