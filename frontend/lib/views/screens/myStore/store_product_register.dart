import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/input_form.dart';
import 'package:socon/views/screens/myStore/product_register_toast.dart';


class ProductRegister extends StatelessWidget {
  final int storeId;

  const ProductRegister({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메뉴 등록'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('필수입력',
                        style: TextStyle(fontSize: FontSizes.MEDIUM, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),

                      CustomInputField(
                        labelText: '메뉴 이름',
                        onChanged: (value) => {},
                      ),

                      Text('상품 사진을 추가해 주세요',
                        style: TextStyle(fontSize: FontSizes.SMALL, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),

                      CustomInputField(
                        labelText: '한줄 소개',
                        onChanged: (value) => {},
                      ),

                      CustomInputField(
                        labelText: '상품 가격',
                        onChanged: (value) => {},
                      ),

                      Text('선택입력',
                        style: TextStyle(fontSize: FontSizes.MEDIUM, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),

                      Text('상세 설명',
                        style: TextStyle(fontSize: FontSizes.SMALL, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Container(
                        width: ResponsiveUtils.getWidthPercent(context, 100),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.GRAY300,
                            width: 1.0,
                          ),
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 200,
                          ),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              onChanged: (value) => {},
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: '가게에 대한 상세한 설명을 적어주세요',
                                hintStyle: TextStyle(color: AppColors.GRAY400),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),

                    ],
                  ),
                )
            ),
            SizedBox(height: 10,),
            BasicButton(
              text: '다음',
              color: 'yellow',
              onPressed: () => {
                Navigator.push( context,
                  MaterialPageRoute(builder: (context) => RegisterToastMsg(storeId: storeId)),
                )
              }
            ),
          ],
        ),
      ),
    );
  }
}
