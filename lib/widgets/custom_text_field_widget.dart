import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/const/color_schema.dart';

class CustomTextFieldWidget extends StatelessWidget {
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
  final FocusNode? focusNode;
  final Function(String?)? onSubmitComplete;
  final int? maxLength;
  final int? fieldCharacterLength;

  const CustomTextFieldWidget({
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
    this.focusNode,
    this.onSubmitComplete,
    this.maxLength,
    this.fieldCharacterLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textFieldTitle,
            style: TextStyle(
              color: Color(0xFFABB4BA),
              fontSize: 12,
              fontFamily: 'Graphik',
              fontWeight: FontWeight.w400,
            ),
          ),
          TextField(
            maxLength: maxLength,
            inputFormatters: [
              LengthLimitingTextInputFormatter(fieldCharacterLength),
            ],
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Graphik',
              fontWeight: FontWeight.w500,
              height: 0.10,
            ),
            onSubmitted: onSubmitComplete,
            focusNode: focusNode,
            autofillHints: autoFillHints,
            controller: controller,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            cursorColor: AppColors.primaryColor,
            obscureText: obsecureText,
            decoration: InputDecoration(
              fillColor: Colors.black,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 13.5,
                horizontal: 13.5,
              ),
              suffixIcon: isSuffixIconAvilable != false
                  ? suffixIcon
                  : const SizedBox.shrink(),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black),
              errorText: errorText,
              errorMaxLines: 4,
              errorStyle:
                 TextStyle(color: Colors.black,),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
