import 'package:flutter/material.dart';

import '../../Modules/ProfileModules/profile_body.dart';
import '../../Shared/Constants/constant_strings.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.e3datadAlmelafAlshaghsyText)),
      body: const ProfileBody(),
    );
  }
}
