import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFA2C98D);
const PrimaryColorLight = Color.fromARGB(255, 234, 234, 234);
const PrimaryColorDark = Color.fromARGB(255, 71, 71, 71);

const SecondaryColor = const Color(0xFFEB7B47);
const SecondaryColorLight = const Color(0xFFe5ffff);
const SecondaryColorDark = const Color(0xFF82ada9);

const Background = Color.fromARGB(255, 255, 255, 255);
const TextColor = Color.fromARGB(255, 34, 34, 34);

class mainTheme {
  static final ThemeData defaultTheme = _buildMyTheme();

  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      accentColor: SecondaryColor,
      accentColorBrightness: Brightness.dark,
      
      primaryColor: PrimaryColor,
      primaryColorDark: PrimaryColorDark,
      primaryColorLight: PrimaryColorLight,
      primaryColorBrightness: Brightness.dark,

      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: SecondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: Background,
      ),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: PrimaryColor,
      ),
      scaffoldBackgroundColor: Background,
      cardColor: Background,
      textSelectionColor: PrimaryColorLight,
      backgroundColor: Background,
      bottomAppBarTheme: base.bottomAppBarTheme.copyWith(
        elevation: 0,

      )
      
      /*textTheme: base.textTheme.copyWith(
          titleLarge: base.textTheme.titleLarge?.copyWith(color: TextColor),
          bodyText1: base.textTheme.bodyText1?.copyWith(color: TextColor),
          bodyText2: base.textTheme.bodyText2?.copyWith(color: TextColor)
      ),*/
    );
  }
}