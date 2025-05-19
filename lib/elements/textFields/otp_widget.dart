import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../themes/main_theme.dart';

class OTPWidget extends StatefulWidget {
  const OTPWidget({super.key, required this.length, this.onChanged, required this.isObscured, this.controller});
  final int length;
  final bool isObscured;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  State<OTPWidget> createState() => OTPWidgetState();
}

class OTPWidgetState extends State<OTPWidget> {

  void setOTPValue(String otpValue) {
    widget.controller!.text = otpValue;
  }

  final defaultPinTheme = PinTheme(
    height: 62,
    textStyle: TextStyle(
        fontFamily: "Ubuntu",
        fontSize: 16,
        color: MainTheme.appColors.primaryBlue400,
        fontWeight: FontWeight.w800),
    decoration: BoxDecoration(
      color: MainTheme.appColors.neutral200,
      borderRadius: BorderRadius.circular(5),
    ),
  );

  final defaultDarkPinTheme = PinTheme(
    height: 62,
    textStyle: TextStyle(
        fontFamily: "Ubuntu",
        fontSize: 16,
        color: MainTheme.appColors.white,
        fontWeight: FontWeight.w800),
    decoration: BoxDecoration(
      color: MainTheme.appColors.darkModeBlue100,
      borderRadius: BorderRadius.circular(5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: widget.length,
      obscureText: widget.isObscured,
      defaultPinTheme: Theme.of(context).brightness == Brightness.dark ? defaultDarkPinTheme : defaultPinTheme,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      controller: widget.controller,
      onCompleted: widget.onChanged,
    );
  }

}
