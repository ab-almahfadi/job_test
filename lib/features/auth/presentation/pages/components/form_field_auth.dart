import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youapp_test/core/core.dart';

TextFormField formField({
  TextEditingController? controller,
  TextInputType? inputType,
  IconButton? suffixIcon,
  IconButton? preffixIcon,
  bool? obscure,
  String? hintText,
  EdgeInsetsGeometry? contentPadding,
  List<TextInputFormatter>? inputFormatter,
  void Function(String)? onChanged,
  String? errorText,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    textAlign: TextAlign.start,
    scrollPadding: const EdgeInsets.only(bottom: 100),
    keyboardType: inputType,
    style: const TextStyle(color: Colors.white),
    cursorColor: Colors.white,
    obscureText: obscure ?? false,
    textAlignVertical: TextAlignVertical.center,
    inputFormatters: inputFormatter,
    validator: validator,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      contentPadding: contentPadding,
      filled: true,
      fillColor: Colors.white.withOpacity(.06),
      hintText: hintText,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(9.0),
        ),
        borderSide: BorderSide.none,
      ),
      hintStyle: AppTextStyle.medium(
        color: Colors.white.withOpacity(.4),
        fontSize: 13,
      ),
      suffixIcon: suffixIcon,
      prefixIcon: preffixIcon,
      errorText: errorText,
    ),
    onChanged: onChanged,
  );
}
