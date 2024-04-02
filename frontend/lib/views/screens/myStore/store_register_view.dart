import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:socon/models/store_register_model.dart';
import 'dart:io';

import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/bottom_sheet.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/checkbox.dart';
import 'package:socon/views/atoms/dropdown.dart';
import 'package:socon/views/atoms/input_form.dart';
import 'package:socon/views/atoms/tag_icon.dart';
import 'package:socon/viewmodels/store_register_view_model.dart';
import 'package:socon/views/screens/myStore/store_register_success_screen.dart';

class BusinessHour {
  String day;
  bool isWorking;
  String? openAt;
  String? closeAt;
  bool? isBreaktime;
  String? breaktimeStart;
  String? breaktimeEnd;

  BusinessHour({
    required this.day,
    required this.isWorking,
    this.openAt,
    this.closeAt,
    this.isBreaktime = false,
    this.breaktimeStart,
    this.breaktimeEnd,
  });
}

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final PageController _pageController = PageController();

  // final StoreRegisterViewModel viewModel;

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

  // 데이터
  List<BusinessHour> BusinessHours = [];

  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<StoreRegisterViewModel>(context, listen: false);
    return ChangeNotifierProvider<StoreRegisterViewModel>(
      create: (context) => StoreRegisterViewModel(),
      child: Scaffold(
        appBar: AppBar(
                title: Text(
                  '점포 등록(${_currentPageIndex + 1}/4)',
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _onBackPressed,
                ),
              ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
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
                Step3(
                  pageController: _pageController,
                  BusinessHours: BusinessHours,
                ),
                SummaryPage(pageController: _pageController),
              ],
            ),
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
                        style: TextStyle(
                            fontSize: FontSizes.SMALL,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('김싸피', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 40),
                      CustomInputField(
                          labelText: '사업자 등록 번호',
                          onChanged: (value) {
                            viewModel.setRegistrationNumberId(int.parse(value));
                            print(viewModel.registrationNumberId);
                          }),
                      CustomInputField(
                        labelText: '사업자 주소',
                        onChanged: (value) => {viewModel.setAddress(value)},
                      ),
                      Text(
                        '점포 등록 유의사항',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
          )),
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
  File? userImage;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StoreRegisterViewModel>(context);
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputField(
                    labelText: '상호명을 입력해주세요',
                    onChanged: (value) => {viewModel.setName(value)},
                  ),

                  CustomInputField(
                      labelText: '전화번호를 입력해 주세요',
                      onChanged: (value) => {
                            viewModel.setPhoneNumber(value),
                          }),

                  Text(
                    '업종을 선택해 주세요',
                    style: TextStyle(
                        fontSize: FontSizes.SMALL, fontWeight: FontWeight.bold),
                  ),
                  // 업종 연결 state지정필요
                  Row(
                    children: [
                      TagButton(
                        buttonText: '음식점',
                        buttonColor: AppColors.YELLOW,
                        buttonTextColor: AppColors.BLACK,
                        onPressed: () {},
                        onSelected: (isSelected) =>
                            {viewModel.setCategory('음식점')},
                      ),
                      TagButton(
                        buttonText: '카페',
                        buttonColor: AppColors.YELLOW,
                        buttonTextColor: AppColors.BLACK,
                        onPressed: () {},
                        onSelected: (isSelected) =>
                            {viewModel.setCategory('카페')},
                      ),
                      TagButton(
                        buttonText: '미용',
                        buttonColor: AppColors.YELLOW,
                        buttonTextColor: AppColors.BLACK,
                        onPressed: () {},
                        onSelected: (isSelected) =>
                            {viewModel.setCategory('미용')},
                      ),
                      TagButton(
                        buttonText: '숙박',
                        buttonColor: AppColors.YELLOW,
                        buttonTextColor: AppColors.BLACK,
                        onPressed: () {},
                        onSelected: (isSelected) =>
                            {viewModel.setCategory('숙박')},
                      ),
                      TagButton(
                        buttonText: '스포츠',
                        buttonColor: AppColors.YELLOW,
                        buttonTextColor: AppColors.BLACK,
                        onPressed: () {},
                        onSelected: (isSelected) =>
                            {viewModel.setCategory('스포츠')},
                      ),
                      TagButton(
                        buttonText: '쇼핑',
                        buttonColor: AppColors.YELLOW,
                        buttonTextColor: AppColors.BLACK,
                        onPressed: () {},
                        onSelected: (isSelected) =>
                            {viewModel.setCategory('쇼핑')},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomInputField(
                      labelText: '가게 주소를 입력해 주세요',
                      onChanged: (value) => {
                            viewModel.setAddress(value),
                          },
                      hintText: '도로명, 건물명 또는 지번으로 검색'),

                  CustomInputField(
                    labelText: '가게 소개를 입력해 주세요',
                    onChanged: (value) => {
                      viewModel.setIntroduction(value),
                    },
                  ),

                  Text(
                    '가게 사진을 추가해 주세요',
                    style: TextStyle(
                        fontSize: FontSizes.SMALL, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      // 이미지를 보여줄 box
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        width: 80,
                        // 이미지 박스의 너비 설정
                        height: 80,
                        // 이미지 박스의 높이 설정
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
                                      userImage!,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: -10,
                                    right: -10,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 15,
                                      ),
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
                                  var image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (image != null) {
                                    setState(() {
                                      userImage = File(image.path); // 이미지 선택
                                      print('유저이미지~~~~~~~~~~~~~~~~~~~~~~~~~~~');
                                      print(userImage);
                                      viewModel.setImage(userImage.toString());
                                    });
                                  }
                                },
                                icon: Icon(Icons.add),
                                color: Colors.black,
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
    ));
  }
}

