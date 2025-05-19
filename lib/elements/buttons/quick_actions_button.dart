import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../themes/main_theme.dart';

class QuickActionsButton extends StatelessWidget {
  const QuickActionsButton(
      {super.key,
      required this.assetName,
      required this.navigateTo,
      required this.actionName, this.color,
      this.onClick,
      });

  final String actionName;
  final String assetName;
  final String navigateTo;
  final Color? color;
  final Null Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            //todo: add your own tap functionality here
          },
          child: SizedBox(
            height: 64,
            width: 64,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: color ?? MainTheme.appColors.primaryBlue400,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset("assets/images/icons/$assetName"),
              ),
            ),
          ),
        ),
        Text(
          actionName,
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
