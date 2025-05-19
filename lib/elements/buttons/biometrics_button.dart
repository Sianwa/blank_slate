import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../themes/main_theme.dart';

class BiometricsButton extends StatelessWidget {
  const BiometricsButton({
    Key? key,
    required this.onPressed,
    required this.biometricType,
  }) : super(key: key);

  final Null Function() onPressed;
  final String biometricType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
          height: 48,
          width: 48,
          child: Card(
            elevation: 0,
            color: MainTheme.appColors.neutral200,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: MainTheme.appColors.primaryBlue400,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (biometricType == "FINGERPRINT ID") ?
              SvgPicture.asset("assets/images/icons/fingerprint.svg") :
              SvgPicture.asset("assets/images/icons/face_id.svg"),
            ),
          )
          ),
    );
  }
}
