import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../themes/main_theme.dart';

class SuccessDialog extends StatelessWidget {
  final String successMsg;
  final String? buttonMsg;
  final Function()? onPressed;
  final String secondaryMsg;
  final Function()? onSecondaryPressed;
  final String? secondaryButtonText;
  const SuccessDialog(
      {Key? key, required this.successMsg, this.buttonMsg, this.onPressed, required this.secondaryMsg, this.onSecondaryPressed, this.secondaryButtonText});

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
                height: 95,
                width: 95,
                child: SvgPicture.asset("assets/images/icons/thumbs_up_filled.svg"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
              child: Text(
                successMsg,
                textAlign: TextAlign.center,
                style:
                 TextStyle(color: MainTheme.appColors.activeGreen400,
                    fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0,  left: 24.0, right: 24.0),
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
            _showMainButton()
          ],
        ),
      ),
    );
  }

  _showMainButton() {
    if (buttonMsg != null) {
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0)),
            color: MainTheme.appColors.activeGreen200,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonMsg!,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MainTheme.appColors.activeGreen600),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Padding(padding: EdgeInsets.all(12.0));
    }
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