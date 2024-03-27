import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/viewmodels/sign_up_view_model.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/checkbox.dart';
import 'package:socon/views/atoms/icon_loader.dart';
import 'package:socon/views/atoms/inputs.dart';
import 'package:socon/views/modules/app_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
        create: (context) => SignUpViewModel(),
        child: Consumer<SignUpViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
              appBar: CustomAppBarWithArrow(title: '가입하기'),
              body: Center(
                  child: SingleChildScrollView(
                      child: Container(
                width: 320,
                // margin: EdgeInsets.all(0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(
                    //   child: Column(
                    //     children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 30, top: 10),
                      child: CustomTextFormField.setCustomTextFormField(
                          labelText: '아이디(이메일)',
                          // helperText: '이메일을 입력해주세요.',
                          textFormField: TextFormField(
                            decoration: CustomTextFormField.getDecoration(),
                            style: CustomTextFormField.getTextStyle(),
                            cursorColor: CustomTextFormField.getCursorColor(),
                            cursorErrorColor:
                                CustomTextFormField.getCursorErrorColor(),
                            onTapOutside:
                                CustomTextFormField.onTapOutsideHandler,
                            obscureText: true, // 비밀번호 같은 민감한 정보는 true처리
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction, // 실시간 검사
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? val) {
                              return null;
                            },
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                debugPrint('이메일 is null $val');
                                return '이메일를 입력해주세요.';
                              }
                              return null;
                            },
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: CustomTextFormField.setCustomTextFormField(
                          labelText: '비밀번호',
                          // helperText: '비밀번호를 입력해주세요.',
                          textFormField: TextFormField(
                            decoration: CustomTextFormField.getDecoration(),
                            style: CustomTextFormField.getTextStyle(),
                            cursorColor: CustomTextFormField.getCursorColor(),
                            cursorErrorColor:
                                CustomTextFormField.getCursorErrorColor(),
                            onTapOutside:
                                CustomTextFormField.onTapOutsideHandler,
                            obscureText: true, // 비밀번호 같은 민감한 정보는 true처리
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction, // 실시간 검사
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? val) {
                              return null;
                            },
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                debugPrint('비밀번호 is null $val');
                                return '비밀번호를 입력해주세요.';
                              }
                              return null;
                            },
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: CustomTextFormField.setCustomTextFormField(
                          labelText: '이름',
                          // helperText: '이름을 입력해주세요.',
                          textFormField: TextFormField(
                            decoration: CustomTextFormField.getDecoration(),
                            style: CustomTextFormField.getTextStyle(),
                            cursorColor: CustomTextFormField.getCursorColor(),
                            cursorErrorColor:
                                CustomTextFormField.getCursorErrorColor(),
                            onTapOutside:
                                CustomTextFormField.onTapOutsideHandler,
                            obscureText: true, // 비밀번호 같은 민감한 정보는 true처리
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction, // 실시간 검사
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? val) {
                              return null;
                            },
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                debugPrint('이름 is null $val');
                                return '이름을 입력해주세요.';
                              }
                              return null;
                            },
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: CustomTextFormField.setCustomTextFormField(
                          labelText: '닉네임',
                          // helperText: '닉네임을 입력해주세요.',
                          textFormField: TextFormField(
                            decoration: CustomTextFormField.getDecoration(),
                            style: CustomTextFormField.getTextStyle(),
                            cursorColor: CustomTextFormField.getCursorColor(),
                            cursorErrorColor:
                                CustomTextFormField.getCursorErrorColor(),
                            onTapOutside:
                                CustomTextFormField.onTapOutsideHandler,
                            obscureText: true, // 비밀번호 같은 민감한 정보는 true처리
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction, // 실시간 검사
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? val) {
                              return null;
                            },
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                debugPrint('닉네임 is null $val');
                                return '닉네임을 입력해주세요.';
                              }
                              return null;
                            },
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: CustomTextFormField.setCustomTextFormField(
                          labelText: '전화번호',
                          helperText: '전화번호를 입력해주세요.',
                          textFormField: TextFormField(
                            decoration: CustomTextFormField.getDecoration(),
                            style: CustomTextFormField.getTextStyle(),
                            cursorColor: CustomTextFormField.getCursorColor(),
                            cursorErrorColor:
                                CustomTextFormField.getCursorErrorColor(),
                            onTapOutside:
                                CustomTextFormField.onTapOutsideHandler,
                            obscureText: true, // 비밀번호 같은 민감한 정보는 true처리
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction, // 실시간 검사
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? val) {
                              return null;
                            },
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                debugPrint('전화번호 is null $val');
                                return '전화번호를 입력해주세요.';
                              }
                              return null;
                            },
                          )),
                    ),
                    // ],
                    // ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.GRAY600),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        children: [
                          CheckBoxBtn(
                              Text: '약관 전체동의',
                              isChecked: isChecked,
                              onCheckedChanged: (bool isChecked) {
                                print(isChecked);
                              }),
                          Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: 1.0, color: AppColors.GRAY600)),
                              ),
                              child: Column(children: [
                                Row(children: [
                                  CheckBoxBtn(
                                      Text: '이용약관에 동의합니다.',
                                      isChecked: isChecked,
                                      onCheckedChanged: (bool isChecked) {
                                        print(isChecked);
                                      }),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        '본문보기',
                                        style: TextStyle(
                                          color: AppColors.BLUE500,
                                          fontSize: FontSizes.XXXSMALL,
                                          decorationColor: AppColors.BLUE500,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ))
                                ]),
                                const Padding(
                                  padding: EdgeInsets.only(left: 48, right: 10),
                                  child: Text(
                                    '이용약관에는 마케팅 정보 수신에 대한 동의와 관련된 내용이 포함되어 있습니다.',
                                  ),
                                ),
                                Row(children: [
                                  CheckBoxBtn(
                                      Text: '개인정보 수집 및 이용에 동의합니다.',
                                      isChecked: isChecked,
                                      onCheckedChanged: (bool isChecked) {
                                        print(isChecked);
                                      }),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        '본문보기',
                                        style: TextStyle(
                                          color: AppColors.BLUE500,
                                          fontSize: FontSizes.XXXSMALL,
                                          decorationColor: AppColors.BLUE500,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ))
                                ]),
                              ])),
                        ],
                      ),
                    ),
                    BasicButton(text: '회원가입'),
                    SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ))));
        }));
  }
}
