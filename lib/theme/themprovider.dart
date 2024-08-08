



import 'package:flutter/material.dart';

import 'package:the_wall_social_media/theme/darkmode.dart';
import 'package:the_wall_social_media/theme/lightmode.dart';

class ThemeProvider extends ChangeNotifier{


  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode =>_themeData == darkMode;

  set themeData(ThemeData data){
    _themeData = data;

    notifyListeners();
  }

  void toggleTheme(){
    if(themeData == lightMode){
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
  }
}