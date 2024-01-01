import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Shared/Components/container_button.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/constant_strings.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Image.network(
          'https://th.bing.com/th/id/R.b2f621658181bab29f3a0a3711927aeb?rik=ohs4aNk7bXcm6w&riu=http%3a%2f%2ftoursmaps.com%2fwp-content%2fuploads%2f2017%2f10%2fnew-york-map-google-_4.png&ehk=SFFkvRX3RXLPb1ivoEraaiwJVYb62tQxSu9ERqytY0s%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1',
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
        height: 188.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.chooseLocation,
              style: textStyle(size: 22),
            ),
            Text(
              AppStrings.helloChooseLocation,
              style: textStyle(),
            ),
            const Spacer(),
            CustomContainerButton(
              title: AppStrings.confirmChooseLocation,
              width: 1.sw,
            )
          ],
        ),
      ),
    );
  }
}
