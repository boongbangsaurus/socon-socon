import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socon/viewmodels/sign_up_view_model.dart';
import 'package:socon/views/atoms/checkbox.dart';
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
                  child: Container(
                width: 330,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CustomTextFormField(
                      labelText: '아이디(이메일)',
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String? val) {
                        return null;
                      },
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          debugPrint('email is null $val');
                          return '이메일을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      labelText: '비밀번호',
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
                    ),
                    CustomTextFormField(
                      labelText: '이름',
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
                    ),
                    CustomTextFormField(
                      labelText: '닉네임',
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
                    ),
                    CustomTextFormField(
                      labelText: '전화번호',
                      keyboardType: TextInputType.phone,
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
                    ),
                    CustomTextFormField(
                      labelText: '인증번호',
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String? val) {
                        return null;
                      },
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          debugPrint('인증번호 is null $val');
                          return '인증번호를 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CheckBoxBtn(
                                  Text: '약관 전체동의',
                                  isChecked: isChecked,
                                  onCheckedChanged: (bool isChecked) {
                                    print(isChecked);
                                  })
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )));
        }));
  }
}
