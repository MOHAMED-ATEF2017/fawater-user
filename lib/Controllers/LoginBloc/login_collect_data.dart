class LoginCollectData {
  String? email;
  String ?password;
  String ?phone;

  LoginCollectData({
    this.email,
    this.password,
    this.phone
  });

  Map<String, dynamic> emailToJson() =>
      {"email": email,
        "password": password,};
  Map<String, dynamic> phoneToJson() =>
      {
        "phone":phone,
        "password": password,};
}
