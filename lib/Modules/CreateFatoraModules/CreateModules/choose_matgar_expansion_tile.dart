import 'package:fawatery_user/Controllers/HomeBloc/home_bloc.dart';
import 'package:fawatery_user/Controllers/HomeBloc/home_cubit.dart';
import 'package:fawatery_user/Controllers/HomeBloc/home_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../../Controllers/HomeBloc/home_state.dart';
import '../../../Models/AllStoresModel/all_stores_model.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../Shared/Constants/constant_strings.dart';

class MatgarNameAtCreateFatoraByDetailsExpansionTile extends StatelessWidget {
  const MatgarNameAtCreateFatoraByDetailsExpansionTile({
    super.key,
    required this.homeCubit,
  });
  final HomeCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    final HomeBloc getMatagerBloc = KiwiContainer().resolve<HomeBloc>();

    homeCubit.changeGroupValue('', '');
    getMatagerBloc.add(HomeEventAlmatagerStart());

    ScrollController scrollController = ScrollController();
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      // padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.black.withOpacity(.15))),
        child: ExpansionTile(
          collapsedBackgroundColor: AppColors.ffFEEFE9PrimaryLight,
          backgroundColor: AppColors.ffFEEFE9PrimaryLight,
          iconColor: AppColors.ffF05A27OrangeColor,
          collapsedIconColor: AppColors.ffF05A27OrangeColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          title: Text(
            AppStrings.matgarName,
            style: textStyle(color: AppColors.ffF05A27OrangeColor),
          ),
          children: [
            CupertinoSearchTextField(
              backgroundColor: Colors.white,
              onChanged: (p0) {
                getMatagerBloc.add(HomeEventSearchStoreStart(name: p0));
                //TODO:ddddddddddddddddddddddddddddd
              },
            ),
            Container(
              height: 10.h,
              color: Colors.white,
            ),
            // 10.verticalSpace,
            BlocBuilder(
              bloc: getMatagerBloc,
              builder: (context, state) {
                return Container(
                  color: Colors.white,
                  height: 146.h,
                  child: state is HomeStateMatagerStart
                      ? const CupertinoActivityIndicator()
                      : state is HomeStateMatagerSuccess
                          ? StoreScrollBarWidget(
                              scrollController: scrollController,
                              homeCubit: homeCubit,
                              allStoresModel: state.allStoresModel)
                          : state is HomeStateSearchMatagerSuccess
                              ? StoreScrollBarWidget(
                                  scrollController: scrollController,
                                  homeCubit: homeCubit,
                                  allStoresModel: state.allStoresModel)
                              : Text(
                                  'There are some ERRORS, Please try again later',
                                  style: textStyle(),
                                ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StoreScrollBarWidget extends StatelessWidget {
  const StoreScrollBarWidget({
    super.key,
    required this.scrollController,
    required this.homeCubit, required this.allStoresModel,
  });

  final ScrollController scrollController;
  final HomeCubit homeCubit;
  final AllStoresModel allStoresModel;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: scrollController,
        thickness: 8.w,
        trackVisibility: true,
        thumbVisibility: true,
        radius: Radius.circular(4.r),
        child: BlocBuilder(
          bloc: homeCubit,
          builder: (context, homeCubitState) {
            return homeCubitState is HomeStateChangeGroupValue
                ? ListView.separated(
                    controller: scrollController,
                    itemCount: allStoresModel.data.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return 4.verticalSpace;
                    },
                    itemBuilder: (BuildContext context, int index) {
                      var data = allStoresModel.data[index];
                      return SizedBox(
                        height: 38.h,
                        child: RadioListTile(
                          value: data.store,
                          groupValue: homeCubitState.groupValue,
                          activeColor: AppColors.ffF05A27OrangeColor,

                          onChanged: (value) {
                            homeCubit.changeGroupValue(
                                value!, data.id.toString());
                          },
                          // selected: index == 0 ? false:true,
                          title: Text(
                            data.store,
                            style: textStyle(size: 12),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox.shrink();
          },
        ));
  }
}
