import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText; // field title
  final FormFieldSetter<String?> onSaved; // text field 값 저장할 때 실행할 함수
  final FormFieldValidator<String?>? validator; // text field 값 검증할 때 실행할 함수
  final String? errorText; // validator에 맞지 않는 데이터일 떄 보여줄 메세지
  final bool obscureText; // true인 경우 값이 *로 보임
  final String? hintText; // 작성 내용을 제안하는 메세지

  CustomTextFormField({
    super.key,
    required this.labelText,
    required this.onSaved,
    this.validator,
    this.errorText,
    this.obscureText = false,
    this.hintText,
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
        errorText: widget.errorText,
        errorStyle: const TextStyle(color: AppColors.ERROR400),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.GRAY300),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.YELLOW, width: 2.0),
        ),
        focusColor: AppColors.YELLOW,
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.ERROR400),
        ),
        hoverColor: AppColors.YELLOW,
      ),
      onSaved: widget.onSaved,
      validator: widget.validator,
      obscureText: widget.obscureText,
      cursorColor: AppColors.YELLOW,
      cursorErrorColor: AppColors.WARNING400,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
