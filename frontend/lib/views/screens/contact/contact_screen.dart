import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/utils/string_utils.dart';
import 'package:socon/views/atoms/text_area.dart';
import 'package:socon/views/modules/app_bar.dart';
import 'package:socon/views/modules/success_card.dart';
import 'package:socon/views/modules/fail_card.dart';
import '../../atoms/buttons.dart';
import '../../../utils/result_msg_type.dart';

class ContactScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final String writeDate = StringAndDateUtils.getToday();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Message contactMessage = ResultMessages.getMessage('contact');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: CustomAppBarWithArrow(title: contactMessage.name),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 25.0, 0, 15.0),
        alignment: Alignment.topCenter,
        child: Container(
          width: ResponsiveUtils.getWidthWithPixels(context, 320),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _titleController,
                          style: TextStyle(
                            fontSize:
                                ResponsiveUtils.calculateResponsiveFontSize(
                                    context, FontSizes.XSMALL),
                            fontWeight: FontWeight.w400,
                            color: AppColors.GRAY700,
                          ),
                          decoration: const InputDecoration(
                            hintText: "제목을 입력해주세요",
                            hintStyle: TextStyle(color: AppColors.GRAY400),
                            contentPadding: EdgeInsets.zero,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.YELLOW, width: 2.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '제목을 입력해주세요';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "작성일 $writeDate",
                            style: TextStyle(
                                color: AppColors.GRAY500,
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    ResponsiveUtils.calculateResponsiveFontSize(
                                        context, FontSizes.XXSMALL)),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        TextAreaWidget(_contentsController),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                BasicButton(
                  text: "문의하기",
                  btnSize: 'l',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("문의 메세지 전송: ${_titleController.text}, ${_contentsController.text}");
                      context.go("/info/contact/success");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
