import 'package:fawatery_user/Controllers/ChangePasswordBloc/change_password_bloc.dart';
import 'package:fawatery_user/Controllers/ChangePasswordBloc/change_password_collect_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../../Modules/ProfileModules/profile_save_cancel_row.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordCollectData changePasswordCollectData =
        ChangePasswordCollectData();

    final GlobalKey<FormState> formKey = GlobalKey();

    final ChangePasswordBloc changePasswordBloc =
        kiwi.KiwiContainer().resolve<ChangePasswordBloc>();

    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.changePassword)),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //*********** old password ************ */
                ChangePasswordTextField(
                  onSaved: (p0) {
                    changePasswordCollectData.oldPassword = p0;
                  },
                  validator: (p0) {
                    return p0!.isEmpty ? 'Enter the password' : null;
                  },
                  title: AppStrings.oldPassword,
                  hintText: AppStrings.passwordHint,
                ),
              
                //************ new password *********** */
                ChangePasswordTextField(
                  onSaved: (p0) {
                    changePasswordCollectData.newPassword = p0;
                  },
                  validator: (p0) {
                    return p0!.isEmpty ? 'Enter the password' : null;
                  },
                  title: AppStrings.newPassword,
                  hintText: AppStrings.passwordHint,
                ),
              
                //********** confirm passeord ********** */
                ChangePasswordTextField(
                  onSaved: (p0) {
                    changePasswordCollectData.configPassword = p0;
                  },
                  validator: (p0) {
                    return p0!.isEmpty ? 'Enter the password' : null;
                  },
                  title: AppStrings.newPassword,
                  hintText: AppStrings.passwordHint,
                ),
                12.verticalSpace,
                ProfileSaveCancelButtonsRow(
                  changePasswordBloc: changePasswordBloc,
                  formKey: formKey,
                  changePasswordCollectData: changePasswordCollectData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChangePasswordTextField extends StatelessWidget {
  const ChangePasswordTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.onSaved,
    required this.validator,
  });
  final String title, hintText;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle(size: 16),
        ),
        TextFormField(
          enableInteractiveSelection: false,
          onSaved: onSaved,
          validator: validator,
          style: textStyle(),
          decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.ffFEEFE9PrimaryLight))),
        ),
        12.verticalSpace,
      ],
    );
  }
}