class Step3 extends StatefulWidget {
  final PageController pageController;

  final List<BusinessHour>? BusinessHours;

  Step3({required this.pageController, this.BusinessHours});

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  bool isChecked = false;
  List<BusinessHour> BusinessHours = [];

  List<Map> operationDaysList = [
    {'day': '월',
      'isWorking': false,
      'openAt': null,
      'closeAt': null,
      'isBreaktime': false,
      'breaktimeStart': null,
      'breaktimeEnd': null,} ,

    {'day': '화',
      'isWorking': false,
      'openAt': null,
      'closeAt': null,
      'isBreaktime': false,
      'breaktimeStart': null,
      'breaktimeEnd': null,} ,

    {'day': '수',
      'isWorking': false,
      'openAt': null,
      'closeAt': null,
      'isBreaktime': false,
      'breaktimeStart': null,
      'breaktimeEnd': null,} ,

    {'day': '목',
      'isWorking': false,
      'openAt': null,
      'closeAt': null,
      'isBreaktime': false,
      'breaktimeStart': null,
      'breaktimeEnd': null,} ,

    {'day': '금',
      'isWorking': false,
      'openAt': null,
      'closeAt': null,
      'isBreaktime': false,
      'breaktimeStart': null,
      'breaktimeEnd': null,} ,

    {'day': '토',
      'isWorking': false,
      'openAt': null,
      'closeAt': null,
      'isBreaktime': false,
      'breaktimeStart': null,
      'breaktimeEnd': null,} ,

    {'day': '일',
      'isWorking': false,
      'openAt': null,
      'closeAt': null,
      'isBreaktime': false,
      'breaktimeStart': null,
      'breaktimeEnd': null,} ,
  ];

  List<String> dropdownItems = [ '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00', '12:30',  '13:00', '13:30', '14:00', '14:30','15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00', '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30'];
  List<String> Days = ['월', '화', '수', '목', '금', '토', '일'];
  Map<String, dynamic> operationDaysMap = {
    '월': {'isWorking': false},
    '화': {'isWorking': false},
    '수': {'isWorking': false},
    '목': {'isWorking': false},
    '금': {'isWorking': false},
    '토': {'isWorking': false},
    '일': {'isWorking': false},
  };

  List<String> selectedDay = [];
  String selectedStartTime = '';
  String selectedEndTime = '';
  bool is_breaktime = false;
  String breaktimeStart = '';
  String breaktimeEnd = '';


  Map<String, String> selectedStartTimes = {};


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
                    '운영시간을 등록해주세요',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: -2.0,
                    children: Days.map((day) {
                      return TagButton(buttonText: day, buttonColor: AppColors.YELLOW, buttonTextColor: AppColors.WHITE,
                            onSelected: (isSelected) => {
                              setState(() {
                                if (isSelected) {
                                  if (!selectedDay.contains(day)) {
                                    selectedDay.add(day);
                                  }
                                } else {
                                  selectedDay.remove(day);
                                }
                                // print('$selectedDay =======================');
                              })
                            },
                            onPressed: (){},);
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
                      onPressed: () {
                        setState(() {
                          operationDaysList.forEach((dayinfo) {
                            if (selectedDay.contains(dayinfo['day'])){
                              dayinfo['isWorking'] = true;
                              dayinfo['openAt'] = selectedStartTime;
                              dayinfo['closeAt'] = selectedEndTime ;
                              dayinfo['isBreaktime'] = isChecked ;
                              dayinfo['breaktimeStart'] = breaktimeStart ;
                              dayinfo['breaktimeEnd'] = breaktimeEnd;
                            }
                          });
                          // 선택요일 초기화
                          selectedDay = [];
                        });

                      }),
                  Column(
                    children: operationDaysList.where((dayInfo) => dayInfo['isWorking'] as bool).map((filteredDayInfo) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row( // Row 위젯을 추가하여 텍스트와 버튼을 가로로 배열
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // 요소들을 양 끝으로 정렬
                            children: [
                              Expanded( // 텍스트가 버튼보다 넓은 공간을 차지하도록 함
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${filteredDayInfo['day']}     ${filteredDayInfo['openAt']} ~ ${filteredDayInfo['closeAt']}'),
                                    filteredDayInfo['isBreaktime'] ? Text('        ${filteredDayInfo['breaktimeStart']} ~  ${filteredDayInfo['breaktimeEnd']}  휴식시간') : Text(''),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close), // X 아이콘
                                onPressed: () {
                                  setState(() {
                                    filteredDayInfo['isWorking'] = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  )

                  // SizedBox(height: 50),
                ],
              ),
            )),
            BasicButton(
                text: '다음',
                color: 'yellow',
                onPressed: () => {
                      widget.pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                    // viewModel에 보내기
                    operationDaysList.forEach((element) {print('$element >>>>>>>>>>>>>>>>>>>>>>>>>>>>');}),
                    viewModel.setBusinessHours(operationDaysList),
                    }),
          ],
        ),
      ),
    );
  }
}





