import 'package:fawatery_user/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';

class HomeMyLocationText extends StatelessWidget {
  const HomeMyLocationText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 60.h,
        right: 16.w,
        left: 16.w,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.myLocation,
                  style:
                      textStyle(color: Colors.white, weight: FontWeight.w500),
                ),
                Text(
                  '3 شارع الثوره، المنصوره، مصر',
                  style: textStyle(color: Colors.white),
                ),
              ],
            ),
            const Spacer(),
            FutureBuilder(
                future: InitStorage.storage
                    .read(key: AppStrings.storageUserImageKey),
                builder: (context, snapshot) {
                  return Container(
                    width: 70.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: snapshot.data != null
                            ? NetworkImage(
                                '$baseUrlWithoutApi/${snapshot.data}')
                            : AssetImage(Assets.images.logo.path)
                                as ImageProvider,
                        fit: BoxFit.fill,
                        onError: (exception, stackTrace) {
                          logger.e(exception.toString());
                        },
                      ),
                    ),
                  );
                })
          ],
        ));
  }
}
