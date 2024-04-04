import "dart:math";

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:socon/utils/colors.dart";
import "package:socon/utils/responsive_utils.dart";
import "package:socon/views/modules/app_bar.dart";
import "package:socon/views/modules/success_card.dart";
import "../../../utils/result_msg_type.dart";
import 'package:confetti/confetti.dart';

class ApprovalSuccessScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ApprovalSuccessScreen();
}

class _ApprovalSuccessScreen
    extends State<ApprovalSuccessScreen> {
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
  ResultMessages.getMessage('approval');

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
          appBar: CustomAppBarWithArrow(title: bossVerificationMessage.name),
          body: Center(
            child: SuccessCard(
              resultMsg: bossVerificationMessage,
              onPressed: () => GoRouter.of(context).go('/'),
            ),
          ),
        ),
        blaskEffect(context),
      ],
    );
  }
}
