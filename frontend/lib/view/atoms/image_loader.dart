import 'package:flutter/material.dart' as image_loader;

class ImageLoader extends image_loader.StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  const ImageLoader({super.key, required this.imageUrl, this.borderRadius = 0});

  @override
  image_loader.Widget build(image_loader.BuildContext context) {
    return image_loader.ClipRRect(
      borderRadius: image_loader.BorderRadius.circular(borderRadius),
      child: image_loader.Image.network(
        imageUrl,
        fit: image_loader.BoxFit.fill,
      ),
    );
  }
}