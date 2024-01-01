import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:fawatery_user/Controllers/RatingBloc/rating_collect_data.dart';
import 'package:fawatery_user/Controllers/RatingBloc/rating_event.dart';
import 'package:fawatery_user/Controllers/RatingBloc/rating_state.dart';
import 'package:fawatery_user/Models/RatingModel/rating_model.dart';
import 'package:fawatery_user/Shared/Components/container_button.dart';
import 'package:fawatery_user/Shared/Constants/constant_strings.dart';
import 'package:fawatery_user/Shared/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiwi/kiwi.dart';

import '../../../Controllers/RatingBloc/rating_bloc.dart';
import '../../../Shared/Components/container_decoration.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../CreateFatoraModules/CreateModules/create_by_image.dart';

class ByanatAlmatgarRatingBody extends StatelessWidget {
  const ByanatAlmatgarRatingBody({
    super.key,
    required this.storeId,
  });
  final String storeId;
  @override
  Widget build(BuildContext context) {
    final RatingBloc ratingBloc = KiwiContainer().resolve<RatingBloc>();
    ratingBloc.add(GetRatingEventStart(storeId: storeId));
    return SingleChildScrollView(
      child: Column(
        children: [
          12.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            height: 30.h,
            decoration: BoxDecoration(
                color: AppColors.ffFEEFE9PrimaryLight,
                borderRadius: BorderRadius.circular(2.r)),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.dialog(AddCommentDialog(
                      ratingBloc: ratingBloc,
                      storeId: storeId,
                    ));
                  },
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.add,
                    size: 18.r,
                  ),
                  color: AppColors.ffF05A27OrangeColor,
                ),
                4.horizontalSpace,
                Text(
                  'اضف تقييمك',
                  style: textStyle(
                    size: 12,
                  ),
                ),
                const Spacer(),
                Text(
                  '4.7',
                  style: textStyle(size: 12),
                ),
                4.horizontalSpace,
                const Icon(
                  Icons.star,
                  color: AppColors.ffF05A27OrangeColor,
                  size: 18,
                )
              ],
            ),
          ),
          16.verticalSpace,
          BlocBuilder(
            bloc: ratingBloc,
            builder: (context, state) {
              return state is GetRatingStateStart
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : state is GetRatingStateSuccess
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              15.verticalSpace,
                          itemCount: state.getRatingsModel.data.length,
                          itemBuilder: (context, index) {
                            var data = state.getRatingsModel.data[index];
                            return CommentsContainer(data: data);
                          },
                        )
                      : 0.horizontalSpace;
            },
          )
        ],
      ),
    );
  }
}

class AddCommentDialog extends StatelessWidget {
  const AddCommentDialog({
    super.key,
    required this.ratingBloc,
    required this.storeId,
  });
  final RatingBloc ratingBloc;
  final String storeId;
  @override
  Widget build(BuildContext context) {
    AddRatingCollectData addRatingCollectData = AddRatingCollectData();
    final GlobalKey<FormState> formKey = GlobalKey();
    return SingleChildScrollView(
      child: Material(
        color: Colors.transparent,
        child: Container(
          alignment: AlignmentDirectional.center,
          margin: EdgeInsets.only(
              bottom: Get.mediaQuery.viewInsets.bottom > 0 ? 0.h : 300.h,
              top: 100.h,
              right: 30.w,
              left: 30.w),
          padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 30.w),
          decoration: customContainerBoxDecoration(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'أضف تقييمك',
                  style: textStyle(size: 18, weight: FontWeight.bold),
                ),
                20.verticalSpace,
                RatingBar(
                  alignment: Alignment.center,
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border_outlined,
                  onRatingChanged: (p0) {
                    addRatingCollectData.rating = p0.toString();
                  },
                  filledColor: AppColors.ffF05A27OrangeColor,
                ),
                18.verticalSpace,
                CreateByImageFatoraTextFeild(
                  title: 'أكتب تعليقك',
                  hint: '',
                  onSaved: (p0) {
                    addRatingCollectData.comment = p0;
                  },
                  validator: (p0) {
                    return p0!.isEmpty ? 'Please enter the comment' : null;
                  },
                ),
                18.verticalSpace,
                BlocBuilder(
                  bloc: ratingBloc,
                  builder: (context, state) {
                    return state is AddRatingStateStart
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : Row(
                            children: [
                              Expanded(
                                  child: CustomContainerButton(
                                title: AppStrings.confirm,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    ratingBloc.add(AddRatingEventStart(storeId,
                                        addRatingCollectData:
                                            addRatingCollectData));
                                  }
                                },
                              )),
                              50.horizontalSpace,
                              Expanded(
                                  child: CustomContainerButton(
                                title: AppStrings.cancel,
                                onPressed: () => Get.back(),
                                color: Colors.white,
                                textColor: AppColors.ffF05A27OrangeColor,
                              )),
                            ],
                          );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommentsContainer extends StatelessWidget {
  const CommentsContainer({
    super.key,
    required this.data,
  });

  final RatingDatum data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      decoration: customContainerBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage('$baseUrlWithoutApi${data.img}'))),
              ),
              8.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: textStyle(weight: FontWeight.w500),
                  ),
                  RatingBar.readOnly(
                    initialRating: double.parse(data.rating),
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border_outlined,
                    filledColor: AppColors.ffF05A27OrangeColor,
                    size: 15.w,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'منذ شهر',
                style: textStyle(size: 12, color: AppColors.ff5A5D61SubText),
              )
            ],
          ),
          12.verticalSpace,
          Text(
            "\t\t\t\t\t\t\t\t\t\t\t${data.comment}",
            style: textStyle(size: 12),
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
