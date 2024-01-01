import 'package:fawatery_user/Controllers/CreateInvoiceBloc/create_invoice_bloc.dart';
import 'package:fawatery_user/Controllers/CreateInvoiceBloc/create_invoice_collect_data.dart';
import 'package:fawatery_user/Controllers/CreateInvoiceBloc/create_invoice_event.dart';
import 'package:fawatery_user/Controllers/CreateInvoiceBloc/create_invoice_state.dart';
import 'package:fawatery_user/Controllers/GetProfileBloc/image_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kiwi/kiwi.dart';

import '../../../Controllers/CreateBillsController/create_bills_controller.dart';
import '../../../Shared/Components/container_button.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../Shared/Constants/constant_strings.dart';
import '../../../gen/assets.gen.dart';

class CreateFatoraByImageBody extends StatelessWidget {
  const CreateFatoraByImageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateInvoiceBloc createInvoiceBloc =
        KiwiContainer().resolve<CreateInvoiceBloc>();

    final ImageCubit imageCubit = KiwiContainer().resolve<ImageCubit>();

    CreateInvoiceCollectData collectData = CreateInvoiceCollectData();

    final GlobalKey<FormState> formKey = GlobalKey();

    return GetBuilder<CreateBillsController>(
      init: CreateBillsController(),
      builder: (_) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                16.verticalSpace,
                //************ name *********** */
                CreateByImageFatoraTextFeild(
                  onSaved: (p0) {
                    collectData.storeName = p0;
                  },
                  validator: (p0) {
                    return p0!.isEmpty ? "Enter the name" : null;
                  },
                  title: AppStrings.matgarName,
                  hint: AppStrings.enterMatgarNameHint,
                ),
                16.verticalSpace,

                //*********** image ************* */
                BlocBuilder(
                  bloc: imageCubit,
                  builder: (context, state) {
                    return
                        // state is ImageCubitStateSuccess ?
                        InkWell(
                      onTap: () {
                        imageCubit.getAddPics(source: ImageSource.camera);
                      },
                      child: CreateByImageFatoraTextFeild(
                        onSaved: (p0) {},
                        validator: (p0) {
                          return null;
                        },
                        isEnable: false,
                        isUploadImage: true,
                        title: AppStrings.fatoraImage,
                        hint: state is ImageCubitStateSuccess
                            ? state.profileImage.path
                            : AppStrings.fatoraImageHint,
                      ),
                    );
                  },
                ),
                16.verticalSpace,

                //*********** date ************ */
                CreateByImageFatoraTextFeild(
                  onSaved: (p0) {
                    collectData.dateInvoice = p0;
                  },
                  validator: (p0) {
                    return null;
                  },
                  isEnable: false,
                  isCalender: true,
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year),
                            lastDate: DateTime(DateTime.now().year, 12, 31))
                        .then((value) =>
                            _.changeDateController(value.toString()));
                  },
                  title: AppStrings.fatoraDate,
                  hint: _.dateController.text.isNotEmpty
                      ? _.dateController.text.split(' ').first
                      : '18/8/2023',
                ),
                16.verticalSpace,

                //************ total *********** */
                CreateByImageFatoraTextFeild(
                  onSaved: (p0) {
                    collectData.totalInvoice = p0;
                  },
                  validator: (p0) {
                    return p0!.isEmpty ? 'Enter the Value' : null;
                  },
                  title: AppStrings.fatoraPrice,
                  hint: AppStrings.fatoraPriceHint,
                ),
                60.verticalSpace,
                BlocBuilder(
                  bloc: createInvoiceBloc,
                  builder: (context, state) {
                    return state is CreateInvoiceByImageStateStart
                        ? const CupertinoActivityIndicator()
                        : CustomContainerButton(
                            title: AppStrings.creatFatora,
                            width: .9.sw,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                collectData.dateInvoice = _.dateController.text;
                                collectData.invoiceImage =
                                    imageCubit.profileImage;
                                createInvoiceBloc.add(
                                    CreateInvoiceByImageEventStart(
                                        createInvoiceCollectData: collectData));
                              }

                              // Get.dialog(
                              //     const AddFatoraSuccessDialogeContainer());
                            },
                          );
                  },
                ),
                60.verticalSpace
              ],
            ),
          ),
        );
      },
    );
  }
}

class CreateByImageFatoraTextFeild extends StatelessWidget {
  const CreateByImageFatoraTextFeild(
      {super.key,
      required this.title,
      required this.hint,
      this.isEnable = true,
      this.isCalender = false,
      this.isUploadImage = false,
      this.onTap,
      required this.onSaved,
      required this.validator});
  final String title, hint;
  final bool isEnable, isUploadImage, isCalender;
  final void Function()? onTap;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle(size: 16),
        ),
        InkWell(
          onTap: onTap,
          child: TextFormField(
            enableInteractiveSelection: false,
            enabled: isEnable,
            validator: validator,
            onSaved: onSaved,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsetsDirectional.only(top: 10.h, start: 10.w),
                prefixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
                  10.horizontalSpace,
                  if (isCalender) Assets.icons.calendar.svg(),
                  if (isUploadImage)
                    const Icon(
                      Icons.image_search_rounded,
                      color: AppColors.ffC1C2C3Icons,
                    ),
                  10.horizontalSpace,
                ]),
                hintText: hint,
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 24.w,
                ),
                hintStyle: textStyle(color: AppColors.ffC1C2C3Icons),
                border: OutlineInputBorder(
                    gapPadding: 16.h,
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: AppColors.ffEBEBECBorder,
                    ))),
          ),
        )
      ],
    );
  }
}
