import 'package:flutter/material.dart';
import 'package:flutter_crud/widgets/auto_size_text.dart';
import 'package:flutter_crud/widgets/helper_widget.dart';

import '../utils/const/color_schema.dart';

class CustomAppButton extends StatelessWidget {
  final Color buttonColor;
  final String title;
  final TextStyle? textStyle;
  final Function()? onTap;
  const CustomAppButton({
    super.key,
    this.buttonColor = AppColors.primaryColor3,
    this.title = "",
    this.textStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: screenWidth(context),
        height: screenHeight(context) * 0.06,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(
              20,
            )),
        child: AutoSizeTextWidget(
          maxLines: 1,
          text: title,
          style: textStyle,
        ),
      ),
    );
  }
}
