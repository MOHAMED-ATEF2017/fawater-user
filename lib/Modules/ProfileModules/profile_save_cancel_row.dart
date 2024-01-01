import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Controllers/ChangePasswordBloc/change_password_bloc.dart';
import '../../Controllers/ChangePasswordBloc/change_password_collect_data.dart';
import '../../Controllers/ChangePasswordBloc/change_password_event.dart';
import '../../Controllers/ChangePasswordBloc/change_password_state.dart';
import '../../Shared/Components/container_button.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';

class ProfileSaveCancelButtonsRow extends StatelessWidget {
  const ProfileSaveCancelButtonsRow({
    super.key,
        required this.changePasswordBloc,
    required this.formKey,
    required this.changePasswordCollectData,

  });
  final ChangePasswordBloc changePasswordBloc;
  final GlobalKey<FormState> formKey;
  final ChangePasswordCollectData changePasswordCollectData;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: changePasswordBloc,
      builder: (context, state) {
        return state is ChangePasswordStateStart
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : Row(
                children: [
                  CustomContainerButton(
                    width: 165.5.w,
                    title: AppStrings.save,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        changePasswordBloc.add(
                            ChangePasswordEventStart(
                                changePasswordCollectData:
                                    changePasswordCollectData));
                      }
                    },
                  ),
                  const Spacer(),
                  CustomContainerButton(
                    width: 165.5.w,
                    color: AppColors.ffFEEFE9PrimaryLight,
                    title: AppStrings.cancel,
                    borderColor: Colors.transparent,
                    textColor: AppColors.ffF05A27OrangeColor,
                    onPressed: () {},
                  ),
                ],
              );
      },
    );
 
  }
}
