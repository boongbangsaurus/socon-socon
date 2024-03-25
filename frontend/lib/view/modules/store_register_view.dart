import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/view/atoms/buttons.dart';
import 'package:socon/view/atoms/checkbox.dart';
import 'package:socon/view/atoms/dropdown.dart';
import 'package:socon/view/atoms/tag_icon.dart';
import 'package:provider/provider.dart';
import 'package:socon/viewmodel/store_register_viewmodel.dart';


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
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(),
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
        ) : null,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<RegisterViewModel>(
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
    final viewModel = Provider.of<RegisterViewModel>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '대표자',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 50),
              Text(
                '사업자 등록 번호',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (value) => viewModel.setRegistrationNumber(value),
              ),
              SizedBox(height: 50),
              Text(
                '사업자 주소',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                onChanged: (value) => viewModel.setAddress(value),
              ),
              SizedBox(height: 50),
              Text(
                '점포 등록 유의사항',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('점포 폐업신고는 폐업일 최소 7일 이전에 신고해 주세요'),


              BasicButton(text: '다음', color: 'yellow',
                onPressed: () => pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ) ,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class Step2 extends StatelessWidget {
  final PageController pageController;

  Step2({required this.pageController});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '상호명을 입력해주세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              onChanged: (value) => viewModel.setName(value),
              // decoration: InputDecoration(labelText: '상호명'),
            ),
            SizedBox(height: 50),

            Text(
              '전화번호를 입력해 주세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              onChanged: (value) => viewModel.setPhoneNumber(value),
              // decoration: InputDecoration(labelText: '전화번호'),
            ),
            SizedBox(height: 50),

            Text(
              '업종을 선택해 주세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // 업종 연결 state지정필요
            Row(
              children: [
                TagButton(buttonText: '음식점', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}, onSelected: (isSelected) => {viewModel.setCategory('음식점')},),
                TagButton(buttonText: '카페', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}, onSelected: (isSelected) => {viewModel.setCategory('카페')},),
                TagButton(buttonText: '미용', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}, onSelected: (isSelected) => {viewModel.setCategory('미용')},),
                TagButton(buttonText: '숙박', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}, onSelected: (isSelected) => {viewModel.setCategory('숙박')},),
                TagButton(buttonText: '스포츠', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}, onSelected: (isSelected) => {viewModel.setCategory('스포츠')},),
                TagButton(buttonText: '쇼핑', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}, onSelected: (isSelected) => {viewModel.setCategory('쇼핑')},),
              ],
            ),
            Text(
              '업체 주소를 입력해 주세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              onChanged: (value) => viewModel.setAddress(value),
              // decoration: InputDecoration(labelText: '전화번호'),
            ),
            SizedBox(height: 50),

            Text(
              '업체 소개를 입력해 주세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              onChanged: (value) => viewModel.setIntroduction(value),
              // decoration: InputDecoration(labelText: '전화번호'),
            ),
            SizedBox(height: 50),

            Text(
              '업체 사진을 추가해 주세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            TextField(
              onChanged: (value) => viewModel.setImgUrl(value),
              // decoration: InputDecoration(labelText: '전화번호'),
            ),
            SizedBox(height: 50),

            BasicButton(text: '다음', color: 'yellow',
              onPressed: () => pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ) ,
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
                  isChecked ? Text("      $breaktimeStart ~ $breaktimeEnd 휴게시간") : Text(''),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('운영시간을 등록해주세요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: -2.0,
                children: operationDaysMap.keys.map((day) {
                  return TagButton(
                    buttonText: day,
                    buttonColor: operationDaysMap[day]! ? Colors.yellow : Colors.grey,
                    buttonTextColor: Colors.white,
                    onSelected: (day) {},
                    onPressed: operationDaysMap[day]! ? () {} : () { // 수정된 부분
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
                        Dropdown(title: '시작시간', dropdownItems: dropdownItems, onItemSelected: (item) {
                          setState(() {
                            selectedStartTime = item ?? '';
                          });
                        },)
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text('영업종료'),
                        Dropdown(title: '종료시간', dropdownItems: dropdownItems, onItemSelected: (item) {
                          setState(() {
                            selectedEndTime = item ?? '';
                          });
                        },)
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  CheckBoxBtn(Text: '휴게시간',isChecked: isChecked, onCheckedChanged: (bool value) {
                    setState(() {
                      isChecked = value;
                    });
                  }),
                ],
              ),
              isChecked ?
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text('시작'),
                        Dropdown(title: '시작시간', dropdownItems: dropdownItems, onItemSelected: (item) {
                          setState(() {
                            breaktimeStart = item ?? '';
                            viewModel.updateBusinessHour(item ?? '00:00', openAt: selectedStartTime);
                          });
                        },)
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text('종료'),
                        Dropdown(title: '종료시간', dropdownItems: dropdownItems, onItemSelected: (item) {
                          setState(() {
                            breaktimeEnd = item ?? '';
                            viewModel.updateBusinessHour(item ?? '00:00', openAt: selectedEndTime);

                          });
                        },)
                      ],
                    ),
                  ),
                ],
              ) : SizedBox.shrink(),

              BasicButton(text: '요일추가', color: 'yellow',
                  onPressed: () => {_addSelectedTimeWidget() }
              ),

              Column(
                children: selectedTimesWidgets,
              ),



              SizedBox(height: 50),
              BasicButton(text: '다음', color: 'yellow',
                onPressed: () => widget.pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ) ,
              ),
            ],
          ),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("가게 등록 요약",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Divider(),
              Text("대표자: ",
                  style: TextStyle(fontSize: 18)),
              Text("사업자등록번호: ${viewModel.registrationNumber}",
                  style: TextStyle(fontSize: 18)),
              Text("사업자주소: ${viewModel.address}", style: TextStyle(fontSize: 18)),
              Text("상호명: ${viewModel.name}", style: TextStyle(fontSize: 18)),
              Text("전화번호: ${viewModel.phoneNumber}"),
              ListView.builder(
                shrinkWrap: true, // 추가
                physics: NeverScrollableScrollPhysics(),

                itemCount: viewModel.businessHours?.length ?? 0,
                itemBuilder: (context, index) {
                  final businessHour = viewModel.businessHours![index];
                  // 운영시간 문자열 생성
                  String operatingHoursText = "${businessHour.day}: ";
                  if (businessHour.isWorking ?? false) {
                    operatingHoursText += "${businessHour.openAt} - ${businessHour.closeAt}";
                    if (businessHour.breakTime ?? false) {
                      operatingHoursText += " (휴게시간: ${businessHour.breaktimeStart} - ${businessHour.breaktimeEnd})";
                    }
                  } else {
                    operatingHoursText += "휴무";
                  }

                  return Text(
                    operatingHoursText,
                    style: TextStyle(fontSize: 18),
                  );
                },
              ),



              BasicButton(text: '완료', color: 'yellow',
                onPressed: () => pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ) ,
              ),

              // Spacer(),
              // ElevatedButton(
              //   onPressed: () {
              //     // 서버에 데이터를 전송하는 로직을 구현할 수 있습니다.
              //     // 이 예제에서는 단순히 완료 메시지를 보여주는 것으로 대체합니다.
              //     showDialog(
              //       context: context,
              //       builder: (context) => AlertDialog(
              //         title: Text("등록 완료"),
              //         content: Text("가게 등록이 성공적으로 완료되었습니다."),
              //         actions: [
              //           TextButton(
              //             onPressed: () {
              //               Navigator.of(context).pop();
              //             },
              //             child: Text("확인"),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              //   child: Text('등록 완료'),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.green,
              //     foregroundColor: Colors.white,
              //   ),
              // ),

            ],
          ),
        ),
      ),
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

            BasicButton(text: '완료', color: 'yellow',
                onPressed: () {Navigator.popUntil(context, ModalRoute.withName('/stores'));}
            ),

          ],
        ),
      ),
    );
  }
}