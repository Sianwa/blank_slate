import 'package:flutter/material.dart';
import '../../themes/main_theme.dart';

class BlueArrowButton extends StatelessWidget {
  const BlueArrowButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
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
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(buttonText,
            style: TextStyle(
              color: MainTheme.appColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),),
            Icon(Icons.arrow_forward, color: MainTheme.appColors.white),
          ],
        ),
      ),
    );
  }
}
