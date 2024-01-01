import 'package:fawatery_user/Controllers/HomeBloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Controllers/HomeBloc/home_bloc.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../gen/assets.gen.dart';

class HomeMyPointContainer extends StatelessWidget {
  const HomeMyPointContainer({
    super.key,
    required this.homeBloc,
  });
  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      decoration: BoxDecoration(
          color: AppColors.ffF05A27OrangeColor,
          borderRadius: BorderRadius.circular(6.r),
          image: DecorationImage(image: AssetImage(Assets.images.qrCode.path))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Assets.icons.coin.svg(),
                  6.horizontalSpace,
                  Text(
                    AppStrings.myPoints,
                    style: textStyle(size: 12, color: Colors.white),
                  )
                ],
              ),
              BlocBuilder(
                bloc: homeBloc,
                builder: (context, state) {
                  return state is HomeStateGetDataSuccess
                      ? Text(
                          '${state.homeModel.totalPoints} نقطة',
                          style: textStyle(
                              size: 16,
                              color: Colors.white,
                              weight: FontWeight.w500),
                        )
                      : Text(
                          '---',
                          style: textStyle(
                              size: 16,
                              color: Colors.white,
                              weight: FontWeight.w500),
                        );
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.sahbAlneqat,
                style: textStyle(
                  size: 12,
                  color: Colors.white,
                ),
              ),
              Assets.icons.chevronLeftMD.svg()
            ],
          )
        ],
      ),
    );
  }
}
