import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constants/constant_strings.dart';
import 'text_style.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          endIndent: 16.w,
        )),
        Text(
          AppStrings.orText,
          style: textStyle(),
        ),
        Expanded(
            child: Divider(
          indent: 16.w,
        )),
      ],
    );
  }
}
