import 'package:fawatery_user/Controllers/AddRemoveFavoriteBloc/add_remove_favorite_bloc.dart';
import 'package:fawatery_user/Controllers/AddRemoveFavoriteBloc/add_remove_favorite_collect_data.dart';
import 'package:fawatery_user/Controllers/AddRemoveFavoriteBloc/add_remove_favorite_event.dart';
import 'package:fawatery_user/Controllers/HomeBloc/home_bloc.dart';
import 'package:fawatery_user/Models/GetAllInvoices/get_all_invoices_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiwi/kiwi.dart';

import '../../Shared/Components/container_button.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../gen/assets.gen.dart';
import '../CreateFatoraModules/MyFawaterModules/my_fatora_show_details_dialog.dart';

class HomeAlFwaterListViewContainer extends StatelessWidget {
  const HomeAlFwaterListViewContainer({
    super.key,
    required this.datum,
    required this.homeBloc,
    required this.index,
  });
  final GetAllInvoicesDatum datum;
  final HomeBloc homeBloc;
  final int index;
  @override
  Widget build(BuildContext context) {
    final AddRemoveFavoriteBloc addRemoveFavoriteBloc =
        KiwiContainer().resolve<AddRemoveFavoriteBloc>();
    return Column(
      children: [
        Row(
          children: [
            Text(
              datum.storeName,
              style: textStyle(weight: FontWeight.w500),
            ),
            const Spacer(),
            BlocBuilder(
              bloc: addRemoveFavoriteBloc,
              builder: (context, state) {
                return IconButton(
                    onPressed: () {
                      addRemoveFavoriteBloc.add(datum.favorite
                          ? AddRemoveFavoriteEventStart(
                              addRemoveFavoriteCollectDate:
                                  AddRemoveFavoriteCollectDate(
                                      favorite: 'false',
                                      invoiceId: datum.invoicesId.toString()))
                          : AddRemoveFavoriteEventStart(
                              addRemoveFavoriteCollectDate:
                                  AddRemoveFavoriteCollectDate(
                                      favorite: 'true',
                                      invoiceId: datum.invoicesId.toString())));
                      homeBloc.isLocalFavorite[index] =
                          !homeBloc.isLocalFavorite[index];
                    },
                    icon: Icon(
                      homeBloc.isLocalFavorite[index]
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: AppColors.ffF05A27OrangeColor,
                    ));
              },
            )
          ],
        ),
        20.verticalSpace,
        Row(
          children: [
            Assets.icons.calendar.svg(),
            Text(
              Jiffy.parse(datum.dateInvoice).yMMMEdjm,
              style: textStyle(size: 12, weight: FontWeight.w500),
            )
          ],
        ),
        14.verticalSpace,
        Row(
          children: [
            Assets.icons.moneys.svg(),
            Text(
              '${datum.totalInvoice} جنية',
              style: textStyle(size: 12, weight: FontWeight.w500),
            )
          ],
        ),
        21.verticalSpace,
        CustomContainerButton(
          title: 'عرض التفاصيل',
          textColor: AppColors.ffF05A27OrangeColor,
          color: AppColors.ffFEEFE9PrimaryLight,
          borderColor: Colors.transparent,
          onPressed: () {
            Get.dialog(
                MyFatoraShowDetailsDialog(id: datum.invoicesId.toString()));
          },
        )
      ],
    );
  }
}
