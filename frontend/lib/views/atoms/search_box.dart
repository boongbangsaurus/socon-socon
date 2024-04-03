import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/icon_loader.dart';

// 검색 상자 위젯 클래스
class SearchBox extends StatefulWidget {
  final Widget filterAppliedWidget;
  final void Function() onEnterPressed;
  const SearchBox({super.key, required this.filterAppliedWidget, required this.onEnterPressed });

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

// 검색 상자 상태 클래스
class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _textEditingController =
      TextEditingController(); // 텍스트 입력 관리 컨트롤러
  bool isFilterApplied = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: ResponsiveUtils.getWidthWithPixels(context, 320),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: '검색어를 입력하세요',
              prefixIcon: GestureDetector(
                // 사용자 동작 감지 위젯
                onTap: () {
                  print("search Icon Clicked");
                },
                child: const IconLoader(iconName: 'search', padding: 10),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isFilterApplied = !isFilterApplied; // 필터 아이콘을 눌렀을 때 필터 토글
                  });
                  print("let's use search filtegit sring!");
                },
                child: const IconLoader(
                  iconName: 'filter',
                  padding: 10,
                ),
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
              print('검색어: $value');
              setState(() {
                if (isFilterApplied) {
                  isFilterApplied = !isFilterApplied; // 필터 토글
                }
                widget.onEnterPressed();
              });
            },
            onTap: () {
              if (_textEditingController.text.isNotEmpty) {
                _textEditingController.clear(); // 텍스트 필드가 비어 있지 않으면 텍스트를 지움
              }
            },
          ),
        ),
        const SizedBox(height: 10),
        if (isFilterApplied) // 필터가 적용되었을 때만 텍스트 표시
          widget.filterAppliedWidget,
      ],
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}

// author: 김아현
