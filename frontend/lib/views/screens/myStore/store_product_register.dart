import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/utils/toast_utils.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/input_form.dart';
import 'package:socon/views/screens/myStore/product_register_toast.dart';
import 'package:socon/viewmodels/store_product_view_model.dart';



class ProductRegister extends StatefulWidget {
  final String? storeId;

  ProductRegister(this.storeId, {super.key});

  @override
  State<ProductRegister> createState() => _ProductRegisterState();
}

class _ProductRegisterState extends State<ProductRegister> {
  // ProductViewModel? productViewModel;
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController priceController = TextEditingController();
  //
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // productViewModel을 초기화합니다.
  //   productViewModel = Provider.of<ProductViewModel>(context, listen: false);
  // }


  String menuName = '';
  var userImage;
  String summary = '';
  int? productPrice;
  String description = '';

  bool isInputValid() {
    return menuName.isNotEmpty && userImage != null && summary.isNotEmpty && productPrice != null;
  }

  // API에서 가져온 데이터를 저장할 리스트
  List<dynamic> _data = [];


  Future<void> fetchData() async {
    try {
      String base64Image1 = "";


      if (null != userImage) {
        //userImage null 이 아니라면
        final bytes = File(userImage!.path).readAsBytesSync(); //image 를 byte로 불러옴
        base64Image1 = base64Encode(bytes); //불러온 byte를 base64 압축하여 base64Image1 변수에 저장 만약 null이였다면 가장 위에 선언된것처럼 공백으로 처리됨
      }

      final response = await http.post(Uri.parse('http://j10c207.p.ssafy.io:8000/api/v1/stores/${widget.storeId}/items'),
          body: json.encode({
            "name" : menuName,
            "image" : base64Image1,
            "price" : productPrice,
            "summary" : summary,
            "description" : description,
          }));
      print('요청데이터: ${response}');
      print('응답 상태 코드: ${response.statusCode}');
      print('응답 본문: ${response.body}');

      // 만약 요청이 성공했다면
      if (response.statusCode == 200) {
        print('요청 성공!');
        // JSON 형식의 응답을 Dart 객체로 변환하여 데이터 리스트에 저장
        setState(() {
          _data = json.decode(response.body);
        });
      }
    } catch(error) {
      print('Failed to load data: ${error}');

    }
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
                            summary = value;
                            // viewModel에 업데이트
                          })
                        },
                      ),

                      CustomInputField(
                        labelText: '상품 가격',
                        onChanged: (value) => {
                          setState(() {
                            productPrice = int.tryParse(value);;
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
                              onChanged: (value) => {
                                setState(() {
                                  description = value;
                                })
                              },
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
              text: '상품 등록',
              color: 'yellow',
              onPressed: () => {
                fetchData(),

                // if(isInputValid()){
                //   fetchData(),
                //   Navigator.push( context,
                //     MaterialPageRoute(builder: (context) => RegisterToastMsg(storeId: widget.storeId)),
                //   ),
                // } else {
                //   ToastUtil.showCustomToast(context, 'filedAlert')
                // },
              }
            ),
          ],
        ),
      ),
    );
  }
}
