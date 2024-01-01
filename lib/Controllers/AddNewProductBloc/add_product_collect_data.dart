class AddNewProductCollectData {
  String? name, price;
  AddNewProductCollectData({this.name, this.price});

  Map<String, dynamic> toJson(String idUser) =>
      {'name': name, 'id_user': idUser, 'price': price};
}
