class AddRatingCollectData {
  String? rating, comment;
  AddRatingCollectData({this.comment, this.rating});

  Map<String, dynamic> toJson(
          {required String storeId, required String userId}) =>
      {
        'id_store': storeId,
        'id_user': userId,
        'rating': rating,
        'comment': comment,
      };
}
