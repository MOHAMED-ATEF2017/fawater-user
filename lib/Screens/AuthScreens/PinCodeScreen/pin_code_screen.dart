import 'package:flutter/material.dart';

import '../../../Modules/PinCodeModule/pin_code_container.dart';

class PinCodeScreen extends StatelessWidget {
  const PinCodeScreen({super.key,  this.isFromLogin = true});
  final bool isFromLogin;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PinCodeContainer(
        isFromLogin: isFromLogin,
      ),
    );
  }
}
