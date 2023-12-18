import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
  
    primaryColor: Colors.deepOrange, secondaryHeaderColor: Colors.greenAccent,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),

      )
    ),
    iconButtonTheme: IconButtonThemeData(style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.deepOrange ))
    
    
      
      
    
    ));
