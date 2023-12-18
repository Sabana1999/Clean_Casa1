import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE4E6E5),
  100: Color(0xFFBAC1BE),
  200: Color(0xFF8D9793),
  300: Color(0xFF5F6D67),
  400: Color(0xFF3C4E47),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF172A22),
  700: Color(0xFF13231C),
  800: Color(0xFF0F1D17),
  900: Color(0xFF08120D),
});
 const int _primaryPrimaryValue = 0xFF1A2F26;

const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFF55FFAA),
  200: Color(_primaryAccentValue),
  400: Color(0xFF00EE77),
  
  700: Color(0xFF00D46A),
});
const int _primaryAccentValue = 0xFF22FF90;