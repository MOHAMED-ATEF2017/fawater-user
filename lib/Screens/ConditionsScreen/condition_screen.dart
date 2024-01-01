import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Shared/Components/text_style.dart';

class ConditionScreen extends StatelessWidget {
  const ConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'الشروط والأحكام',
          style: textStyle(size: 16, weight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 80.h),
        child: Column(
          children: [
            Text(
              '''
1. التسجيل والحساب:
   1.1 يجب على جميع المستخدمين التسجيل وإنشاء حساب لاستخدام تطبيق طلبات الطعام.
   1.2 يجب أن يكون المستخدمون مسؤولين عن سرية معلومات حسابهم، ويجب عليهم عدم مشاركة معلومات الدخول الخاصة بهم مع الآخرين.
   1.3 يجب على المستخدمين تقديم معلومات صحيحة ودقيقة أثناء عملية التسجيل وإنشاء الحساب.

2. طلبات الطعام:
   2.1 يجب على المستخدمين تقديم طلبات الطعام من خلال التطبيق بشكل صحيح ودقيق.
   2.2 يجب أن يتم تحديد موقع التسليم بوضوح من قبل المستخدم وفقًا للتفاصيل المقدمة في التطبيق.
   2.3 يجب على المستخدمين تحديد التفاصيل الخاصة بالطلبات مثل الكمية المطلوبة والتفضيلات الغذائية والحساسيات المحتملة.

3. المسؤولية:
   3.1 لا يتحمل التطبيق أي مسؤولية عن جودة الطعام المقدم من قبل المطابخ المنزلية أو أي مشكلات صحية تنشأ عن ذلك.
   3.2 يجب على المستخدمين أن يتحملوا المسؤولية الكاملة عن استخدامهم للتطبيق وتنفيذ طلبات الطعام والتعامل مع المطابخ المنزلية.

4. الملكية الفكرية:
   4.1 يحتفظ التطبيق بجميع حقوق الملكية الفكرية المتعلقة بالتطبيق والمحتوى المتاح عليه.
   4.2 يُمنح المستخدمون رخصة غير قابلة للنقل وغير حصرية لاستخدام التطبيق وفقًا لشروط وأحكام الاستخدام.
''',
              style: textStyle(),
            )
          ],
        ),
      ),
    );
  }
}
