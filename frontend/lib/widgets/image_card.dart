import 'package:flutter/material.dart';


class ImageCard extends StatelessWidget {
  final double width;
  final double height;
  final String imgUrl;


  const ImageCard({super.key, required this.imgUrl, this.width = 100, this.height = 100,});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          imgUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}