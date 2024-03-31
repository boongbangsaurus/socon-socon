import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/checkbox.dart';
import 'package:socon/views/atoms/dropdown.dart';
import 'package:socon/views/atoms/input_form.dart';
import 'package:socon/views/atoms/tag_icon.dart';
import 'package:provider/provider.dart';
import 'package:socon/viewmodels/store_register_view_model.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  void _onBackPressed() {
    if (_currentPageIndex == 0) {
      Navigator.pop(context);
    } else {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoreRegisterViewModel>(
      create: (context) => StoreRegisterViewModel(),
      child: Scaffold(
        appBar: _currentPageIndex != 4
            ? AppBar(
                title: Text(
                  '점포 등록(${_currentPageIndex + 1}/4)',
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _onBackPressed,
                ),
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<StoreRegisterViewModel>(
            builder: (context, viewModel, child) {
              return Scaffold(
                body: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPageIndex = page;
                    });
                  },
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Step1(pageController: _pageController),
                    Step2(pageController: _pageController),
                    Step3(pageController: _pageController),
                    SummaryPage(pageController: _pageController),
                    RegisterComplete(pageController: _pageController),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Step1 extends StatelessWidget {
  final PageController pageController;

  Step1({required this.pageController});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StoreRegisterViewModel>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '대표자',
                      style: TextStyle(fontSize: FontSizes.SMALL, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('김싸피',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 40),

                    CustomInputField(
                      labelText: '사업자 등록 번호',
                      onChanged: (value) => viewModel.setRegistrationNumber(value),
                    ),

                    CustomInputField(
                      labelText: '사업자 주소',
                      onChanged: (value) => viewModel.setAddress(value),
                    ),

                    Text(
                      '점포 등록 유의사항',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('점포 폐업신고는 폐업일 최소 7일 이전에 신고해 주세요'),

                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            BasicButton(
              text: '다음',
              color: 'yellow',
              onPressed: () => pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
            ),
          ],
        )
      ),
    );
  }
}





class Step2 extends StatefulWidget {
  final PageController pageController;

  Step2({required this.pageController});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  var userImage;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StoreRegisterViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputField(
              labelText: '상호명을 입력해주세요',
              onChanged: (value) => viewModel.setName(value),
            ),

            CustomInputField(
              labelText: '전화번호를 입력해 주세요',
              onChanged: (value) => viewModel.setPhoneNumber(value),
            ),


            Text(
              '업종을 선택해 주세요',
              style: TextStyle(fontSize: FontSizes.SMALL, fontWeight: FontWeight.bold),
            ),
            // 업종 연결 state지정필요
            Row(
              children: [
                // viewlist 리팩하기
                TagButton(
                  buttonText: '음식점',
                  buttonColor: AppColors.YELLOW,
                  buttonTextColor: AppColors.BLACK,
                  onPressed: () {},
                  onSelected: (isSelected) => {viewModel.setCategory('음식점')},
                ),
                TagButton(
                  buttonText: '카페',
                  buttonColor: AppColors.YELLOW,
                  buttonTextColor: AppColors.BLACK,
                  onPressed: () {},
                  onSelected: (isSelected) => {viewModel.setCategory('카페')},
                ),
                TagButton(
                  buttonText: '미용',
                  buttonColor: AppColors.YELLOW,
                  buttonTextColor: AppColors.BLACK,
                  onPressed: () {},
                  onSelected: (isSelected) => {viewModel.setCategory('미용')},
                ),
                TagButton(
                  buttonText: '숙박',
                  buttonColor: AppColors.YELLOW,
                  buttonTextColor: AppColors.BLACK,
                  onPressed: () {},
                  onSelected: (isSelected) => {viewModel.setCategory('숙박')},
                ),
                TagButton(
                  buttonText: '스포츠',
                  buttonColor: AppColors.YELLOW,
                  buttonTextColor: AppColors.BLACK,
                  onPressed: () {},
                  onSelected: (isSelected) => {viewModel.setCategory('스포츠')},
                ),
                TagButton(
                  buttonText: '쇼핑',
                  buttonColor: AppColors.YELLOW,
                  buttonTextColor: AppColors.BLACK,
                  onPressed: () {},
                  onSelected: (isSelected) => {viewModel.setCategory('쇼핑')},
                ),
              ],
            ),
            SizedBox(height: 40,),
            CustomInputField(
              labelText: '가게 주소를 입력해 주세요',
              onChanged: (value) => viewModel.setAddress(value),
              hintText: '도로명, 건물명 또는 지번으로 검색'
            ),

            CustomInputField(
              labelText: '가게 소개를 입력해 주세요',
              onChanged: (value) => viewModel.setIntroduction(value),
            ),

            Text('가게 사진을 추가해 주세요',
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


            SizedBox(height: 10),

            BasicButton(
              text: '다음',
              color: 'yellow',
              onPressed: () => widget.pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class Step3 extends StatefulWidget {
  final PageController pageController;

  Step3({required this.pageController});

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  bool isChecked = false;
  Map<String, bool> operationDaysMap = {
    '월': false,
    '화': false,
    '수': false,
    '목': false,
    '금': false,
    '토': false,
    '일': false
  };
  List<String> dropdownItems = ['09:00', '09:30', '10:00', '10:30', '11:00'];
  String selectedStartTime = '';
  String selectedEndTime = '';
  String breaktimeStart = '';
  String breaktimeEnd = '';
  List<Widget> selectedTimesWidgets = [];

  void _addSelectedTimeWidget() {
    operationDaysMap.forEach((day, selected) {
      if (selected) {
        var widget = Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$day: $selectedStartTime ~ $selectedEndTime"),
                  isChecked
                      ? Text("      $breaktimeStart ~ $breaktimeEnd 휴게시간")
                      : Text(''),
                ],
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    operationDaysMap[day] = false; // 선택 해제
                    selectedTimesWidgets.removeWhere((element) =>
                        (element.key as ValueKey<String>).value == day);
                  });
                },
              )
            ],
          ),
          key: ValueKey<String>(day),
        );

        setState(() {
          selectedTimesWidgets.add(widget);
          operationDaysMap[day] = false; // 다시 비활성화
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '운영시간을 등록해주세요',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Wrap(
                          spacing: -2.0,
                          children: operationDaysMap.keys.map((day) {
                            return TagButton(
                              buttonText: day,
                              buttonColor:
                              operationDaysMap[day]! ? Colors.yellow : Colors.grey,
                              buttonTextColor: Colors.white,
                              onSelected: (day) {},
                              onPressed: operationDaysMap[day]!
                                  ? () {}
                                  : () {
                                // 수정된 부분
                                setState(() {
                                  operationDaysMap[day] = true; // 선택된 요일 활성화
                                });
                              },
                            );
                          }).toList(),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('영업시작'),
                                  Dropdown(
                                    title: '시작시간',
                                    dropdownItems: dropdownItems,
                                    onItemSelected: (item) {
                                      setState(() {
                                        selectedStartTime = item ?? '';
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('영업종료'),
                                  Dropdown(
                                    title: '종료시간',
                                    dropdownItems: dropdownItems,
                                    onItemSelected: (item) {
                                      setState(() {
                                        selectedEndTime = item ?? '';
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CheckBoxBtn(
                                Text: '휴게시간',
                                isChecked: isChecked,
                                onCheckedChanged: (bool value) {
                                  setState(() {
                                    isChecked = value;
                                  });
                                }),
                          ],
                        ),
                        isChecked
                            ? Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('시작'),
                                  Dropdown(
                                    title: '시작시간',
                                    dropdownItems: dropdownItems,
                                    onItemSelected: (item) {
                                      setState(() {
                                        breaktimeStart = item ?? '';
                                        viewModel.updateBusinessHour(
                                            item ?? '00:00',
                                            openAt: selectedStartTime);
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('종료'),
                                  Dropdown(
                                    title: '종료시간',
                                    dropdownItems: dropdownItems,
                                    onItemSelected: (item) {
                                      setState(() {
                                        breaktimeEnd = item ?? '';
                                        viewModel.updateBusinessHour(
                                            item ?? '00:00',
                                            openAt: selectedEndTime);
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                            : SizedBox.shrink(),
                        BasicButton(
                            text: '요일추가',
                            color: 'yellow',
                            onPressed: () => {_addSelectedTimeWidget()}),
                        Column(
                          children: selectedTimesWidgets,
                        ),
                        // SizedBox(height: 50),
                      ],
                    ),
                  )
                ),
              BasicButton(
                text: '다음',
                color: 'yellow',
                onPressed: () => widget.pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              )
            ],
          ),
      ),
    );
  }
}





class SummaryPage extends StatelessWidget {
  final PageController pageController;

  SummaryPage({required this.pageController});

  @override
  Widget build(BuildContext context) {
    // ViewModel에서 데이터 가져오기
    final viewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  child: Image.network(
                      'https://cataas.com/cat',
                      fit: BoxFit.cover,
                      height: 160,
                      width: ResponsiveUtils.getWidthPercent(context, 100)
                  ),
                ),

              ],
            ),

            // 매장정보 카드
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                top: 80,
                right: 16.0,
                left: 16.0,
              ),
              width: ResponsiveUtils.getWidthPercent(context, 100),

              child: Column(
                children: [
                  Container(
                      width: ResponsiveUtils.getWidthPercent(context, 100),
                      height: 500.0,

                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1, // 그림자 범위
                            blurRadius: 7, // 그림자 흐림 정도
                            offset: Offset(0, 3), // 그림자 위치 조정
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20), // 모서리 곡률을 10으로 설정
                      ),
                      // elevation: 4.0,   // Card 일때
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('가게정보',
                            style: TextStyle(fontSize: FontSizes.XLARGE, fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text('전화번호',
                                  style: TextStyle(),),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text('010-2345-6789',
                                  style: TextStyle(),),
                              ),
                            ],
                          ),

                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text('위치',
                                  style: TextStyle(),),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text('010-2345-6789',
                                  style: TextStyle(),),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),

                  Container(
                    child: Column(
                      children: [
                        Text('testttt'),
                      ],
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}




class RegisterComplete extends StatelessWidget {
  final PageController pageController;

  RegisterComplete({required this.pageController});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            // TextField(
            //   onChanged: (value) => viewModel.setOperatingHours(value),
            //   decoration: InputDecoration(labelText: '운영시간'),
            // ),

            BasicButton(
                text: '완료',
                color: 'yellow',
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/stores'));
                }),
          ],
        ),
      ),
    );
  }
}
