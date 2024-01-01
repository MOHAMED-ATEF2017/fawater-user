class ChangePasswordCollectData {
  String? oldPassword, newPassword, configPassword;

  ChangePasswordCollectData(
      {this.configPassword, this.newPassword, this.oldPassword});

  Map<String, dynamic> toJson() => {
        'old_password': oldPassword,
        'new_password': newPassword,
        'confirm_password': configPassword,
      };
}
