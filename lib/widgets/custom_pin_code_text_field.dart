// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:sunil_s_application1/core/app_export.dart';

// class CustomPinCodeTextField extends StatelessWidget {
//   CustomPinCodeTextField({
//     Key? key,
//     required this.context,
//     required this.onChanged,
//     this.alignment,
//     this.controller,
//     this.textStyle,
//     this.hintStyle,
//     this.validator,
//   }) : super(
//           key: key,
//         );

//   final Alignment? alignment;

//   final BuildContext context;

//   final TextEditingController? controller;

//   final TextStyle? textStyle;

//   final TextStyle? hintStyle;

//   Function(String) onChanged;

//   final FormFieldValidator<String>? validator;

//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//             alignment: alignment ?? Alignment.center,
//             child: pinCodeTextFieldWidget,
//           )
//         : pinCodeTextFieldWidget;
//   }

//   Widget get pinCodeTextFieldWidget => PinCodeTextField(
//         appContext: context,
//         controller: controller,
//         length: 4,
//         keyboardType: TextInputType.number,
//         textStyle: textStyle ?? theme.textTheme.bodyLarge,
//         hintStyle: hintStyle ?? theme.textTheme.bodyLarge,
//         inputFormatters: [
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//         pinTheme: PinTheme(
//           fieldHeight: 48.h,
//           fieldWidth: 48.h,
//           shape: PinCodeFieldShape.box,
//           borderRadius: BorderRadius.circular(8.h),
//           selectedColor: appTheme.blueGray90002,
//           selectedFillColor: appTheme.black900.withOpacity(0.3),
//           inactiveColor: Colors.transparent,
//           activeColor: Colors.transparent,
//         ),
//         onChanged: (value) => onChanged(value),
//         validator: validator,
//       );
// }
