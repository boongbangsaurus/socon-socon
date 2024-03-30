import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:socon/views/modules/app_bar.dart";
import "package:socon/views/modules/success_card.dart";

import "../../../utils/result_msg_type.dart";

class ContactSuccessScreen extends StatelessWidget {
  Message contactMessage = ResultMessages.getMessage('contact');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: contactMessage.name),
      body: SuccessCard(resultMsg : contactMessage, onPressed : () =>{
        GoRouter.of(context).go('/info')
      }),
    );
  }

}