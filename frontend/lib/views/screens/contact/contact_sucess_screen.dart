import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:socon/views/modules/app_bar.dart";
import "package:socon/views/modules/success_card.dart";
import "../../../utils/result_msg_type.dart";
import "dart:math";
import "package:socon/utils/colors.dart";
import "package:socon/utils/responsive_utils.dart";
import 'package:confetti/confetti.dart';

class ContactSuccessScreen extends StatefulWidget {
  const ContactSuccessScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ContactSuccessScreenState();
}

class _ContactSuccessScreenState extends State<ContactSuccessScreen> {
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

  Message contactMessage = ResultMessages.getMessage('contact');

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
          appBar: CustomAppBarWithArrow(title: contactMessage.name),
          body: Center(
            child: SuccessCard(
              resultMsg: contactMessage,
              onPressed: () => GoRouter.of(context).go('/info'),
            ),
          ),
        ),
        blaskEffect(context),
      ],
    );
  }
}
