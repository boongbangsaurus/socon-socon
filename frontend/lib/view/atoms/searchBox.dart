import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/atoms/iconLoader.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveUtils.getWidthWithPixels(context, 340),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: '검색어를 입력하세요',
          prefixIcon: GestureDetector(
            onTap: () {
              print("search Icon Clicked");
            },
            child: FilterIcon(iconName: 'search'),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              print("let's use search filtering!");
            },
            child: FilterIcon(iconName: 'filter'),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.GRAY300,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.GRAY300,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onSubmitted: (value) {
          // 검색어 값이 변경될 때 호출됩니다.
          print('검색어: $value');
        },
        onTap: () {
          if (_textEditingController.text.isNotEmpty) {
            _textEditingController.clear();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
