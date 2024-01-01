import 'package:fawatery_user/Controllers/HomeBloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Controllers/HomeBloc/home_bloc.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../gen/assets.gen.dart';
import 'home_remaining_single_child_scroll_view.dart';
import 'home_screen_fawater_container.dart';

class HomeCreateAndAnalysisInkwells extends StatelessWidget {
  const HomeCreateAndAnalysisInkwells({
    super.key,
    required this.homeBloc,
  });
  final HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 135.h,
        right: 16.w,
        left: 16.w,
        child: BlocBuilder(
          bloc: homeBloc,
          builder: (context, state) {
            var row = Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeScreenFawaterContainer(
                  svg: Assets.icons.receipt2.path,
                  title: AppStrings.adAlFawater,
                  data: '----',
                ),
                HomeScreenFawaterContainer(
                  svg: Assets.icons.emptyWallet.path,
                  title: AppStrings.egmalyAlmoshtrayat,
                  data: '----',
                ),
                HomeScreenFawaterContainer(
                  svg: Assets.icons.bag2.path,
                  title: AppStrings.egmalyAlmontagat,
                  data: '----',
                )
              ],
            );
            return Column(
              children: [
                state is HomeStateGetDataStart
                    ? row
                    : state is HomeStateGetDataSuccess
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HomeScreenFawaterContainer(
                                svg: Assets.icons.receipt2.path,
                                title: AppStrings.adAlFawater,
                                data:
                                    state.homeModel.numberOfInvoices.toString(),
                              ),
                              HomeScreenFawaterContainer(
                                svg: Assets.icons.emptyWallet.path,
                                title: AppStrings.egmalyAlmoshtrayat,
                                data: state.homeModel.totalInvoice,
                              ),
                              HomeScreenFawaterContainer(
                                svg: Assets.icons.bag2.path,
                                title: AppStrings.egmalyAlmontagat,
                                data: state.homeModel.numberOfPurchaseInvoices
                                    .toString(),
                              )
                            ],
                          )
                        : row,

                //********** Remaining ******************** */
                SizedBox(
                  height: 1.sh,
                  child:  HomeRemainingSingleChildScrollView(homeBloc:homeBloc),
                ),
              ],
            );
          },
        ));
  }
}
