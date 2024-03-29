import 'package:flutter/material.dart';
import 'package:socon/utils/responsive_utils.dart';
import '../../utils/colors.dart';
import '../../utils/fontSizes.dart';

class TextAreaWidget extends StatefulWidget {
  final TextEditingController titleController;

  const TextAreaWidget(this.titleController, {super.key});

  @override
  _TextAreaWidgetState createState() => _TextAreaWidgetState();
}

class _TextAreaWidgetState extends State<TextAreaWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.titleController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 25,
      style: TextStyle(
          color: AppColors.GRAY500,
          fontWeight: FontWeight.w400,
          fontSize: ResponsiveUtils.calculateResponsiveFontSize(
              context, FontSizes.XXSMALL)),
      decoration: const InputDecoration(
        hintText: "어떤 도움이 필요하신가요?\n저희에게 문의해 주시면 최대한 빠르고 \n정확한 답변을 드리겠습니다.",
        hintStyle: TextStyle(color: AppColors.GRAY400),
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.GRAY400, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.YELLOW, width: 2.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.titleController.dispose();
    super.dispose();
  }
}
