import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../models/appSettingModel.dart';
import '../../themes/main_theme.dart';

class SettingListTile extends StatefulWidget {
  final String icon;
  final String title;
  final String? description;
  final Color? contentColor;
  final Color? iconColor;
  final Null Function()? onClick;
  final Null Function(bool)? onChecked;
  final String navigateTo;

  final AppSettingType settingType;

  const SettingListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.settingType,
      this.description,
      this.contentColor,
      this.iconColor,
      this.onClick,
      this.onChecked,
      required this.navigateTo});

  @override
  State<SettingListTile> createState() => _SettingListTileState();
}

class _SettingListTileState extends State<SettingListTile> {
  bool toggleOn = false;
  List<String> selectedQuickActions = [];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        if (widget.onClick != null) {
          widget.onClick!();
        } else {
          if (widget.navigateTo.isNotEmpty) {
            context.pushNamed(widget.navigateTo);
          }
        }
      },
      child: Card(
        color: isDark
            ? MainTheme.appColors.darkModeBlue100
            : MainTheme.appColors.neutral200,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                      height: 20,
                      width: 20,
                      "assets/images/icons/${widget.icon}",
                      colorFilter: ColorFilter.mode(
                          widget.iconColor ?? (isDark ? MainTheme.appColors.neutral400 : MainTheme.appColors.neutral700),
                          BlendMode.srcIn)),
                  Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: widget.contentColor ?? (isDark
                                        ? MainTheme.appColors.neutral100
                                        : MainTheme.appColors.primaryBlue400)),
                          ),
                          widget.description != null
                              ? Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 200),
                                  child: Text(
                                    widget.description!,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            widget.contentColor ?? Colors.grey),
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
