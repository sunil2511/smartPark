import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/widgets/progress_indicator_widget.dart';

class CacheNetworkImageWidget extends StatelessWidget {
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;
  final String imageUrl;
  const CacheNetworkImageWidget({
    super.key,
    this.fit = BoxFit.contain,
    this.cacheHeight,
    this.cacheWidth,
    this.imageUrl = "https://cdn.moglix.com/p/SeH7GC63UXx45-xxlarge.jpg",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        memCacheHeight: cacheHeight,
        memCacheWidth: cacheWidth,
        fit: fit,
        imageUrl: imageUrl,
        placeholder: (context, url) => const ProgressIndicatorWidget(),
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
        ),
      ),
    );
  }
}
