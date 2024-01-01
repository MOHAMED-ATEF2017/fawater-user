// ignore_for_file: deprecated_member_use
import 'package:fawatery_user/Controllers/NotificationBloc/notification_bloc.dart';
import 'package:fawatery_user/Controllers/NotificationBloc/notification_event.dart';
import 'package:fawatery_user/Controllers/NotificationBloc/notification_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kiwi/kiwi.dart';

import '../../Models/NotificationModel/notification_model.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../gen/assets.gen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationBloc notificationBloc =
        KiwiContainer().resolve<NotificationBloc>();
    notificationBloc.add(NotificationEventStart());
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.notificationTab),
      ),
      body: BlocBuilder(
        bloc: notificationBloc,
        builder: (context, state) {
          return state is NotificationStateStart
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : state is NotificationStateSuccess
                  ? state.notificationModel.data.isEmpty
                      ? Center(
                          child: Text(
                            "There aren't any notifications available yet",
                            style: textStyle(),
                          ),
                        )
                      : ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.notificationModel.data.length,
                          padding: EdgeInsets.all(16.w),
                          separatorBuilder: (BuildContext context, int index) {
                            return 16.verticalSpace;
                          },
                          itemBuilder: (BuildContext context, int index) {
                            var data = state.notificationModel.data[index];
                            return  NotificationContainer(data: data,);
                          },
                        )
                  : Center(
                      child: Text(
                        'There are some ERRORS, please try again later',
                        style: textStyle(),
                      ),
                    );
        },
      ),
    );
  }
}

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
    super.key, required this.data,
  });
final NotificationDatum data
;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 2.r)
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppColors.ffFEEFE9PrimaryLight),
            child: Assets.icons.notification
                // ignore: deprecated_member_use_from_same_package
                .svg(color: AppColors.ffF05A27OrangeColor),
          ),
          8.horizontalSpace,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'فاتوره رقم: ${data.numberInvoices}',
                    style: textStyle(
                        color: AppColors.ffC1C2C3Icons,
                        size: 11,
                        weight: FontWeight.w500),
                  ),
                  Text(
                    Jiffy.parseFromDateTime(data.createdAt).jm,
                    style: textStyle(
                        color: AppColors.ffC1C2C3Icons,
                        size: 11,
                        weight: FontWeight.w500),
                  )
                ],
              ),
              Text(
               data.titleNotification,
                style: textStyle(weight: FontWeight.w500),
              ),
              Text(
               data.messageNotification,
                style: textStyle(size: 12, color: AppColors.ff5A5D61SubText),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )
            ],
          ))
        ],
      ),
    );
  }
}
