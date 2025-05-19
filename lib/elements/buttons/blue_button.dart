import 'package:flutter/material.dart';
import '../../themes/main_theme.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final Null Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(MainTheme.appColors.activeBlue400),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ))),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
