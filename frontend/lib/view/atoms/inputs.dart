import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';

class Inputs extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  Inputs({
    super.key,
    required this.labelText,
    required this.onSaved,
    this.validator,
    this.errorText,
    this.hintText,
  });

  final String labelText;
  final Function(String?) onSaved;
  final String? Function(String?)? validator;
  final String? errorText;
  final String? hintText;

  @override
  State<Inputs> createState() => _InputsState();
}

class _InputsState extends State<Inputs> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        errorText: widget.errorText,
        errorStyle: TextStyle(color: AppColors.ERROR400),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.GRAY300),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.YELLOW, width: 2.0),
        ),
        focusColor: AppColors.YELLOW,
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.ERROR400),
        ),
        hoverColor: AppColors.YELLOW,
      ),
      onSaved: widget.onSaved,
      validator: widget.validator,
    );
  }
}
