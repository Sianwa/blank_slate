import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../themes/main_theme.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

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
                height: 72,
                width: 72,
                child: SvgPicture.asset("assets/images/icons/error_filled.svg"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Logout Confirmation",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MainTheme.appColors.primaryRed500,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Text(
                "Are you sure you'd like to proceed and leave the application?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MainTheme.appColors.neutral900,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            showSecondaryButton(context),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(true);
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
                      "Logout",
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
      return GestureDetector(
        onTap:() {
          Navigator.of(context).pop(false);
        },
        child: Container(
          height: 50,
          width: double.infinity,
          color: Colors.blue.shade50,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Cancel",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              ),
            ],
          ),
        ),
      );
  }
}
