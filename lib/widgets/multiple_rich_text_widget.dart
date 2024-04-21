import 'package:flutter/material.dart';


class MultipleRichTextWidget extends StatelessWidget {
  final String title;
  final String title2;
  final String title3;
  final String title4;
  final Color titleColor;
  final FontWeight titleFontWeight;
  final double titleFontSize;
  final Function()? onTap;

  const MultipleRichTextWidget({
    super.key,
    this.title = "",
    this.title2 = "",
    this.title3 = "",
    this.title4 = "",
    this.titleColor = Colors.white,
    this.titleFontWeight = FontWeight.w600,
    this.titleFontSize = 16,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
               style: TextStyle(
                color: Colors.black,
              ),
            ),
            const WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 3.0,
                ),
              ),
            ),
            TextSpan(
              text: title2,
               style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: title3,
               style: TextStyle(
                color: Colors.black,
              ),
            ),
            const WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 3.0,
                ),
              ),
            ),
            TextSpan(
              text: title4,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
