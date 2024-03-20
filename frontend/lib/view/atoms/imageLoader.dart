import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String ImageUrl;
  final double width;
  final double height;
  final double radius;
  const ImageLoader({super.key, required this.ImageUrl, required this.width, required this.height, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Image(
        image: NetworkImage(ImageUrl),
        width: width,
        height: height,
      )
    );
  }


}