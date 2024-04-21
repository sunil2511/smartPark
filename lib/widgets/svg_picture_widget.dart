import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgPictureWidget extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  const SvgPictureWidget({
    super.key,
    this.url = "",
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      url,
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }
}
