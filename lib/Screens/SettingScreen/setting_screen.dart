import 'package:flutter/material.dart';

import '../../Modules/SettingModules/setting_body.dart';
import '../../Shared/Constants/constant_strings.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settingTab),
      ),
      body: const SettingBody(),
    );
  }
}
