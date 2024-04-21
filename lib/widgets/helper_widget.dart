import 'package:flutter/material.dart';

import '../utils/const/color_schema.dart';

//Screen Width
double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//Screen Height
double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

//Profile List DecoratedBox

BoxDecoration profileListDecoratedBox({
  double borderRadius = 0.0,
}) {
  return BoxDecoration(
    color: AppColors.primaryColor,
    borderRadius: BorderRadius.circular(
      borderRadius,
    ),
    boxShadow: const [
      BoxShadow(
        color: Color(
          0xFF2F3036,
        ),
      ),
      BoxShadow(
        color: Color(
          0xFF8F9098,
        ),
      ),
    ],
  );
}

//Products List DecoratedBox

BoxDecoration productListDecoration() {
  return BoxDecoration(
    color: AppColors.primaryColor,
    borderRadius: BorderRadius.circular(
      10,
    ),
    border: Border.all(
      color: const Color(
        0xFFEFEFEF,
      ),
      style: BorderStyle.solid,
      width: 1,
    ),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(
          175,
          175,
          175,
          0.25,
        ),
        blurRadius: 20,
      ),
    ],
  );
}

BoxDecoration cardDecoration() {
  return BoxDecoration(
    color: AppColors.primaryColor2,
    border: Border.all(
      color: AppColors.primaryColor3,
      style: BorderStyle.solid,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(
      16,
    ),
  );
}

BoxDecoration brandCardDecoration() {
  return BoxDecoration(
    color: AppColors.primaryColor3,
    border: Border.all(
      color: Colors.white.withOpacity(0.11999999731779099),
      style: BorderStyle.solid,
      width: 1,
    ),
    boxShadow: const [
      BoxShadow(
        blurRadius: 98,
      ),
    ],
    borderRadius: BorderRadius.circular(
      12,
    ),
  );
}

BoxDecoration primaryColorBorder() {
  return BoxDecoration(
    color: AppColors.primaryColor,
    border: Border.all(
      color: AppColors.primaryColor3,
      style: BorderStyle.solid,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(
      56,
    ),
  );
}

//BottomBar DecortedBox
BoxDecoration bottomBarBoxDecoration() {
  return BoxDecoration(
    color: AppColors.primaryColor2,
    border: Border.all(
      color: AppColors.primaryColor3,
      style: BorderStyle.solid,
      width: 1,
    ),
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(
          206,
          206,
          206,
          0.25,
        ),
        blurRadius: 10,
      ),
    ],
  );
}

inputDecorationSearch() {
  // return const InputDecorationTheme(
  //   fillColor: Colors.red,
  //   focusedErrorBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(width: 0.7, color: AppColors.errorColor)),
  //   focusedBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(width: 0.5, color: AppColors.whiteColor)),
  //   enabledBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(width: 2.0, color: AppColors.whiteColor)),
  //   border: UnderlineInputBorder(
  //       borderSide: BorderSide(width: 2.0, color: AppColors.whiteColor)),
  //   disabledBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(width: 2.0, color: AppColors.whiteColor)),
  // );
}
