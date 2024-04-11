import "dart:math";

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:socon/utils/colors.dart";
import "package:socon/utils/responsive_utils.dart";
import "package:socon/views/modules/app_bar.dart";
import "package:socon/views/modules/success_card.dart";
import "package:socon/views/screens/my_store_list_screen.dart";
import "../../../utils/result_msg_type.dart";
import 'package:confetti/confetti.dart';

class StoreRegisterSuccessScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StoreRegisterSuccessScreen();
}

class _StoreRegisterSuccessScreen
    extends State<StoreRegisterSuccessScreen> {
  bool isPlaying = false;
  final confettiController = ConfettiController();

  @override
  void initState() {
    confettiController.play();
    super.initState();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  Message bossVerificationMessage =
  ResultMessages.getMessage('storeRegister');

  Widget blaskEffect(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: ResponsiveUtils.getHeightWithPixels(context, 20)),
      child: ConfettiWidget(
        confettiController: confettiController,
        shouldLoop: false,
        blastDirection: -pi / 2,
        blastDirectionality: BlastDirectionality.explosive,
        numberOfParticles: 12,
        emissionFrequency: 0.03,
        gravity: 0.3,
        colors: const [
          AppColors.WARNING200,
          AppColors.SUCCESS200,
          AppColors.ERROR200,
          AppColors.INDIGO200,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          // appBar: CustomAppBarWithArrow(title: bossVerificationMessage.name),
          body: Center(
            child: SuccessCard(
              resultMsg: bossVerificationMessage,
              // 일단은 home으로... -> isOwner 넣기
              onPressed: () => {
                GoRouter.of(context).go('/'),
                // GoRouter.of(context).go('/myStores'),

                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => MyStoreListScreen()),
                // ),
              },
            ),
          ),
        ),
        blaskEffect(context),
      ],
    );
  }
}
