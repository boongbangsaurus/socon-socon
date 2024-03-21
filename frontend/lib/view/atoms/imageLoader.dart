import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  const ImageLoader({super.key, required this.imageUrl, this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageUrl,
        fit: BoxFit.fill,
      ),
    );
  }
}