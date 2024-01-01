import 'package:fawatery_user/Controllers/GetFavoritesBloc/get_favorites_event.dart';
import 'package:fawatery_user/Controllers/GetFavoritesBloc/get_favorites_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiwi/kiwi.dart';

import '../../Controllers/GetFavoritesBloc/get_favorites_bloc.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../gen/assets.gen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final GetFavoritesBloc getFavoritesBloc =
        KiwiContainer().resolve<GetFavoritesBloc>();

    getFavoritesBloc.add(GetFavoritesEventStart());

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.favoriteTab),
      ),
      body: BlocBuilder(
        bloc: getFavoritesBloc,
        builder: (context, state) {
          return state is GetFavoritesStateStart
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : state is GetFavoritesStateSuccess
                  ?
                  state.getFavoritesModel.data.isEmpty?
                  Center(
                    child: Text("There aren't Favorite Invoice until now" , style: textStyle(),),
                  )
                  :
                   ListView.separated(
                      padding: EdgeInsets.all(16.w),
                      itemCount: state.getFavoritesModel.data.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return 16.verticalSpace;
                      },
                      itemBuilder: (BuildContext context, int index) {
                        var data = state.getFavoritesModel.data[index];
                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 8.w,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.1),
                                  blurRadius: 2.r,
                                ),
                              ]),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Assets.icons.shop.svg(),
                                  6.horizontalSpace,
                                  Text(
                                    data.storeName,
                                    style: textStyle(
                                        size: 12, weight: FontWeight.w500),
                                  ),
                                  const Spacer(),
                                  // ignore: deprecated_member_use_from_same_package
                                  Assets.icons.notification.svg(
                                      color: AppColors.ffF05A27OrangeColor),
                                  const Icon(
                                    Icons.favorite,
                                    color: AppColors.ffF05A27OrangeColor,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Assets.icons.calendar.svg(),
                                  6.horizontalSpace,
                                  Text(
                                    'تاريخ اخر فاتورة',
                                    style: textStyle(
                                        size: 12, weight: FontWeight.w500),
                                  ),
                                  const Spacer(),
                                  Text(
                                    Jiffy.parse(data.dateInvoice).yMEd,
                                    style: textStyle(
                                        size: 12,
                                        weight: FontWeight.w500,
                                        color: AppColors.ff5A5D61SubText),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Assets.icons.receipt2.svg(),
                                  6.horizontalSpace,
                                  Text(
                                    'عدد الفواتير',
                                    style: textStyle(
                                        size: 12, weight: FontWeight.w500),
                                  ),
                                  const Spacer(),
                                  Text(
                                    data.invoicesNumberInvoices,
                                    style: textStyle(
                                        size: 12,
                                        weight: FontWeight.w500,
                                        color: AppColors.ff5A5D61SubText),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "There are some ERRORS , Please try again later",
                        style: textStyle(),
                      ),
                    );
        },
      ),
    );
  }
}
