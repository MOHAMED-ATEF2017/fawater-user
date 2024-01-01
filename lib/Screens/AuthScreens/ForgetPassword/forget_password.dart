import 'package:flutter/material.dart';

import '../../../Modules/ForgetPasswordModules/forget_password_container.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ForgetPasswordContainer(),
    );
  }
}
