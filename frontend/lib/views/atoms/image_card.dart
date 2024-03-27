import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;
  final double borderRadius;

  const ImageCard({
    super.key,
    required this.imgUrl,
    this.width = 100,
    this.height = 100,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          imgUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
