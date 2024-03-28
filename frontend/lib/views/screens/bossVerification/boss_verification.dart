import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";
import "package:socon/models/business_owner.dart";
import "package:socon/utils/fontSizes.dart";
import "package:socon/utils/responsive_utils.dart";
import "package:socon/utils/string_utils.dart";
import "package:socon/viewmodels/boss_verification_view_model.dart";
import "package:socon/views/atoms/inputs.dart";
import "package:socon/views/modules/app_bar.dart";
import "package:socon/views/modules/success_card.dart";

import "../../../utils/colors.dart";
import "../../../utils/result_msg_type.dart";
import "../../atoms/buttons.dart";
import "../../atoms/icon_loader.dart";

class BossVerification extends StatefulWidget {
  const BossVerification({super.key});

  @override
  State<StatefulWidget> createState() => _BossVerificationState();
}

class _BossVerificationState extends State<BossVerification> {
  // final BossVerificationViewModel _bossVerificationViewModel = BossVerificationViewModel();
  late String formattedValue;
  final _formKey = GlobalKey<FormState>();
  final businessOwner = BusinessOwner(
    owner: '',
    registrationNumberId: '',
    registrationNumber: '',
    registrationAddress: '',
    startDate: '',
  );

  @override
  Widget build(BuildContext context) {
    final bossVerificationMessage =
        ResultMessages.getMessage('bossVerification');

    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: CustomAppBarWithArrow(title: bossVerificationMessage.name),
      body: Container(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0,
                      ResponsiveUtils.getHeightWithPixels(context, 40), 0, 0),
                  alignment: Alignment.topCenter,
                  child: Form(
                    key: _formKey,
                    child: Container(
                      width: ResponsiveUtils.getWidthWithPixels(context, 320),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BossInput(
                            type: "owner",
                            labelText: "대표자",
                            helperText: "외국인 사업자의 경우에는 영문명을 입력해주세요.",
                            emptyText: "대표자 성함을 입력해주세요.",
                            onSaved: (val) => businessOwner.owner = val ?? '',
                          ),
                          const SizedBox(height: 15),
                          BossInput(
                              type: "registrationNumber",
                              labelText: "사업자 등록 번호",
                              helperText: "123-45-6789 형태로 사업자 등록 번호를 입력해주세요.",
                              emptyText: "사업자 등록 번호를 입력해주세요.",
                              onSaved: (val) => {
                                    formattedValue =
                                        StringUtils.extractWithoutHyphen(val.toString()),
                                    print("보정 처리한 사업자 등록번호 $formattedValue"),
                                    businessOwner.registrationNumber =
                                        "1208765763",
                                  }),
                          const SizedBox(height: 15),
                          BossInput(
                            type: "startDate",
                            labelText: "개업일",
                            helperText: "달력 아이콘을 선택하여 사업자 등록증에 표기된 개업일을 입력해주세요",
                            emptyText: "개업일을 입력해주세요.",
                            showIcon: true,
                            onSaved: (val) =>
                                businessOwner.startDate = val ?? '',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BasicButton(
              text: "인증하기",
              btnSize: 'l',
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState!.save();
                  debugPrint("사업자 등록 정보 입력: ${businessOwner.toJson()}");

                  var _bossVerificationViewModel =
                      Provider.of<BossVerificationViewModel>(context,
                          listen: false);
                  await _bossVerificationViewModel
                      .verifyBoss(businessOwner.registrationNumber);

                  if (_bossVerificationViewModel.isVerified) {
                    GoRouter.of(context).go("/info/verify/success");
                  } else {
                    GoRouter.of(context).go("/info/verify/fail");
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BossInput extends StatelessWidget {
  late bool validationResult; //  (예시) 유효성 통과 여부를 저장할 변수
  final String type;
  final String labelText;
  final String helperText;
  final String emptyText;
  final bool showIcon;
  final Function(String?) onSaved;

  BossInput({
    super.key,
    required this.type,
    required this.labelText,
    required this.helperText,
    required this.emptyText,
    this.showIcon = false,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveUtils.getWidthWithPixels(context, 320),
      margin: const EdgeInsets.only(bottom: 30, top: 10),
      child: CustomTextFormField.setCustomTextFormField(
          labelText: labelText,
          helperText: helperText,
          textFormField: TextFormField(
            decoration: CustomTextFormField.getDecoration(
                suffixs: showIcon
                    ? IconLoader(
                        iconName: 'calendar',
                        width: ResponsiveUtils.getWidthWithPixels(context, 20),
                        height:
                            ResponsiveUtils.getHeightWithPixels(context, 25),
                        onPressed: () {
                          print("달력 보여줘");
                        })
                    : null),
            style: TextStyle(
                fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                    context, FontSizes.XXSMALL)),
            cursorColor: CustomTextFormField.getCursorColor(),
            cursorErrorColor: CustomTextFormField.getCursorErrorColor(),
            onTapOutside: CustomTextFormField.onTapOutsideHandler,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // 실시간 검사
            keyboardType: TextInputType.name,
            onSaved: onSaved,
            validator: (String? val) {
              if (val == null || val.isEmpty) {
                return emptyText;
              }
              return null;
            },
          )),
    );
  }
}
