import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AutoSizeTextWidget extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;
  const AutoSizeTextWidget({
    super.key,
    required this.maxLines,
    this.style,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: 
      // GoogleFonts.sofiaSans(
        // textStyle:
         style,
      // ),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      maxLines: maxLines,
    );
  }
}
