import 'package:flutter/material.dart';


class CheckBoxBtn extends StatefulWidget {
  final String Text;
  final bool isChecked;

  final Function(bool) onCheckedChanged;
  CheckBoxBtn({super.key, required this.Text, required this.isChecked, required this.onCheckedChanged,  });

  @override
  State<CheckBoxBtn> createState() => _CheckBoxBtnState();
}

class _CheckBoxBtnState extends State<CheckBoxBtn> {
  late bool isChecked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChecked = widget.isChecked;
  }
  @override
  Widget build(BuildContext context) {
    return   Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: isChecked,

            // 체크박스 모양 변경
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),

            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.blue; // 선택됐을 때의 내부 바탕색 설정
              }
              return Colors.white; // 기본 내부 바탕색 설정
            }),

            onChanged: (bool? value) {
              // Update Check State
              setState(() {
                isChecked = value ?? false;
              });
              widget.onCheckedChanged(isChecked);
            },
          ),
          // 선택되었을 때 텍스트 선택
          Text(widget.Text),
        ],
      );
  }
}