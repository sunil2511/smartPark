import 'package:flutter/material.dart';

import '../utils/const/image_path_provider.dart';
import 'image_assets_widget.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const ImageAssetsWidget(
              url: ImagePathProvider.imgNoInternet,
              width: 80,
              height: 80,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "No Internet !",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "No Internet connection was found.Check your connection.",
              style: TextStyle(
                color: Colors.black,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
