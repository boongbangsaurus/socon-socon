import 'package:flutter/material.dart';


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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.0,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
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

  final double minWidth;
  final double minHeight;


  const TagButton({
    super.key,
    this.isSelected = false,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onPressed,
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
      },
      style: buttonStyle,
      child: Text(
          widget.buttonText,
          style: TextStyle( color: _isSelected ? widget.buttonTextColor : Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}

