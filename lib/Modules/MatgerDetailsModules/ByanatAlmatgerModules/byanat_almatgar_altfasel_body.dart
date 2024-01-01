import 'package:fawatery_user/Controllers/GetStoreBranchesBloc/get_store_branches_bloc.dart';
import 'package:fawatery_user/Controllers/GetStoreBranchesBloc/get_store_branches_event.dart';
import 'package:fawatery_user/Controllers/GetStoreBranchesBloc/get_store_branches_state.dart';
import 'package:fawatery_user/Models/AllStoresModel/all_stores_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../gen/assets.gen.dart';

class ByanatAlmatgarAltfaselBody extends StatelessWidget {
  const ByanatAlmatgarAltfaselBody({
    super.key,
    required this.storeData,
  });
  final AllStoresDatum storeData;
  @override
  Widget build(BuildContext context) {
    final StoreBranchesBloc storeBranchesBloc =
        KiwiContainer().resolve<StoreBranchesBloc>();
    storeBranchesBloc
        .add(GetStoreBranchesEventStart(storeId: storeData.id.toString()));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          12.verticalSpace,
          Row(
            children: [
              Assets.icons.callCalling.svg(),
              4.horizontalSpace,
              Text(
                storeData.phone,
                style: textStyle(size: 12, color: AppColors.ff5A5D61SubText),
              )
            ],
          ),
          12.verticalSpace,
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: AppColors.ffF05A27OrangeColor,
                size: 21,
              ),
              4.horizontalSpace,
              Text(
                storeData.address,
                style: textStyle(size: 12, color: AppColors.ff5A5D61SubText),
              )
            ],
          ),
          12.verticalSpace,
          Container(
            height: 188.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: const DecorationImage(
                    image: NetworkImage(
                        'https://s3-alpha-sig.figma.com/img/4e79/3be5/f1cd140a075f662066c5f5e2695a6dc6?Expires=1696809600&Signature=X~lDDM27-dz43wbXC7dM3gzWMPn3faXY0F~DFr9LKeJo2DMM1bs312SzshAG-r0YLNpo6r-i6s28NvFndOstNnrfQrl1cOBdnogohYSoli6AreO8heO5iP~o69kLWgHPoYw5IaByr991UfHviCdX3-opVDTzl~38SIQoeU202AyNxnOjJFeCwQ7sgri0-9Z6IhgTY5nqJK5~4Ud3YFyb2ri13DLiut9SxK369YTa4BuPHBEIlAVjkRisuFawqiMQTRrkRfneBc9Vr6GPhMlaI5uo0EwqHdYqJ1wdgd1P6Xg6FqR-Eh2pXDUPdqRCtSKMtTZzotDMK5wqcIzwAnZCIQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4'),
                    fit: BoxFit.fill)),
          ),
          12.verticalSpace,
          Text(
            'الفروع',
            style: textStyle(
                color: AppColors.ffF05A27OrangeColor,
                size: 18,
                weight: FontWeight.w500),
          ),
          12.verticalSpace,
          BlocBuilder(
            bloc: storeBranchesBloc,
            builder: (context, state) {
              return state is GetStoreBranchesStateStart
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : state is GetStoreBranchesStateSuccess
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.storeBranchesModel.data.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return 12.verticalSpace;
                          },
                          itemBuilder: (BuildContext context, int index) {
                            var data = state.storeBranchesModel.data[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${index + 1}- ${data.branch}',
                                  style: textStyle(
                                      size: 18, weight: FontWeight.w500),
                                ),
                                12.verticalSpace,
                                Row(
                                  children: [
                                    Assets.icons.callCalling.svg(),
                                    4.horizontalSpace,
                                    Text(
                                      '01024583573',
                                      style: textStyle(
                                          size: 12,
                                          color: AppColors.ff5A5D61SubText),
                                    )
                                  ],
                                ),
                                12.verticalSpace,
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_rounded,
                                      color: AppColors.ffF05A27OrangeColor,
                                      size: 21,
                                    ),
                                    4.horizontalSpace,
                                    Text(
                                      data.address,
                                      style: textStyle(
                                          size: 12,
                                          color: AppColors.ff5A5D61SubText),
                                    )
                                  ],
                                ),
                                12.verticalSpace,
                                Container(
                                  height: 188.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      image: const DecorationImage(
                                          image: NetworkImage(
                                              'https://s3-alpha-sig.figma.com/img/4e79/3be5/f1cd140a075f662066c5f5e2695a6dc6?Expires=1696809600&Signature=X~lDDM27-dz43wbXC7dM3gzWMPn3faXY0F~DFr9LKeJo2DMM1bs312SzshAG-r0YLNpo6r-i6s28NvFndOstNnrfQrl1cOBdnogohYSoli6AreO8heO5iP~o69kLWgHPoYw5IaByr991UfHviCdX3-opVDTzl~38SIQoeU202AyNxnOjJFeCwQ7sgri0-9Z6IhgTY5nqJK5~4Ud3YFyb2ri13DLiut9SxK369YTa4BuPHBEIlAVjkRisuFawqiMQTRrkRfneBc9Vr6GPhMlaI5uo0EwqHdYqJ1wdgd1P6Xg6FqR-Eh2pXDUPdqRCtSKMtTZzotDMK5wqcIzwAnZCIQ__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4'),
                                          fit: BoxFit.fill)),
                                ),
                                12.verticalSpace,
                              ],
                            );
                          },
                        )
                      : 0.horizontalSpace;
            },
          ),
        ],
      ),
    );
  }
}
