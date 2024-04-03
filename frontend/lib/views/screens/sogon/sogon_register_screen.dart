import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socon/models/sogon_register.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/viewmodels/sogon_view_model.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/inputs.dart';
import 'package:socon/views/atoms/modal.dart';
import 'package:socon/views/modules/app_bar.dart';
import 'package:socon/views/modules/socon_mysocon.dart';

class SogonRegisterScreen extends StatefulWidget {
  const SogonRegisterScreen({super.key});

  @override
  State<SogonRegisterScreen> createState() => _SogonRegisterScreenState();
}

class _SogonRegisterScreenState extends State<SogonRegisterScreen> {
  SogonViewModel sogonViewModel = SogonViewModel();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  bool isSelected = false;
  int selectSocon = 0;
  List<XFile?> images = []; // 갤러리에서 사진 선택
  XFile? image;
  String? nickname;

  void getImage(ImageSource source) async {
    image = await picker.pickImage(source: source);

    setState(() {
      images.add(image);
    });
  }

  void setImage() async {
    final image = this.image;
    if (image != null) {
      File _file = File(image.path);
      FirebaseStorage.instance
          .ref('$nickname/picker/test_image')
          .putFile(_file);
    }
  }

  void setSelect(bool select) {
    setState(() {
      isSelected = select;
    });
  }

  final SogonRegister sogonRegister = SogonRegister(
      title: '', content: '', lat: null, lng: null, socon_id: null);

  void setSoconId(int id) {
    setState(() {
      selectSocon = id;
    });
  }

  Future<String?> getUserNickname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userNickname');
  }

  @override
  void initState() {
    super.initState();
    loadUserNickname();
  }

  void loadUserNickname() async {
    nickname = await getUserNickname();
  }

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
                      margin: EdgeInsets.only(bottom: 30, top: 10),
                      child: CustomTextFormField.setCustomTextFormField(
                          labelText: '제목',
                          textFormField: TextFormField(
                            decoration: CustomTextFormField.getDecoration(),
                            style: CustomTextFormField.getTextStyle(),
                            cursorColor: CustomTextFormField.getCursorColor(),
                            cursorErrorColor:
                                CustomTextFormField.getCursorErrorColor(),
                            onTapOutside:
                                CustomTextFormField.onTapOutsideHandler,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            // 실시간 검사
                            keyboardType: TextInputType.text,
                            onSaved: (String? val) {
                              if (val != null) {
                                sogonRegister.title = val;
                              }
                            },
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return '제목을 입력해주세요.';
                              }
                              return null;
                            },
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30, top: 10),
                      child: CustomTextFormField.setCustomTextFormField(
                          labelText: '내용',
                          helperText: '나누고 싶은 이야기를 적어주세요.',
                          textFormField: TextFormField(
                            decoration: CustomTextFormField.getDecoration(),
                            style: CustomTextFormField.getTextStyle(),
                            cursorColor: CustomTextFormField.getCursorColor(),
                            cursorErrorColor:
                                CustomTextFormField.getCursorErrorColor(),
                            onTapOutside:
                                CustomTextFormField.onTapOutsideHandler,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            // 실시간 검사
                            keyboardType: TextInputType.text,
                            onSaved: (String? val) {
                              if (val != null) {
                                sogonRegister.content = val;
                              }
                            },
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return '내용을 입력해주세요.';
                              }
                              return null;
                            },
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () => _openSoconList(),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                backgroundColor: AppColors.GRAY300,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                foregroundColor: AppColors.BLACK),
                            child: Text('소콘 등록') // 버튼에 표시할 텍스트
                            ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          isSelected ? '선택 완료' : '소콘을 선택해주세요.',
                        )
                      ],
                    ),
                    const SizedBox(
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
                          Text('사진 추가하기'),
                        ]),
                    const SizedBox(
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
                            onPressed: () => getImage(ImageSource.gallery),
                            icon: const Icon(
                              AppIcons.PLUS,
                              size: 50,
                              color: AppColors.GRAY400, // 아이콘 색상 설정
                            ),
                          ),
                        ),
                        ...images.where((image) => image != null).map((image) {
                          return Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10), // 모서리 둥글게 처리
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(image!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          images.remove(image);
                                        });
                                      },
                                      child: const Icon(
                                        Icons.cancel_rounded,
                                        color: AppColors.BLACK,
                                        size: 20,
                                      ),
                                    ))
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BasicButton(
                      text: '소곤 작성',
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (isSelected) {
                            _formKey.currentState!.save();
                            Location location = Location(); // 내 위치
                            var currentLocation = await location.getLocation();
                            sogonRegister.lat = currentLocation.latitude;
                            sogonRegister.lng = currentLocation.longitude;
                            setImage();
                            sogonRegister.image1 =
                                '$nickname/picker/test_image';
                            debugPrint(
                                'send sogon register ################################################');
                            debugPrint('$sogonRegister');
                            debugPrint(
                                '################################################');
                            bool isSuccess = await sogonViewModel
                                .sogonRegister(sogonRegister);

                            debugPrint(
                                '####$isSuccess############################################');
                            if (isSuccess) {
                              // 소곤 페이지로 이동
                              GoRouter.of(context).go('/sogon');
                            }
                          } else {
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomModal.showCustomDialog(
                                        title: '소곤 등록 실패',
                                        content: '소곤 등록에 실패했습니다. 다시 시도해주세요.',
                                        actions: [
                                          BasicButton(
                                            text: '닫기',
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ]));
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            )));
  }

  void _openSoconList() async {
    final res = await sogonViewModel.socons();
    return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          color: AppColors.WHITE,
          width: ResponsiveUtils.getWidthPercent(context, 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('소콘 등록',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('등록할 소콘을 선택해주세요.'),
              ),
              SingleChildScrollView(
                  child: Container(
                height: 300,
                margin: EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  // child 위젯의 크기를 정해주지 않은 경우 true로 지정해야됨
                  physics: ClampingScrollPhysics(),
                  itemCount: res.length,
                  //item 개수
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                    childAspectRatio: 1 / 1.2, //item 의 가로 세로의 비율
                    mainAxisSpacing: 5, //수평 Padding
                    crossAxisSpacing: 5, //수직 Padding
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: selectSocon == res[index].socon_id
                                  ? AppColors.YELLOW
                                  : Colors.transparent,
                              width: 3.0),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: MySocon(
                          available: true,
                          soconName: res[index].item_name,
                          storeName: res[index].store_name,
                          dueDate: DateFormat('yyyy-MM-dd')
                              .format(res[index].expired_at),
                          imageUrl: res[index].item_image,
                          onPressed: () {
                            setSoconId(res[index].socon_id);
                            print('선택 ${res[index].socon_id}');
                          },
                        ));
                  },
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BasicButton(
                    text: '닫기',
                    btnSize: 'xs',
                    color: 'gray',
                    onPressed: () {
                      if (selectSocon == 0) {
                        setSelect(false);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                  BasicButton(
                    text: '선택',
                    btnSize: 'xs',
                    onPressed: () {
                      if (selectSocon == 0) {
                        setSelect(false);
                      } else {
                        setSelect(true);
                      }
                      sogonRegister.socon_id = selectSocon;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
