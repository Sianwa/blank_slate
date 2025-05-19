class AppSettingModel {
  String title;
  String icon;
  String description;
  AppSettingType settingType;
  String navigateTo;
  bool hasToggle;

  AppSettingModel(this.title, this.icon, this.settingType, this.description, this.navigateTo, this.hasToggle);
}

enum AppSettingType {
  regular, // has no particular action than navigating to another screen
  quickAction,
  videoSetting, // toggle list tile for landing page video
  notifications, // toggle list tile for notification settings
  biometrics, // toggle list tile for biometrics use
  appTheme // toggle list tile for app theme(dark / light)
}