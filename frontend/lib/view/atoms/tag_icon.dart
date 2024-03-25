import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';


// 지정값 : 세로 크기, 텍스트 크기, 텍스트 굵기
class TagIcon extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;

  const TagIcon({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
  });


  // 'NEW' 태그 아이콘을 생성하기 위한 팩토리 생성자
  factory TagIcon.NEW() {
    return TagIcon(
      buttonText: 'NEW',
      buttonColor: AppColors.WARNING25,
      buttonTextColor: AppColors.WHITE,
    );
  }

  // 'SALE' 태그 아이콘을 생성하기 위한 팩토리 생성자
  factory TagIcon.SALE() {
    return TagIcon(
      buttonText: 'SALE',
      buttonColor: Color(0xffFEF4444),
      buttonTextColor: AppColors.WHITE,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: buttonTextColor,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





// 지정값 : 체크여부, 버튼 죄소 가로/세로 크기, 텍스트 크기, 텍스트 굵기
class TagButton extends StatefulWidget {
  final bool isSelected;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onPressed;
  final Function(bool) onSelected;

  final double minWidth;
  final double minHeight;


  const TagButton({
    super.key,
    this.isSelected = false,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onPressed,
    required this.onSelected,

    this.minWidth = 10.0, // 최소 가로 크기
    this.minHeight = 30.0, // 최소 세로 크기
  });

  @override
  State<TagButton> createState() => _TagButtonState();
}

class _TagButtonState extends State<TagButton> {
  late bool _isSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _isSelected
        ? ElevatedButton.styleFrom(
      backgroundColor: widget.buttonColor,
      minimumSize: Size(widget.minWidth, widget.minHeight),
    )
        : ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey,
      side: BorderSide(color: Colors.grey),
      minimumSize: Size(widget.minWidth, widget.minHeight),
    );

    return TextButton(
      onPressed: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onPressed();
        });
        widget.onSelected(_isSelected);
      },
      style: buttonStyle,
      child: Text(
          widget.buttonText,
          style: TextStyle( color: _isSelected ? widget.buttonTextColor : AppColors.GRAY, fontSize: FontSizes.XXXSMALL, fontWeight: FontWeight.bold)),
    );
  }
}

