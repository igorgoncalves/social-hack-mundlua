import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeConfig {
  static final ThemeConfig _instanceSingleton = ThemeConfig._internal();

  factory ThemeConfig() {
    return _instanceSingleton;
  }

  get primaryColor => Colors.redAccent;

  CupertinoThemeData primaryTheme() {
    
    const double navTitleFontSize = 24;
    const int primaryColorTone = 100;

    return CupertinoThemeData(
      primaryColor: this.primaryColor[primaryColorTone],
      textTheme: CupertinoTextThemeData(
        navTitleTextStyle: TextStyle(
          color: this.primaryColor[primaryColorTone],
          fontWeight: FontWeight.bold,
          fontSize: navTitleFontSize,
        ),
      ),
    );
  }

  ThemeConfig._internal();
}
