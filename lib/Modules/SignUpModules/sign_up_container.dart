import 'package:fawatery_user/Controllers/GetProfileBloc/image_cubit.dart';
import 'package:fawatery_user/Controllers/SignUpBloc/sign_up_bloc.dart';
import 'package:fawatery_user/Controllers/SignUpBloc/sign_up_collect_data.dart';
import 'package:fawatery_user/Controllers/SignUpBloc/sign_up_event.dart';
import 'package:fawatery_user/Controllers/SignUpBloc/sign_up_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwi/kiwi.dart';

import '../../Screens/ConditionsScreen/condition_screen.dart';
import '../../Shared/Components/auth_text_field.dart';
import '../../Shared/Components/container_button.dart';
import '../../Shared/Components/or_widget.dart';
import '../../Shared/Components/social_media_row.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/functions/navigate_fadin.dart';
import '../../gen/assets.gen.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ImageCubit imageCubit = KiwiContainer().resolve<ImageCubit>();
    final SignUpBloc signUpBloc = KiwiContainer().resolve<SignUpBloc>();

    final SignUpCollectData signUpCollectData = SignUpCollectData();

    final GlobalKey<FormState> formKey = GlobalKey();

    return Container(
      width: 375.w,
      height: 734.h,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 24.h,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 20.h),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            4.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.creatAccount,
                      style: textStyle(size: 22),
                    ),
                    Text(
                      AppStrings.helloSignup,
                      style: textStyle(size: 13.5),
                    ),
                  ],
                ),
                const Spacer(),
                Assets.icons.signup.svg()
              ],
            ),
            24.verticalSpace,
            //********* image profile ********* */
            BlocBuilder(
              bloc: imageCubit,
              builder: (context, state) => Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                        radius: 60.r,
                        backgroundImage: imageCubit.profileImage != null
                            ? FileImage(imageCubit.profileImage!)
                                as ImageProvider
                            : AssetImage(Assets.images.logo.path)),
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
            ),

            //*********** name **** */
            AuthTextField(
              onSaved: (p0) {
                signUpCollectData.name = p0;
              },
              validator: (p0) {
                return p0!.isEmpty ? 'Enter your name' : null;
              },
              title: AppStrings.fullName,
              hintText: AppStrings.fullNameHint,
              titleSize: 16,
            ),
            12.verticalSpace,
            //******** phone ********** */
            AuthTextField(
              onSaved: (p0) {
                signUpCollectData.phone = p0;
              },
              validator: (p0) {
                return p0!.isEmpty ? 'Enter your phone' : null;
              },
              isPhone: true,
              title: AppStrings.phonNumber,
              titleSize: 16,
              hintText: AppStrings.phoneHint,
            ),
            12.verticalSpace,

            //*********** email ********** */
            AuthTextField(
              onSaved: (p0) {
                signUpCollectData.email = p0;
              },
              validator: (p0) {
                return null;
              },
              title: AppStrings.emailAddress,
              titleSize: 16,
              hintText: AppStrings.emailAddressHint,
            ),
            4.verticalSpace,
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColors.ff5A5D61SubText,
                ),
                4.horizontalSpace,
                Text(
                  AppStrings.option,
                  style: textStyle(size: 12, color: AppColors.ff5A5D61SubText),
                ),
              ],
            ),
            13.verticalSpace,
            //******** password *********** */
            AuthTextField(
              onSaved: (p0) {
                signUpCollectData.password = p0;
              },
              validator: (p0) {
                return p0!.isEmpty ? 'Enter the password' : null;
              },
              title: AppStrings.password,
              titleSize: 16,
              hintText: AppStrings.passwordHint,
            ),
            12.verticalSpace,
            //********confirm  password *********** */
            AuthTextField(
              onSaved: (p0) {
                signUpCollectData.confirmPassword = p0;
              },
              validator: (p0) {
                return p0!.isEmpty ? 'Enter the password' : null;
              },
              title: AppStrings.confirmPassword,
              titleSize: 16,
              hintText: AppStrings.passwordHint,
            ),
            12.verticalSpace,
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (_) {},
                  activeColor: AppColors.ffF05A27OrangeColor,
                ),
                5.horizontalSpace,
                Text(
                  AppStrings.agree,
                  style: textStyle(size: 12),
                ),
                InkWell(
                  onTap: () {
                    CustomNavigation.fadeInGetToNavigateFunction(
                        const ConditionScreen());
                  },
                  child: Text(
                    AppStrings.conditions,
                    style: textStyle(
                        size: 12, color: AppColors.ffF05A27OrangeColor),
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            BlocBuilder(
              bloc: signUpBloc,
              builder: (context, state) {
                return state is SignUpStateStart
                    ? const Center(child: CupertinoActivityIndicator())
                    : CustomContainerButton(
                        title: AppStrings.creatAccount,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            signUpBloc.add(SignUpEventStart(
                                signUpCollectData: signUpCollectData));
                          }
                          // CustomNavigation.fadeInGetToNavigateFunction(
                          //     const PinCodeScreen(
                          //   isFromLogin: false,
                          // ));
                        },
                        width: 343.w,
                      );
              },
            ),
            22.verticalSpace,
            const OrWidget(),
            22.verticalSpace,
            const SocialMediaRow(),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.doYouHaveAccount,
                  style: textStyle(size: 12),
                ),
                Text(
                  AppStrings.login,
                  style:
                      textStyle(color: AppColors.ffF05A27OrangeColor, size: 12),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
