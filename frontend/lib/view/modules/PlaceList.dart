import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/modules/placeListCard.dart';

class PlaceList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PlaceListCard(),
        PlaceListCard(),
        PlaceListCard(),
      ],
    );
  }
}