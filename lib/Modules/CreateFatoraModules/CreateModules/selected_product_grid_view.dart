import 'package:fawatery_user/Shared/Components/container_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Controllers/GetAllProductsBloc/get_all_products_cubit.dart';
import '../../../Controllers/GetAllProductsBloc/get_all_products_state.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';

class SelectedProductsGridView extends StatefulWidget {
  const SelectedProductsGridView({
    super.key,
    required this.getAllProductsCubit,
    // required this.getProductsBloc,
  });

  final GetAllProductsCubit getAllProductsCubit;

  @override
  State<SelectedProductsGridView> createState() =>
      _SelectedProductsGridViewState();
}

class _SelectedProductsGridViewState extends State<SelectedProductsGridView> {
  // final GetAllProductsBloc getProductsBloc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.getAllProductsCubit,
      builder: (context, cubitState) {
        return cubitState is GetAllStateChangeGroupValue
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 180.w / 125.h),
                itemCount: widget.getAllProductsCubit.selectedProduct.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.getAllProductsCubit.selectedProduct[index]
                            ['name'],
                        style: textStyle(),
                      ),
                      Row(
                        children: [
                          Text(
                            'عدد: ',
                            style: textStyle(
                                size: 12, color: AppColors.ff5A5D61SubText),
                          ),
                          CustomContainerButton(
                            title: '+',
                            width: 30.w,
                            height: 30.w,
                            onPressed: () {
                              setState(() {
                                widget
                                    .getAllProductsCubit.selectedProduct[index]
                                    .update('Quantity', (value) => value + 1);
                              });
                            },
                          ),
                          10.horizontalSpace,
                          Text(
                            widget.getAllProductsCubit
                                .selectedProduct[index]['Quantity']
                                .toString(),
                            style: textStyle(
                                size: 12, color: AppColors.ff5A5D61SubText),
                          ),
                          10.horizontalSpace,
                          CustomContainerButton(
                            title: '-',
                            width: 30.w,
                            height: 30.w,
                            onPressed: () {
                              if (widget.getAllProductsCubit
                                      .selectedProduct[index]['Quantity'] >
                                  1) {
                                setState(() {
                                  widget.getAllProductsCubit
                                      .selectedProduct[index]
                                      .update('Quantity', (value) => value - 1);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      SizedBox(
                        height: 30.h,
                        child: Center(
                          child: TextFormField(
                            initialValue: widget.getAllProductsCubit
                                .selectedProduct[index]['price']
                                .toString(),
                            onChanged: (p0) {
                              setState(() {
                                widget
                                    .getAllProductsCubit.selectedProduct[index]
                                    .update('price', (value) => p0);
                              });
                            },
                            style: textStyle(
                                size: 12, color: AppColors.ff5A5D61SubText),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixText: 'جنية : ',
                              prefixStyle: textStyle(
                                  size: 12, color: AppColors.ff5A5D61SubText),
                            ),
                          ),
                        ),
                      ),
                      /*   Text(
                        '${widget.getAllProductsCubit.selectedProduct[index]['price']} جنية',
                        style: textStyle(
                            size: 12, color: AppColors.ff5A5D61SubText),
                      ), */
                    ],
                  );
                },
              )
            : 0.horizontalSpace;
      },
    );
  }
}
