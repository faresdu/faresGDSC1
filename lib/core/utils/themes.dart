import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
import 'dynamic_constants.dart';
import 'helper_functions.dart';

var lightThemeData = (primary, secondary) => ThemeData(
      primaryColor: primary,
      brightness: Brightness.light,
      textTheme: GoogleFonts.cairoTextTheme().apply(
          bodyColor: LightConstants.black, displayColor: LightConstants.black),
      fontFamily: GoogleFonts.cairo().fontFamily,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: LightConstants.background,
        selectedItemColor: primary,
        unselectedItemColor: LightConstants.black,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Constants.white,
      ),
      scaffoldBackgroundColor: LightConstants.background,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch(
              cardColor: LightConstants.cardBackground,
              brightness: Brightness.light,
              primarySwatch: HelperFunctions.createMaterialColor(primary))
          .copyWith(
              primary: primary,
              background: LightConstants.background,
              secondary: secondary,
              error: Constants.negative),
      bottomAppBarTheme:
          const BottomAppBarTheme(color: LightConstants.cardBackground),
    );

var darkThemeData = (primary, secondary) => ThemeData(
      primaryColor: primary,
      brightness: Brightness.dark,
      textTheme: GoogleFonts.cairoTextTheme().apply(
          bodyColor: DarkConstants.black, displayColor: DarkConstants.black),
      fontFamily: GoogleFonts.cairo().fontFamily,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Constants.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: DarkConstants.background,
        selectedItemColor: primary,
        unselectedItemColor: DarkConstants.black,
      ),
      scaffoldBackgroundColor: DarkConstants.background,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch(
              cardColor: DarkConstants.cardBackground,
              brightness: Brightness.dark,
              primarySwatch: HelperFunctions.createMaterialColor(primary))
          .copyWith(
              primary: primary,
              background: DarkConstants.background,
              secondary: secondary,
              error: Constants.negative),
      bottomAppBarTheme:
          const BottomAppBarTheme(color: DarkConstants.cardBackground),
    );