class SummaryPage extends StatelessWidget {
  final PageController pageController;

  SummaryPage({required this.pageController});

  final Widget _header = Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6.0, bottom: 8.0),
            width: 50.0,
            height: 6.5,
            decoration: BoxDecoration(
                color: Colors.black45, borderRadius: BorderRadius.circular(50)),
          ),
          // bottom header Title Text - nullable
          // Text("Drag the header to see bottom sheet"),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    // ViewModel에서 데이터 가져오기
    final viewModel = Provider.of<StoreRegisterViewModel>(context);
    final Size _size = MediaQuery.of(context).size;

    final List? businessHours = viewModel.businessHours;

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Expanded(child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            // 가게 url 이미지
                            child: Image.network(
                                viewModel.image.toString(),
                                fit: BoxFit.cover,
                                height: 160,
                                width: ResponsiveUtils.getWidthPercent(context, 100)
                            ),
                          ),
                          Text(viewModel.image.toString()),
                          Text('ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ'),


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
                              // height: 500.0,

                              padding: EdgeInsets.all(20),
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
                                  // Title
                                  Text('가게정보',
                                    style: TextStyle(fontSize: FontSizes.XLARGE, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 20,),

                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text('상호명',
                                          style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(viewModel.name.toString(),
                                          style: TextStyle(),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text('카테고리',
                                          style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: TagIcon(buttonText: viewModel.category.toString(), buttonColor: AppColors.GRAY500, buttonTextColor: AppColors.WHITE)
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  // 사실 lat lng값 받아야함...
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text('위치',
                                          style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(viewModel.address.toString(),
                                          style: TextStyle(),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text('운영시간',
                                          style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),

                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: businessHours?.map((element) {
                                            return Container(
                                              child: Row(
                                                children: [
                                                  element['isWorking'] ?
                                                  Text('${element['day']} ${element['openAt']} ~ ${element['closeAt']}') :
                                                      Text(''),
                                                ],
                                              ),
                                            );
                                          }).toList() ?? [],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  // 대표자명 수정 - 사용자이름??
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text('대표자명',
                                          style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text('김싸피',
                                          style: TextStyle(),),
                                      ),
                                      // Expanded(
                                      //   flex: 3,
                                      //   child: Text(viewModel.name.toString(),
                                      //     style: TextStyle(),),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text('사업자 주소',
                                          style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(viewModel.address.toString(),
                                          style: TextStyle(),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text('사업자 등록번호',
                                          style: TextStyle(fontWeight: FontWeight.w600),),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(viewModel.registrationNumberId.toString(),
                                          style: TextStyle(),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),

                                ],
                              ),
                            ),

                            SizedBox(height: 20,),

                            ///////////////// 가게 소개 Container
                            Container(
                              width: ResponsiveUtils.getWidthPercent(context, 100),
                              height: 200.0,

                              padding: EdgeInsets.all(20),
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
                                  // Title
                                  Text('가게 소개',
                                    style: TextStyle(fontSize: FontSizes.XLARGE, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 20,),
                                 Text(viewModel.introduction.toString()),


                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                )
                ),
                // 버튼 페이지
                SizedBox(height: 10,),
              ],
            ),
          ),
          // 바텀시트
          Container(
            height: _size.height,
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: CustomBottomSheet(
              // maxHeight: _size.height * 0.745,
              maxHeight: _size.height * 0.200,
              headerHeight: 40.0,
              header: this._header,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: -1.0,
                    offset: Offset(0.0, 3.0)),
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    spreadRadius: -1.0,
                    offset: Offset(0.0, 0.0)),
              ],
              children: [
                // 여기에 들어갈 위젯 넣기
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: BasicButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    text: '돌아가기',
                    color: 'gray',
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: BasicButton(
                    onPressed: () {
                      viewModel.registerStore();
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context) => StoreRegisterSuccessScreen()),
                      // );
                    },
                    text: '등록하기',
                  ),
                ),
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

