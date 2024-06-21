import 'package:get/get.dart';
import 'package:calendarevents/styles/thems.dart';
import 'package:calendarevents/local/cashhelper.dart';


var isDarkMode = false.obs;

void onchangeThem() {
  //! using Get
  if (Get.isDarkMode) {
    Get.changeTheme(Themes.lightTheme);
    print("light");
    CashHelper.setTheme(key: "isdark", value: false);
  } else {
    Get.changeTheme(Themes.darkThem);
    print("dark");
    CashHelper.setTheme(key: "isdark", value: true);
  }
}

// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:get/get.dart';
//
// class ThemeService {
//   final _box = GetStorage();
//   final _key = "isDarkMode";
//
//   _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
//
//   bool _loadThemeFormBox() => _box.read(_key) ?? false;
//   ThemeMode get theme => _loadThemeFormBox() ? ThemeMode.dark : ThemeMode.light;
//
//   void switchTheme() {
//     Get.changeThemeMode(_loadThemeFormBox() ? ThemeMode.light : ThemeMode.dark);
//     _saveThemeToBox(!_loadThemeFormBox());
//   }
// }
