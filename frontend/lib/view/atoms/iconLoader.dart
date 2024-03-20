import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socon/utils/icon_paths.dart';

class FilterIcon extends StatelessWidget {
  final String iconName;

  const FilterIcon({required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SvgPicture.asset(
        // 'assets/icons/filter.svg',
        iconPaths[iconName].toString(),
        height: 20,
        width: 20,
      ),
    );
  }
}
