import 'package:flutter/material.dart';
import 'package:socon/widgets/image_card.dart';

class MySocon extends StatelessWidget {
  final String soconName;
  final String storeName;
  final String dueDate;

  const MySocon({
    super.key,
    required this.soconName,
    required this.storeName,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width / 2;

    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: screenWidth,
      margin: EdgeInsets.all(5),
      // color: Colors.green,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            soconName,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 3),
            textAlign: TextAlign.center,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'from. $storeName',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                textAlign: TextAlign.right,
              )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '$dueDate 까지',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.right,
            ),
          ),
          ImageCard(
            imgUrl:
                'https://cdn.pixabay.com/photo/2017/12/10/13/37/christmas-3009949_1280.jpg',
          ),
        ],
      ),
    );
  }
}
