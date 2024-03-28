import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:socon/views/modules/app_bar.dart";
import "package:socon/views/modules/success_card.dart";

import "../../../utils/result_msg_type.dart";

class BossVerificationSuccessScreen extends StatelessWidget {
  Message bossVerificationMessage = ResultMessages.getMessage('bossVerification');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: bossVerificationMessage.name),
      body: SuccessCard(resultMsg : bossVerificationMessage, onPressed : () =>{
        GoRouter.of(context).go('/info')
      }),
    );
  }

}