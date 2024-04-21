import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/const/color_schema.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final String textFieldTitle;
  final bool obsecureText;
  final Widget? suffixIcon;
  final bool isSuffixIconAvilable;
  final String errorText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Iterable<String>? autoFillHints;

  const SearchTextField({
    super.key,
    this.hintText = "",
    this.textFieldTitle = "",
    this.obsecureText = false,
    this.suffixIcon,
    this.isSuffixIconAvilable = false,
    this.errorText = "",
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.onChanged,
    this.autoFillHints,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: FocusNode(),
      autofillHints: autoFillHints,
      controller: controller,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      cursorColor: AppColors.primaryColor,
      obscureText: obsecureText,
      decoration:
       InputDecoration(
        fillColor: Colors.red,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 15.0,
        ),
        suffixIcon: isSuffixIconAvilable != false
            ? suffixIcon
            : const SizedBox.shrink(),
        hintText: hintText,
        hintStyle: GoogleFonts.outfit(
          textStyle:const TextStyle(color: Colors.black)),
        errorText: errorText,
        errorStyle: GoogleFonts.outfit(
          textStyle:const TextStyle(color: Colors.black),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              4.0,
            ),
          ),
          borderSide: BorderSide(width: 1.0, color: Colors.red),
        ),
        // focusedBorder:
            
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(width: 3, color: Colors.greenAccent),
        // ),
        // errorBorder: context.theme.inputDecorationTheme.errorBorder,
        // focusedErrorBorder:
        //     context.theme.inputDecorationTheme.focusedErrorBorder,
      // ),
    ),);
  }
}
