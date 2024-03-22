import 'package:flutter/material.dart';
import 'package:socon/view/atoms/buttons.dart';
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
      // PageView의 첫 페이지에서 뒤로 가기 버튼을 누르면 이전 화면으로 돌아감
      Navigator.pop(context);
    } else {
      // 그렇지 않으면 PageView 내에서 이전 페이지로 이동
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

            Expanded(
              child: Container(), // 화면의 나머지 부분을 차지하여 버튼을 아래로 밀어냄
            ),
            ElevatedButton(
              onPressed: () => pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              child: BasicButton(text: '다음'),
            ),
          ],
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
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              '상호명을 입력해주세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              onChanged: (value) => viewModel.setName(value),
              // decoration: InputDecoration(labelText: '상호명'),
            ),
            Text(
              '전화번호를 입력해 주세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              onChanged: (value) => viewModel.setPhoneNumber(value),
              // decoration: InputDecoration(labelText: '전화번호'),
            ),
            Text(
              '업종을 선택해 주세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // 업종 연결 state지정필요
            Row(
              children: [
                TagButton(buttonText: '음식점', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}),
                TagButton(buttonText: '카페', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}),
                TagButton(buttonText: '미용', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}),
                TagButton(buttonText: '숙박', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}),
                TagButton(buttonText: '스포츠', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}),
                TagButton(buttonText: '쇼핑', buttonColor: Colors.yellow, buttonTextColor: Colors.black, onPressed: (){}),
              ],
            ),

            Expanded(
              child: Container(), // 화면의 나머지 부분을 차지하여 버튼을 아래로 밀어냄
            ),
            ElevatedButton(
              onPressed: () => pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              child: Text('다음'),
            ),
          ],
        ),
      ),
    );
  }
}

class Step3 extends StatelessWidget {
  final PageController pageController;

  Step3({required this.pageController});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            // TextField(
            //   onChanged: (value) => viewModel.setOperatingHours(value),
            //   decoration: InputDecoration(labelText: '운영시간'),
            // ),
            ElevatedButton(
              onPressed: () => pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              child: Text('요약'),
            ),
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
      body: Container(
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
            Text("전화번호: ${viewModel.phoneNumber}",
                style: TextStyle(fontSize: 18)),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // 서버에 데이터를 전송하는 로직을 구현할 수 있습니다.
                // 이 예제에서는 단순히 완료 메시지를 보여주는 것으로 대체합니다.
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("등록 완료"),
                    content: Text("가게 등록이 성공적으로 완료되었습니다."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("확인"),
                      ),
                    ],
                  ),
                );
              },
              child: Text('등록 완료'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
