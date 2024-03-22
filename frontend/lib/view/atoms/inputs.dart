import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';

/// 입력 필드 정의 클래스
/// 1. CustomTextFormField
/// author: 탁하윤
///
/// [CustomTextFormField]
/// @param String [labelText] field name
/// @param FormFieldSetter<String?> [onSaved] Form이 저장될 때 호출되는 콜백 함수
/// @param FormFieldValidator<String?>? [validator] 사용자 입력의 유효성 검사 함수
/// @param bool [obscureText] 민감한 정보를 입력받을 때 내용을 숨길지 여부 결정
/// @param String? [hintText] 작성 내용을 제안
/// @param TextInputType? [keyboardType] 사용할 키보드 타입 지정
class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final FormFieldSetter<String?> onSaved;
  final FormFieldValidator<String?>? validator;
  final bool obscureText;
  final String? hintText;
  final TextInputType? keyboardType;

  CustomTextFormField({
    super.key,
    required this.labelText,
    required this.onSaved,
    this.validator,
    this.obscureText = false,
    this.hintText,
    this.keyboardType,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
            color: AppColors.GRAY300, fontSize: FontSizes.XSMALL),
        errorStyle: const TextStyle(color: AppColors.ERROR400),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.GRAY300),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.YELLOW, width: 2.0),
        ),
        focusColor: AppColors.YELLOW,
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.ERROR400, width: 2.0),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.ERROR400),
        ),
        hoverColor: AppColors.YELLOW,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: widget.onSaved,
      validator: widget.validator,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      cursorColor: AppColors.YELLOW,
      cursorErrorColor: AppColors.WARNING400,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
