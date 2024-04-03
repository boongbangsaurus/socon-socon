import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/modules/app_bar.dart';
import 'package:socon/views/modules/success_card.dart';
import '../../../utils/fontSizes.dart';
import '../../../utils/result_msg_type.dart';
import 'package:confetti/confetti.dart';

import '../../atoms/buttons.dart';

class ApprovalScreen extends StatefulWidget {
  final String pathParameter;

  ApprovalScreen(this.pathParameter, {Key? key}) : super(key: key);

  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  late String soconId;

  @override
  void initState() {
    super.initState();
    soconId = widget.pathParameter;
    print("soconId 가져왔니 $soconId");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height:
                    ResponsiveUtils.getHeightWithPixels(context, 200),
                  ),
                  Text(
                    "소콘소콘",
                    style: TextStyle(
                      color: AppColors.YELLOW,
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                        context,
                        FontSizes.LARGE,
                      ),
                      fontFamily: "BagelFatOne",
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "7,800원",
                    style: TextStyle(
                      fontSize:
                      ResponsiveUtils.calculateResponsiveFontSize(
                        context,
                        FontSizes.XXXXLARGE,
                      ),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoRow(context, "상품명", "육개장"),
                      buildInfoRow(context, "구매일", "2024-03-02"),
                      buildInfoRow(context, "유효기간", "2024-03-02"),
                      buildInfoRow(context, "사용처", "국밥집"),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
              SizedBox(
                height:
                ResponsiveUtils.getHeightWithPixels(context, 200),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BasicButton(
                      text: "거절하기",
                      onPressed: () {},
                      color: "gray",
                      btnSize: 's',
                      textColor: "black",
                    ),
                    BasicButton(
                      text: "승인하기",
                      btnSize: 's',
                      onPressed: () {
                        print("승인");
                        GoRouter.of(context)
                            .go("/approval/$soconId/success");
                      },
                      textColor: "white",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(BuildContext context, String label, String value) {
    return Container(
      width: ResponsiveUtils.getWidthWithPixels(context, 320),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                context,
                FontSizes.XXSMALL,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                context,
                FontSizes.XXSMALL,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
