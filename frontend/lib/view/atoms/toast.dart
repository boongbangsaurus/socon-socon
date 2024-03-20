import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';

class CustomToast extends StatelessWidget {
  final String type;

  const CustomToast({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveUtils.getWidthPercent(context, 70),
      height: ResponsiveUtils.getHeightWithPixels(context, 40),
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: AppColors.ToastGray,
      ),
      child: Center(
        child: Text("$type", style: TextStyle(color: AppColors.WHITE)),
      ),
    );
  }
}
