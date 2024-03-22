import 'package:flutter/material.dart';

// 네트워크 상 이미지를 로드하는 위젯
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
