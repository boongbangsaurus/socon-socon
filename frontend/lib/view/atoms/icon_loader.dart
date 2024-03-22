import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/icon_paths.dart';

// local에 있는 svg 아이콘을 로드하는 위젯
class IconLoader extends StatelessWidget {
  final String iconName;
  final double width;
  final double height;
  final double padding;
  final VoidCallback? onPressed;

  const IconLoader({
    super.key,
    required this.iconName,
    this.width = 20.0,
    this.height = 20.0,
    this.padding = 0,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(padding),
        child: SvgPicture.asset(
          iconPaths[iconName].toString(),
          width: width,
          height: height,
        ),

      ),
    );
  }
}

// author: 김아현
