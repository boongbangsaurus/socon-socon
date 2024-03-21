import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/modules/placeListCard.dart';
import '../../models/store.dart';


class PlaceList extends StatelessWidget {
  final List<Store> stores;
  const PlaceList({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stores.length,
      itemBuilder: (BuildContext context, int index) {
        final storeInfo = stores[index];

        return PlaceListCard(storeInfo : storeInfo);
      },
    );
  }
}


