import "dart:math";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:socon/views/modules/app_bar.dart";
import "../../../utils/result_msg_type.dart";
import "../../modules/fail_card.dart";

class BossVerificationFailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BossVerificationFailScreen();
}

class _BossVerificationFailScreen
    extends State<BossVerificationFailScreen> {
  Message bossVerificationMessage =
      ResultMessages.getMessage('bossVerification');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: bossVerificationMessage.name),
      body: FailCard(
          resultMsg: bossVerificationMessage,
          onPressed: () => {GoRouter.of(context).go('/info')}),
    );
  }
}
