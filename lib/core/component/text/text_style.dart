import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youapp_test/core/core.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle normalMontserrat({
    TextDecoration? textDecoration,
    double? fontSize,
    Color? color,
    double? height,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.montserrat().copyWith(
      fontSize: fontSize ?? 14,
      color: color ?? AppColors().hWhite,
      fontWeight: fontWeight ?? FontWeight.w400,
      decoration: textDecoration,
      height: height,
    );
  }

  static TextStyle mediumMontserrat({
    TextDecoration? textDecoration,
    double? fontSize,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.montserrat().copyWith(
      fontWeight: FontWeight.w500,
      fontSize: fontSize ?? 14,
      color: color ?? AppColors().hWhite,
      decoration: textDecoration,
      height: height,
    );
  }

  static TextStyle semiBoldMontserrat({
    TextDecoration? textDecoration,
    double? fontSize,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.montserrat().copyWith(
      fontWeight: FontWeight.w600,
      fontSize: fontSize ?? 14,
      color: color ?? AppColors().hWhite,
      decoration: textDecoration,
      height: height,
    );
  }

  static TextStyle boldMontserrat({
    TextDecoration? textDecoration,
    double? fontSize,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.montserrat().copyWith(
      fontWeight: FontWeight.w700,
      fontSize: fontSize ?? 14,
      color: color ?? AppColors().hWhite,
      decoration: textDecoration,
      height: height,
    );
  }

  static TextStyle regular({
    TextDecoration? textDecoration,
    double? fontSize,
    Color? color,
    double? height,
    FontWeight? fontWeight,
  }) {
    return GoogleFonts.inter().copyWith(
      fontSize: fontSize ?? 14,
      color: color ?? AppColors().hWhite,
      fontWeight: fontWeight ?? FontWeight.w400,
      decoration: textDecoration,
      height: height,
    );
  }

  static TextStyle medium({
    TextDecoration? textDecoration,
    double? fontSize,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.inter().copyWith(
      fontWeight: FontWeight.w500,
      fontSize: fontSize ?? 14,
      color: color ?? AppColors().hWhite,
      decoration: textDecoration,
      height: height,
    );
  }

  static TextStyle semiBold({
    TextDecoration? textDecoration,
    double? fontSize,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.inter().copyWith(
      fontWeight: FontWeight.w600,
      fontSize: fontSize ?? 14,
      color: color ?? AppColors().hWhite,
      decoration: textDecoration,
      height: height,
    );
  }

  static TextStyle bold({
    TextDecoration? textDecoration,
    double? fontSize,
    Color? color,
    double? height,
  }) {
    return GoogleFonts.inter().copyWith(
      fontWeight: FontWeight.w700,
      fontSize: fontSize ?? 14,
      color: color ?? AppColors().hWhite,
      decoration: textDecoration,
      height: height,
    );
  }

  static TextStyle extraBold({
    TextDecoration? textDecoration,
    double? fontSize,
    Color? color,
    double? height,
}) {
    return GoogleFonts.inter().copyWith(
      fontWeight: FontWeight.w800,
      fontSize: fontSize ?? 14,
      color: color ?? AppColors().hWhite,
      decoration: textDecoration,
      height: height,
    );
  }
}
