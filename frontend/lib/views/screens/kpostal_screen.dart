import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';
import 'package:socon/provider/Boss_provider.dart';

import '../../provider/Address.dart';
import '../../utils/colors.dart';
import '../modules/app_bar.dart';

class KpostalScreen extends StatefulWidget {
  const KpostalScreen({Key? key}) : super(key: key);

  @override
  _KpostalScreenState createState() => _KpostalScreenState();
}

class _KpostalScreenState extends State<KpostalScreen> {
  String postCode = '';
  String address = '';
  String latitude = '';
  String longitude = '';

  @override
  Widget build(BuildContext context) {
    final bossProvider = Provider.of<BossProvider>(context);

    print("boss가 가지고 있는 값 ${bossProvider.owner}");

    return Scaffold(
      body: Consumer<BossProvider>(
        builder: (context, addressProvider, _) {
          return KpostalView(
            useLocalServer: true,
            localPort: 1024,
            // kakaoKey: '{Add your KAKAO DEVELOPERS JS KEY}',
            callback: (Kpostal result) {
              print("선택 $result");

              bossProvider.setBoss(
                owner : bossProvider.owner,
                registrationNumber: bossProvider.registrationNumber,
                postCode: result.postCode,
                address: result.address,
                latitude: result.latitude.toString(),
                longitude: result.longitude.toString(),
              );
              GoRouter.of(context).go("/info/verify");
            },
          );
        },
      ),
    );
  }
}
