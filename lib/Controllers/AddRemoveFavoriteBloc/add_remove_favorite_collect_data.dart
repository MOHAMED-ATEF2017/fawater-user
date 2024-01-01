class AddRemoveFavoriteCollectDate {
  String? invoiceId, favorite;
  AddRemoveFavoriteCollectDate({this.favorite, this.invoiceId});

  Map<String, dynamic> toJson() =>
      {'invoices_id': invoiceId, 'favorite': favorite};
}
