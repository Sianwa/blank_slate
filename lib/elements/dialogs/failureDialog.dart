import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../themes/main_theme.dart';

class FailureDialog extends StatelessWidget {
  final String failureMsg;
  final String secondaryMsg;
  final String? buttonText;
  final Function()? onPressed;
  final Function()? onSecondaryPressed;
  final String? secondaryButtonText;

  const FailureDialog(
      {Key? key,
      required this.failureMsg,
      required this.secondaryMsg,
      this.buttonText,
      this.onPressed,
      this.onSecondaryPressed,
      this.secondaryButtonText});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: MainTheme.appColors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: SizedBox(
                height: 56,
                width: 56,
                child: SvgPicture.asset("assets/images/icons/error_filled.svg"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                failureMsg,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MainTheme.appColors.primaryRed500,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Text(
                secondaryMsg,
                textAlign: TextAlign.center,
                style:
                TextStyle(color: MainTheme.appColors.neutral900,
                    fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            showSecondaryButton(context),
            GestureDetector(
              onTap: (onPressed != null)
                  ? onPressed
                  : () {
                      Navigator.pop(context);
                    },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0)),
                  color: Colors.red.shade50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (buttonText != null) ? buttonText! : "Retry",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: MainTheme.appColors.primaryRed500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showSecondaryButton(context) {
    if (secondaryButtonText != null) {
      return GestureDetector(
        onTap: (onSecondaryPressed != null)
            ? onSecondaryPressed
            : () {
                Navigator.pop(context);
              },
        child: Container(
          height: 50,
          width: double.infinity,
          color: Colors.blue.shade50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                secondaryButtonText!,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Padding(padding: EdgeInsets.all(0.0));
    }
  }

}
