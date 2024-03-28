import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/utils/toast_utils.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/input_form.dart';
import 'package:socon/views/screens/myStore/product_register_toast.dart';



class ProductRegister extends StatefulWidget {
  final int storeId;

  ProductRegister({super.key, required this.storeId});

  @override
  State<ProductRegister> createState() => _ProductRegisterState();
}

class _ProductRegisterState extends State<ProductRegister> {
  var userImage;
  String menuName = '';
  String introLine = '';
  String productPrice = '';

  bool isInputValid() {
    return menuName.isNotEmpty && userImage != null && introLine.isNotEmpty && productPrice.isNotEmpty;
  }

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
                        onChanged: (value) => {
                          setState(() {
                             menuName = value;
                             // viewModel에 업데이트
                          })
                        },
                      ),

                      Text('상품 사진을 추가해 주세요',
                        style: TextStyle(fontSize: FontSizes.SMALL, fontWeight: FontWeight.bold),),
                      Row(
                        children: [
                          // 이미지를 보여줄 box
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            width: 80, // 이미지 박스의 너비 설정
                            height: 80, // 이미지 박스의 높이 설정
                            decoration: BoxDecoration(
                              color: AppColors.GRAY200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: userImage != null
                                ? Stack(
                              // alignment: Alignment.topRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    userImage,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: -10,
                                  right: -10,
                                  child:
                                    IconButton(
                                      icon: Icon(Icons.close, color: Colors.white, size: 15,),
                                      onPressed: () {
                                        setState(() {
                                          userImage = null;
                                        });
                                      },
                                    ),
                                ),
                              ],
                            )
                                : IconButton(
                              onPressed: () async {
                                var picker = ImagePicker();
                                var image = await picker.pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  setState(() {
                                    userImage = File(image.path); // 이미지 선택
                                  });
                                }
                              },
                              icon: Icon(Icons.add),
                              color: Colors.black,
                            ),
                          ),


                        ],
                      ),
                      SizedBox(height: 10,),

                      CustomInputField(
                        labelText: '한줄 소개',
                        onChanged: (value) => {
                          setState(() {
                            introLine = value;
                            // viewModel에 업데이트
                          })
                        },
                      ),

                      CustomInputField(
                        labelText: '상품 가격',
                        onChanged: (value) => {
                          setState(() {
                            productPrice = value;
                            // viewModel에 업데이트
                          })
                        },
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
                if(isInputValid()){
                  Navigator.push( context,
                    MaterialPageRoute(builder: (context) => RegisterToastMsg(storeId: widget.storeId)),
                  ),
                } else {
                  ToastUtil.showCustomToast(context, 'filedAlert')
                },
              }
            ),
          ],
        ),
      ),
    );
  }
}
