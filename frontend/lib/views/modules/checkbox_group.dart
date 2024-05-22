import 'package:flutter/material.dart';
import '../atoms/checkbox.dart';

class CheckBoxGroup extends StatefulWidget {
  const CheckBoxGroup({super.key});

  @override
  _CheckBoxGroupState createState() => _CheckBoxGroupState();
}

class _CheckBoxGroupState extends State<CheckBoxGroup> {
  int? selectedCheckboxIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return CheckBoxBtn(
          Text: '선택지 ${index + 1}',
          isChecked: selectedCheckboxIndex == index,
          onCheckedChanged: (isChecked) {
            setState(() {
              if (isChecked) {
                selectedCheckboxIndex = index;
              } else {
                selectedCheckboxIndex = null;
              }
            });
          },
          gapX: -5.0,
        );
      }),
    );
  }
}
