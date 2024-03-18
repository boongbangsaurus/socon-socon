import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'register_viewmodel.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('가게 등록하기'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<RegisterViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: <Widget>[
                  Text('대표자', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),),
                  TextFormField(
                    onChanged: (value) => viewModel.setRepresentative(value),
                    decoration: InputDecoration(labelText: '대표자'),
                  ),
                  TextFormField(
                    onChanged: (value) => viewModel.setRegistrationNumber(value),
                    decoration: InputDecoration(labelText: '사업자 등록번호'),
                  ),
                  TextFormField(
                    onChanged: (value) => viewModel.setAddress(value),
                    decoration: InputDecoration(labelText: '주소'),
                  ),
                  TextFormField(
                    onChanged: (value) => viewModel.setName(value),
                    decoration: InputDecoration(labelText: '가게 이름'),
                  ),



                  ElevatedButton(
                    onPressed: () {
                      // 등록 로직 처리
                      // 예: viewModel.registerStore();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('가게 등록이 완료되었습니다.')),
                      );
                    },
                    child: Text('등록하기'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
