import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/icon_loader.dart';
import '../../utils/string_utils.dart';
import '../atoms/image_card.dart';

class MySocon extends StatelessWidget {
  final String soconName;
  final String storeName;
  final String dueDate;
  final String imageUrl;
  final bool available;
  final VoidCallback onPressed;
  const MySocon({
    super.key,
    required this.soconName,
    required this.storeName,
    required this.dueDate,
    required this.imageUrl,
    this.available = true,
    this.onPressed = _defaultOnPressed,
  });


  static void _defaultOnPressed() {
    print("mySocon입니다.");
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = ResponsiveUtils.getWidthPercent(context, 50);

    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            width: screenWidth,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    spreadRadius: 0,
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  soconName,
                  style: const TextStyle(
                      fontSize: FontSizes.LARGE,
                      fontWeight: FontWeight.bold,
                      color: AppColors.BLACK,
                      height: 2.5),
                  textAlign: TextAlign.center,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'from. $storeName',
                      style: const TextStyle(
                        fontSize: FontSizes.XXXSMALL,
                        color: AppColors.BLACK,
                      ),
                      textAlign: TextAlign.right,
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${ StringAndDateUtils.formatDateTime(dueDate)} 까지',
                    style: const TextStyle(
                      fontSize: FontSizes.XXXSMALL,
                      fontWeight: FontWeight.bold,
                      color: AppColors.BLACK,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  child: ImageCard(
                    imgUrl: imageUrl,
                  ),
                ),
              ],
            ),
          ),
          if (!available) ...[
            Opacity(
              opacity: 0.3,
              child: Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: AppColors.GRAY300,
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            Positioned(
              top: 20,
              right: 15,
              child: ImageCard(
                imgUrl:
                "https://firebasestorage.googleapis.com/v0/b/socon-socon.appspot.com/o/images%2Fused.png?alt=media&token=7537d248-2d8a-48b7-af37-931616ab4e82",
                height: ResponsiveUtils.getHeightWithPixels(context, 55),
                width: ResponsiveUtils.getWidthWithPixels(context, 55),
              ),
            )
          ]
        ],
      ),
    );
  }
}
