import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import '../atoms/image_card.dart';

class MySocon extends StatelessWidget {
  final String soconName;
  final String storeName;
  final String dueDate;
  final String imageUrl;

  const MySocon({
    super.key,
    required this.soconName,
    required this.storeName,
    required this.dueDate,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width / 2;

    return Container(
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
              offset: Offset(0, 5), // changes position of shadow
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            soconName,
            style: TextStyle(
                fontSize: FontSizes.LARGE,
                fontWeight: FontWeight.bold,
                color: AppColors.BLACK,
                height: 2.5),
            textAlign: TextAlign.center,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'from. $storeName',
                style: TextStyle(
                  fontSize: FontSizes.XXXSMALL,
                  color: AppColors.BLACK,
                ),
                textAlign: TextAlign.right,
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              '$dueDate 까지',
              style: TextStyle(
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
    );
  }
}
