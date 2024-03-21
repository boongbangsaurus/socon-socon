import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/atoms/iconLoader.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isFilterApplied = false; // 필터가 적용되었는지 여부를 나타내는 상태 변수

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: ResponsiveUtils.getWidthWithPixels(context, 340),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: '검색어를 입력하세요',
              prefixIcon: GestureDetector(
                onTap: () {
                  print("search Icon Clicked");
                },
<<<<<<< Updated upstream
                child: IconLoader(iconName: 'search'),
=======
                child: const IconLoader(iconName: 'search', padding:10),
>>>>>>> Stashed changes
              ),
              suffixIcon: GestureDetector(
                onTap: () {

                  setState(() {
                    isFilterApplied = !isFilterApplied;
                  });
                  print("let's use search filtegit sring!");
                },
<<<<<<< Updated upstream
                child: IconLoader(iconName: 'filter'),
=======
                child: const IconLoader(iconName: 'filter', padding: 10,),
>>>>>>> Stashed changes
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
              setState(() {
                if(isFilterApplied){
                  isFilterApplied = !isFilterApplied;
                }
              });
            },
            onTap: () {
              if (_textEditingController.text.isNotEmpty) {
                _textEditingController.clear();
              }
            },
          ),
        ),
        const SizedBox(height: 10), // 간격 추가
        if (isFilterApplied) // 필터가 적용되었을 때만 텍스트 표시
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '필터가 적용되었습니다!',
              style: TextStyle(
                fontSize: FontSizes.SMALL,
                fontWeight: FontWeight.w900,
                color: AppColors.SUCCESS500,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
