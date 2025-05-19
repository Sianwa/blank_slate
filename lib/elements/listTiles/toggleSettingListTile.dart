import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/appSettingModel.dart';
import '../../themes/main_theme.dart';
import '../../utils/services/user_preferences.dart';
import '../dialogs/failureDialog.dart';

class ToggleSettingListTile extends StatefulWidget {
  final String icon;
  final String title;
  final String? description;
  final Color? contentColor;
  final Color? iconColor;
  final bool? isEnabled;

  final AppSettingType settingType;

  const ToggleSettingListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.settingType,
      this.description,
      this.contentColor,
      this.iconColor,
      this.isEnabled});

  @override
  State<ToggleSettingListTile> createState() => _ToggleSettingListTileState();
}

class _ToggleSettingListTileState extends State<ToggleSettingListTile> {
  List<String> selectedQuickActions = [];
  UserPreferences userPreferences = UserPreferences();
  late bool toggleOn;

  @override
  void initState() {
    toggleOn = widget.isEnabled ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {},
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
                                    color: widget.contentColor ??
                                        (isDark
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
              Transform.scale(
                scale: 0.8,
                child: (widget.title.contains("Notifications"))
                    ? CupertinoSwitch(
                        activeColor: MainTheme.appColors.neutral400,
                        thumbColor: MainTheme.appColors.white,
                        trackColor: MainTheme.appColors.primaryBlue400,
                        value: toggleOn,
                        onChanged: (bool value) {})
                    : CupertinoSwitch(
                        activeColor: isDark
                            ? MainTheme.appColors.activeYellow400
                            : MainTheme.appColors.primaryBlue400,
                        thumbColor: MainTheme.appColors.white,
                        trackColor: MainTheme.appColors.neutral400,
                        value: toggleOn,
                        onChanged: (bool value) {
                          modifySelection(value, widget.title);
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void modifySelection(bool value, String title) async {
    if(widget.settingType == AppSettingType.appTheme){
      await userPreferences.saveThemePreference(value);
      setState(() {
        toggleOn = value;
      });
    }
    else if (widget.settingType == AppSettingType.videoSetting) {
      await userPreferences.saveVideoPreference(value);
      setState(() {
        toggleOn = value;
      });
    }
    else if (widget.settingType == AppSettingType.biometrics) {
      if (value == false) {
        showDialog(
            context: context,
            builder: (ctx) {
              return FailureDialog(
                failureMsg: "Disable Biometrics",
                secondaryMsg: "Are you sure you want to disable biometrics",
                buttonText: "Yes, proceed",
                onPressed: () async {
                   await userPreferences
                          .saveBiometricsLoginPreference(value)
                          .then((value) => Navigator.of(ctx).pop());

                  setState(() {
                    toggleOn = value;
                  });
                },
                secondaryButtonText: "No, cancel",
                onSecondaryPressed: () {
                  Navigator.of(ctx).pop();
                },
              );
            });
      } else {
         await userPreferences.saveBiometricsLoginPreference(value);
        setState(() {
          toggleOn = value;
        });
      }
    }
  }

  Future<void> toggleNotificationSetting(String title, bool value) async {
      setState(() {
        toggleOn = value;
      });
  }
}
