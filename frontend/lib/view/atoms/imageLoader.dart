import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final double borderRadius;
  // const ImageLoader({super.key, required this.imageUrl, required this.width, required this.height, required this.radius});
  const ImageLoader({super.key, required this.imageUrl, this.borderRadius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius), // 이미지 테두리와 일치시키기 위해 추가
      child: Image.network(
        imageUrl,
        fit: BoxFit.fill,
      ),
    );
  }
}