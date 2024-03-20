import 'package:flutter/material.dart';
import 'package:socon/utils/responsive_utils.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;

  // const ImageLoader({super.key, required this.imageUrl, required this.width, required this.height, required this.radius});
  const ImageLoader({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: NetworkImage(imageUrl),
        width: ResponsiveUtils.getWidthWithPixels(context, 77),
        height: ResponsiveUtils.getHeightWithPixels(context, 77),
      )
    );
  }


}