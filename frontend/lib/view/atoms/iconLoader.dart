import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socon/utils/icon_paths.dart';

class IconLoader extends StatelessWidget {
  final String iconName;
  final double width;
  final double height;
  final double padding;
  const IconLoader({super.key, required this.iconName, this.width = 20.0, this.height = 20.0, this.padding = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: SvgPicture.asset(
        // 'assets/icons/filter.svg',
        iconPaths[iconName].toString(),
        width: width,
        height: height,

      ),
    );
  }
}
