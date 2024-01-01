import 'package:flutter/material.dart';

import '../../../Modules/NewPasswordModules/new_password_container.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NewPasswordContainer(),
    );
  }
}
