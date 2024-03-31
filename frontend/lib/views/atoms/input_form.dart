import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final String? hintText;

  const CustomInputField({
    Key? key,
    required this.labelText,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style:
              TextStyle(fontSize: FontSizes.SMALL, fontWeight: FontWeight.bold),
        ),
        TextField(
          onChanged: onChanged,
          style: TextStyle(
            fontSize: FontSizes.XSMALL,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.GRAY400),
            // labelText: labelText,
            contentPadding: EdgeInsets.zero,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.YELLOW, width: 2.0),
            ),
            // focusColor: AppColors.YELLOW,
            // hoverColor: AppColors.YELLOW,
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
