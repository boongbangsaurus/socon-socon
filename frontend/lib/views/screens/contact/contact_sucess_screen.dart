import "package:flutter/material.dart";
import "package:socon/views/modules/app_bar.dart";
import "package:socon/views/modules/success_card.dart";

class ContactSuccessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: "문의하기"),
      body: SuccessCard(type : "contact"),
    );
  }

}