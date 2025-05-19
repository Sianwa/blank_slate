import 'package:flutter/material.dart';

class CustomisableButton extends StatelessWidget {
  const CustomisableButton({
    super.key,
    required this.buttonText,
    required this.onPressed, required this.buttonColor, required this.buttonIcon, required this.buttonTextColor, required this.buttonIconColor,
  });

  final Color buttonColor;
  final String buttonText;
  final Color buttonTextColor;
  final IconData buttonIcon;
  final Color buttonIconColor;
  final Null Function() onPressed;

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
              color: buttonTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),),
            Icon(buttonIcon, color: buttonIconColor),
          ],
        ),
      ),
    );
  }
}
