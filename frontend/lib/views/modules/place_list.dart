import 'package:flutter/material.dart';
import 'package:socon/views/modules/place_list_card.dart';
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

// author: 김아현



