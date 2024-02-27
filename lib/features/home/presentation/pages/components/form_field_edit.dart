import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youapp_test/core/core.dart';

TextFormField formFieldEdit({
  TextEditingController? controller,
  TextInputType? inputType,
  IconButton? suffixIcon,
  IconButton? preffixIcon,
  bool? obscure,
  String? hintText,
  EdgeInsetsGeometry? contentPadding,
  List<TextInputFormatter>? inputFormatter,
  void Function(String)? onChanged,
  void Function()? onTap,
  String? errorText,
  String? Function(String?)? validator,
  bool? readOnly,
}) {
  return TextFormField(
    controller: controller,
    textAlign: TextAlign.end,
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
      fillColor: HexColor('#D9D9D9').withOpacity(.06),
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(9.0),
        ),
        borderSide: BorderSide(
          color: AppColors().hWhite.withOpacity(.22),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(9.0),
        ),
        borderSide: BorderSide(
          color: AppColors().hWhite.withOpacity(.22),
          width: 1,
        ),
      ),
      hintStyle: AppTextStyle.medium(
        color: Colors.white.withOpacity(.4),
        fontSize: 13,
      ),
      suffixIcon: suffixIcon,
      prefixIcon: preffixIcon,
      errorText: errorText,
    ),
    readOnly: readOnly ?? false,
    onChanged: onChanged,
    onTap: onTap,
  );
}
