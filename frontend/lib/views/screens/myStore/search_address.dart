import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';
import 'package:socon/provider/Boss_provider.dart';

import '../../../viewmodels/store_register_view_model.dart';


class SearchAddress extends StatefulWidget {
  const SearchAddress({Key? key}) : super(key: key);

  @override
  _SearchAddressState createState() => _SearchAddressState();
}

class _SearchAddressState extends State<SearchAddress> {
  String postCode = '';
  String address = '';
  String latitude = '';
  String longitude = '';

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StoreRegisterViewModel>(context);


    return Scaffold(
      body: Consumer<BossProvider>(
        builder: (context, addressProvider, _) {
          return KpostalView(
            useLocalServer: true,
            localPort: 1024,
            // kakaoKey: '{Add your KAKAO DEVELOPERS JS KEY}',
            callback: (Kpostal result) {
              print("선택 $result");

              viewModel.setLatitude(result.latitude.toString() as double);
              viewModel.setLongitude(result.longitude.toString() as double);

              Navigator.of(context).pop();
            },
          );
        },
      ),
    );
  }
}
