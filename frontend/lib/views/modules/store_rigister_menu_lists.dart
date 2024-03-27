import 'package:flutter/material.dart';
import 'package:socon/models/socon_card.dart';
import 'package:socon/views/modules/socon_storesocon.dart';


class RegisteredMenu extends StatelessWidget {
  const RegisteredMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: socons.length,
          padding: EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 1 / 1.2, //item 의 가로 세로의 비율
            mainAxisSpacing: 7, //수평 Padding
            crossAxisSpacing: 7, //수직 Padding
          ),
          itemBuilder: (BuildContext context, index) {
            final socon = socons[index];
            return StoreSoconLists(
              soconName: socon.soconName!,
              isMain: socon.isMain!,
              maxQuantity: socon.maxQuantity!,
              issuedQuantity: socon.issuedQuantity!,
              price: socon.price!,
              isDiscounted: socon.isDiscounted ?? false,
              discountedPrice: socon.discountedPrice!,
              imageUrl: socon.imageUrl ?? '',
              createdAt: socon.createdAt ?? DateTime.now(),
            );
          },
        ),
    );
  }
}
