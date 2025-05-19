import 'package:flutter/material.dart';

import '../../themes/main_theme.dart';

class RetryButton extends StatelessWidget {
  const RetryButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
  }) : super(key: key);

  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
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
            Icon(Icons.rotate_left_rounded, color: MainTheme.appColors.white),
          ],
        ),
      ),
    );
  }
}
