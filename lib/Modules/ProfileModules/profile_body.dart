import 'package:fawatery_user/Controllers/GetProfileBloc/get_profile_bloc.dart';
import 'package:fawatery_user/Controllers/GetProfileBloc/get_profile_collect_data.dart';
import 'package:fawatery_user/Controllers/GetProfileBloc/image_cubit.dart';
import 'package:fawatery_user/Controllers/UpdateProfilebloc/update_profile_bloc.dart';
import 'package:fawatery_user/Controllers/UpdateProfilebloc/update_profile_event.dart';
import 'package:fawatery_user/Shared/Components/text_style.dart';
import 'package:fawatery_user/Shared/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../../Controllers/UpdateProfilebloc/update_profile_state.dart';
import '../../Shared/Components/container_button.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import 'profile_text_feild.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GetProfileBloc getProfileBloc =
        kiwi.KiwiContainer().resolve<GetProfileBloc>();

    final ImageCubit imageCubit = kiwi.KiwiContainer().resolve<ImageCubit>();

    final UpdateProfileBloc updateProfileBloc =
        kiwi.KiwiContainer().resolve<UpdateProfileBloc>();

    UpdateProfileCollectData updateProfileCollectData =
        UpdateProfileCollectData();

    final GlobalKey<FormState> formkey = GlobalKey();
    getProfileBloc.add(GetProfileEventStart());
    return BlocBuilder(
      bloc: getProfileBloc,
      builder: (context, state) {
        return state is GetProfileStateStart
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : state is GetProfileStateSuccess
                ? BlocBuilder(
                    bloc: imageCubit,
                    builder: (context, imageState) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.all(16.w),
                        child: Form(
                          key: formkey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //********* profile ********* */
                              Center(
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 60.r,
                                      backgroundImage: imageCubit
                                                  .profileImage !=
                                              null
                                          // ? imageState is ImageCubitStateSuccess
                                          ? FileImage(imageCubit.profileImage!)
                                              as ImageProvider
                                          // : null
                                          : NetworkImage(
                                              "$baseUrlWithoutApi${state.getProfileModel.data.first.img}"),
                                    ),
                                    PositionedDirectional(
                                      bottom: 0,
                                      start: -20.w,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 27.r,
                                        child: IconButton(
                                            onPressed: () {
                                              imageCubit.getAddPics(
                                                  source: ImageSource.gallery);
                                            },
                                            icon: Icon(
                                              Icons.photo_camera_outlined,
                                              size: 40.r,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              //**** name ********** */
                              ProfileTextFeild(
                                validator: (p0) {
                                  return p0!.isEmpty ? 'Enter Name' : null;
                                },
                                onSaved: (p0) {
                                  updateProfileCollectData.name = p0;
                                },
                                initialValue:
                                    state.getProfileModel.data.first.name,
                                title: AppStrings.matgarName,
                                hintText: AppStrings.matgarName,
                              ),
                              //*********** phone ************ */
                              ProfileTextFeild(
                                validator: (p0) {
                                  return p0!.isEmpty ? 'Enter Phone' : null;
                                },
                                onSaved: (p0) {
                                  updateProfileCollectData.phoneNumber = p0;
                                },
                                initialValue:
                                    state.getProfileModel.data[0].phone,
                                title: AppStrings.phonNumber,
                                hintText: AppStrings.phoneHint,
                              ),
                              //************ email********** */
                              ProfileTextFeild(
                                validator: (p0) {
                                  return p0!.isEmpty ? 'Enter Email' : null;
                                },
                                onSaved: (p0) {
                                  updateProfileCollectData.email = p0;
                                },
                                initialValue:
                                    state.getProfileModel.data[0].email,
                                title: AppStrings.emailAddress,
                                hintText: AppStrings.emailAddressHint,
                              ),
                              12.verticalSpace,
                              /* ProfileSaveCancelButtonsRow(profileId:  state.getProfileModel.data.first.id) */
                              BlocBuilder(
                                bloc: updateProfileBloc,
                                builder: (context, updateState) {
                                  return updateState is UpdateProfileStateStart
                                      ? const Center(
                                          child: CupertinoActivityIndicator(),
                                        )
                                      : Row(
                                          children: [
                                            CustomContainerButton(
                                              width: 165.5.w,
                                              title: AppStrings.save,
                                              onPressed: () {
                                                if (formkey.currentState!
                                                    .validate()) {
                                                  formkey.currentState!.save();
                                                  updateProfileCollectData
                                                          .image =
                                                      imageCubit.profileImage;
                                                  updateProfileCollectData
                                                          .userId =
                                                      state.getProfileModel.data
                                                          .first.id
                                                          .toString();
                                                
                                                  updateProfileBloc.add(
                                                      UpdateProfileEventStart(
                                                          updateProfileCollectData));
                                                }
                                              },
                                            ),
                                            const Spacer(),
                                            CustomContainerButton(
                                              width: 165.5.w,
                                              color: AppColors
                                                  .ffFEEFE9PrimaryLight,
                                              title: AppStrings.cancel,
                                              borderColor: Colors.transparent,
                                              textColor:
                                                  AppColors.ffF05A27OrangeColor,
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        );
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "ERROR",
                      style: textStyle(),
                    ),
                  );
      },
    );
  }
}
