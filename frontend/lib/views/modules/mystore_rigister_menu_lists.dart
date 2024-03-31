import 'package:flutter/material.dart';
import 'package:socon/models/socon_card.dart';
import 'package:socon/views/modules/mystore_menu_card.dart';
import 'package:socon/views/modules/socon_storesocon.dart';


class RegisteredMenu extends StatelessWidget {
  final int storeId;

  const RegisteredMenu({super.key, required this.storeId});

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
            return StoreMenuCard(
              storeId: storeId,
              isOwner: true,
              id: socon.id,
              name: socon.name!,
              is_main: socon.is_main!,
              issued_quantity: socon.issued_quantity!,
              left_quantity: socon.left_quantity!,
              price: socon.price!,
              is_discounted: socon.is_discounted ?? false,
              discounted_price: socon.discounted_price!,
              image: socon.image ?? '',
              createdAt: socon.createdAt ?? DateTime.now(),
            );
          },
        ),
    );
  }
}
