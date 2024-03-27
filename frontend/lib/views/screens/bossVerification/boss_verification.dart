import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:socon/utils/responsive_utils.dart";
import "package:socon/views/atoms/inputs.dart";
import "package:socon/views/modules/app_bar.dart";
import "package:socon/views/modules/success_card.dart";

import "../../../utils/colors.dart";
import "../../../utils/result_msg_type.dart";
import "../../atoms/buttons.dart";

class BossVerification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BossVerificationState();
}

class _BossVerificationState extends State<BossVerification> {
  Message contactMessage = ResultMessages.getMessage('contact');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: CustomAppBarWithArrow(title: contactMessage.name),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 50.0),
                width: ResponsiveUtils.getWidthWithPixels(context, 320),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BossInput(
                      labelText: "대표자",
                      hintText: "대표자 성함을 입력해주세요",
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    BossInput(
                      labelText: "사업자 등록 번호",
                      hintText: "사업자 등록 번호를 입력해주세요",
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    BossInput(
                      labelText: "개업일",
                      hintText: "대표자 성함을 입력해주세요",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: BasicButton(
                      text: '완료',
                      color: "yellow",
                      onPressed: () =>
                          {GoRouter.of(context).go("/info/success")}),
                ),
              ),
              SizedBox(height: 25.0),
            ],
          )),
    );
  }
}

class BossInput extends StatelessWidget {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // TextFormField를 사용하기 위한 globalkey
  late bool validationResult; //  (예시) 유효성 통과 여부를 저장할 변수
  final String labelText;
  final String hintText;

  BossInput({required this.labelText, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey, // key 지정
          child: SizedBox(
            // (선택/예시) sizeBox로 textformfield의 너비와 높이를 지정할 수 있다.
            width: ResponsiveUtils.getWidthWithPixels(context, 320),
            child: CustomTextFormField(
              // CustomTextFormField 호출
              labelText: labelText,
              // labelText
              hintText: hintText,
              // 작성 내용 제안
              // keyboardType: TextInputType.emailAddress, // keyboardtype (number, ...)
              // obscureText: true, // 민감한 정보 동그라미 표시
              onSaved: (String? val) {},
              // Form이 저장될 때 호출되는 콜백 함수
              validator: (String? val) {
                if (val!.isEmpty) {
                  debugPrint('val!.isEmpty $val');
                  return "Please enter some text";
                }
                if (!RegExp(r'^.{5,}$').hasMatch(val)) {
                  debugPrint('RegExp $val');
                  return "Minimum of 5 characters Required";
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
