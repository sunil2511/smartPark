import 'package:flutter/material.dart';

class ImageAssetsWidget extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ImageAssetsWidget({
    super.key,
    this.url = "",
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      url,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
