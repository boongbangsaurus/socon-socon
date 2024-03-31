import 'package:flutter/material.dart';
import 'package:socon/models/menu.dart';

import '../../../utils/colors.dart';
import '../../../utils/fontSizes.dart';
import '../../../utils/responsive_utils.dart';
import '../../atoms/dropdown.dart';
import '../../atoms/image_loader.dart';

// 소콘 발행 카드
class PublishSoconCard extends StatefulWidget {
  final Menu menu;

  const PublishSoconCard({super.key, required this.menu});


  @override
  State<StatefulWidget> createState() => _PublishSoconCardState();
}

class _PublishSoconCardState extends State<PublishSoconCard> {
  @override
  Widget build(BuildContext context) {
    final List<String> dropdownItems = ['5', '10', '15', '20'];
    var selectedItem = ''; // 선택된 항목

    return // 매장 정보 카드
        Container(
      width: ResponsiveUtils.getWidthWithPixels(context, 320),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 10),
      // 상단 바와의 간격 추가
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${widget.menu.name}",
            style: TextStyle(
              fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                  context, FontSizes.XLARGE),
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "${widget.menu.summary}",
            style: TextStyle(
              fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                  context, FontSizes.XXSMALL),
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: ResponsiveUtils.getWidthWithPixels(context, 250),
            height: ResponsiveUtils.getHeightWithPixels(context, 180),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.GRAY300,
                  width: 1.0,
                )),
            child: ImageLoader(
              imageUrl: "${widget.menu.itemUrl}",
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              SizedBox(
                width: ResponsiveUtils.getWidthWithPixels(context, 220),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "가격",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context, FontSizes.XXSMALL),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${widget.menu.price}원",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context, FontSizes.XXSMALL),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: ResponsiveUtils.getWidthWithPixels(context, 220),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "할인 가격",
                      style: TextStyle(
                        color: AppColors.ERROR500,
                        fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context, FontSizes.XXSMALL),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${widget.menu.price}원 (00% 할인)",
                      style: TextStyle(
                        color: AppColors.ERROR500,
                        fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context, FontSizes.XXSMALL),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: ResponsiveUtils.getWidthWithPixels(context, 220),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "사용 기한",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context, FontSizes.XXSMALL),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "발행일로부터",
                          style: TextStyle(
                            fontSize:
                                ResponsiveUtils.calculateResponsiveFontSize(
                                    context, FontSizes.XXSMALL),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Dropdown(
                          title: '', // 드롭다운 초기 메시지
                          dropdownItems: dropdownItems,
                          onItemSelected: (item) {
                            setState(() {
                              selectedItem = item ?? '';
                            });
                          },
                        ),
                        Text(
                          "일",
                          style: TextStyle(
                            fontSize:
                                ResponsiveUtils.calculateResponsiveFontSize(
                                    context, FontSizes.XXSMALL),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
