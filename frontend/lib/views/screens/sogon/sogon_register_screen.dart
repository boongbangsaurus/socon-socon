import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socon/models/sogon_register.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/viewmodels/sogon_view_model.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/input_form.dart';
import 'package:socon/views/modules/app_bar.dart';

class SogonRegisterScreen extends StatefulWidget {
  const SogonRegisterScreen({super.key});

  @override
  State<SogonRegisterScreen> createState() => _SogonRegisterScreenState();
}

class _SogonRegisterScreenState extends State<SogonRegisterScreen> {
  SogonViewModel sogonViewModel = SogonViewModel();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  List<XFile?> multiImage = []; // 갤러리에서 사진 선택
  List<XFile?> images = [];
  final SogonRegister sogonRegister =
      SogonRegister(title: '', content: '', lat: 0.0, lng: 0.0, socon_id: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWithArrow(
          title: '소곤 등록',
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: CustomInputField(
                          labelText: '제목',
                          onChanged: (val) {
                            print('새글 작성');
                          }),
                    ),
                    Container(
                      child: CustomInputField(
                          labelText: '내용',
                          onChanged: (val) {
                            print('새글 작성');
                          }),
                    ),
                    const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Icon(
                            Icons.image,
                            color: AppColors.GREEN,
                          ),
                          Text('소콘 등록')
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Ink(
                          decoration: BoxDecoration(
                            color: AppColors.GRAY100, // 배경색 설정
                            borderRadius:
                                BorderRadius.circular(10), // 모서리 둥글게 처리
                          ),
                          child: IconButton(
                            onPressed: () async {
                              final res = await sogonViewModel.socons();
                            },
                            icon: Icon(
                              AppIcons.PLUS,
                              size: 50,
                              color: AppColors.GRAY400, // 아이콘 색상 설정
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Icon(
                            Icons.image,
                            color: AppColors.GREEN,
                          ),
                          Text('사진 추가하기')
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Ink(
                          decoration: BoxDecoration(
                            color: AppColors.GRAY100, // 배경색 설정
                            borderRadius:
                                BorderRadius.circular(10), // 모서리 둥글게 처리
                          ),
                          child: IconButton(
                            onPressed: () async {
                              multiImage = await picker.pickMultiImage();
                              setState(() {
                                images.addAll(multiImage); // 이미지 리스트에 추가
                              });
                            },
                            icon: Icon(
                              AppIcons.PLUS,
                              size: 50,
                              color: AppColors.GRAY400, // 아이콘 색상 설정
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BasicButton(
                      text: '소곤 작성',
                      onPressed: () {
                        // SogonRegister(title: 'test', content: 'test', lat: lat, lng: lng, socon_id: socon_id)
                      },
                    )
                  ],
                ),
              ),
            )));
  }
}
