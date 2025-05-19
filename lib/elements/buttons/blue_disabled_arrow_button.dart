import 'package:flutter/material.dart';
import '../../themes/main_theme.dart';

class BlueDisabledArrowButton extends StatelessWidget {
  const BlueDisabledArrowButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        // resolveWith to change color based on state.
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return MainTheme.appColors.neutral400; // Disable
              }
              return MainTheme.appColors.activeBlue400; //Enable
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                color: MainTheme.appColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.arrow_forward, color: MainTheme.appColors.white),
          ],
        ),
      ),
    );
  }
}
