import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youapp_test/core/core.dart';

ThemeData defaultTheme(BuildContext context) => ThemeData(
  primarySwatch: AppColors().mPrimary,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: AppColors().hBlack,
  unselectedWidgetColor: Colors.grey,
  textTheme: GoogleFonts.nunitoTextTheme(
    Theme.of(context).textTheme.apply(
      bodyColor: AppColors().hBlack,
      displayColor: AppColors().hBlack,
    ),
  ),
  primaryColor: AppColors().hPrimary2,
  colorScheme: ColorScheme.dark(primary: AppColors().hPrimary2),
  primaryColorDark: AppColors().hPrimary2,
  appBarTheme: AppBarTheme(
    color: AppColors().hBlack,
  ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 10,
    ),
    labelStyle: const TextStyle(color: Colors.black),
    hintStyle: const TextStyle(color: Colors.black),
    hoverColor: Colors.black,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(color: Colors.grey),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
  ),
);