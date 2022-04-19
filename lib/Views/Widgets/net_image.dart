import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetImage extends StatelessWidget {
  const NetImage({Key? key, required this.imagePath, this.boxfit})
      : super(key: key);

  final String imagePath;
  final BoxFit? boxfit;

  @override
  Widget build(BuildContext context) {
   
    return CachedNetworkImage(
      imageUrl: imagePath,
      fit: boxfit ?? BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator.adaptive(
              value: downloadProgress.progress)),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
