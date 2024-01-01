import 'package:fawatery_user/Controllers/LoginBloc/login_bloc.dart';
import 'package:fawatery_user/Controllers/LoginBloc/login_collect_data.dart';
import 'package:fawatery_user/Controllers/LoginBloc/login_cubit.dart';
import 'package:fawatery_user/Controllers/LoginBloc/login_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Controllers/LoginBloc/login_state.dart';
import '../../../Shared/Components/auth_text_field.dart';
import '../../../Shared/Components/container_button.dart';
import '../../../Shared/Components/or_widget.dart';
import '../../../Shared/Components/social_media_row.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../Shared/Constants/constant_strings.dart';
import '../../../Shared/functions/navigate_fadin.dart';
import '../../../gen/assets.gen.dart';
import '../ForgetPassword/forget_password.dart';
import '../SignUpScreen/sign_up_screen.dart';

import 'package:kiwi/kiwi.dart' as kiwi;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final LoginCubit loginCubit = kiwi.KiwiContainer().resolve<LoginCubit>();
    final LoginBloc loginBloc = kiwi.KiwiContainer().resolve<LoginBloc>();
    final GlobalKey<FormState> formkey = GlobalKey();

    LoginCollectData loginCollectData = LoginCollectData();
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 44.h),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Assets.icons.walletAmico1
                      .svg(width: 171.5.w, height: 171.5.h),
                ),
                10.verticalSpace,
                Text(
                  AppStrings.login,
                  style: textStyle(size: 22),
                ),
                Text(
                  AppStrings.pleaseInterYourDataCorrectly,
                  style: textStyle(),
                ),
                24.verticalSpace,
                //************ phone **************** */
                BlocBuilder<LoginCubit, LoginStates>(
                  bloc: loginCubit,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state is LoginWithPhoneState
                            ? AuthTextField(
                                title: AppStrings.phonNumber,
                                titleSize: 16,
                                isPhone: true,
                                hintText: AppStrings.phoneHint,
                                onSaved: (p0) {
                                  loginCollectData.phone = p0;
                                },
                                validator: (p0) {
                                  return p0!.isEmpty
                                      ? "من فضلك ادخل الهاتف"
                                      : null;
                                },
                              )
                            : AuthTextField(
                                title: AppStrings.emailAddress,
                                titleSize: 16,
                                hintText: AppStrings.emailAddressHint,
                                onSaved: (p0) {
                                  loginCollectData.email = p0;
                                },
                                validator: (p0) {
                                  return p0!.isEmpty
                                      ? "من فضلك ادخل الايميل"
                                      : null;
                                },
                              ),
                        InkWell(
                          onTap: () {
                            if (state is LoginWithPhoneState) {
                              loginCubit.loginWithEmail();
                            } else {
                              loginCubit.loginWithPhone();
                            }
                          },
                          child: Text(
                            state is LoginWithPhoneState
                                ? AppStrings.enterByEmail
                                : AppStrings.enterByPhone,
                            style: textStyle(
                                size: 12, color: AppColors.ffF05A27OrangeColor),
                          ),
                        )
                      ],
                    );
                  },
                ),

                12.verticalSpace,
                AuthTextField(
                  title: AppStrings.password,
                  titleSize: 16,
                  hintText: AppStrings.passwordHint,
                  onSaved: (p0) {
                    loginCollectData.password = p0;
                  },
                  validator: (p0) {
                    return p0!.isEmpty ? 'Please enter the password' : null;
                  },
                ),
                InkWell(
                  onTap: () => CustomNavigation.fadeInGetToNavigateFunction(
                      const ForgetPasswordScreen()),
                  child: Text(
                    AppStrings.forgetPassword,
                    style: textStyle(size: 12, color: AppColors.ffC1C2C3Icons),
                  ),
                ),
                24.verticalSpace,
                BlocConsumer(
                  bloc: loginBloc,
                  listener: (context, state) {
                    if (state is LoginStateFailed) {
                      Get.snackbar('ERROR', state.msg);
                    }
                  },
                  builder: (context, state) {
                    return state is LoginStateStart
                        ? const Center(child: CupertinoActivityIndicator())
                        : CustomContainerButton(
                            title: AppStrings.login,
                            width: 1.sw,
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                loginBloc.add(LoginEventStart(
                                    loginCollectData: loginCollectData ,
                                    isPhoneLogin: loginCubit.state is LoginWithPhoneState?true:false
                                    ));
                              }
                            });
                  },
                ),
                const OrWidget(),
                12.verticalSpace,
                const SocialMediaRow(),
                12.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccountText,
                      style: textStyle(size: 12),
                    ),
                    InkWell(
                      onTap: () {
                        CustomNavigation.fadeInGetToNavigateFunction(
                            const SignUpScreen());
                      },
                      child: Text(
                        AppStrings.sigUpNowText,
                        style: textStyle(
                            size: 12, color: AppColors.ffF05A27OrangeColor),
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                Center(
                    child: Text(
                  AppStrings.loginAsGest,
                  style:
                      textStyle(color: AppColors.ffF05A27OrangeColor, size: 12),
                )),
                60.verticalSpace
              ],
            ),
          ),
        ),
      ),
    );
  }
}
