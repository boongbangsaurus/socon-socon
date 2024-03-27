import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socon/viewmodels/sign_up_view_model.dart';
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
                  child: Container(
                width: 330,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: Column(
                        children: [
                          CustomTextFormField.setCustomTextFormField(
                              labelText: '비밀번호',
                              helperText: '비밀번호를 입력해주세요.',
                              textFormField: TextFormField(
                                decoration: CustomTextFormField.getDecoration(
                                    suffixs: const IconLoader(
                                  iconName: 'calendar',
                                  width: 20,
                                  height: 20,
                                )),
                                style: CustomTextFormField.getTextStyle(),
                                cursorColor:
                                    CustomTextFormField.getCursorColor(),
                                cursorErrorColor:
                                    CustomTextFormField.getCursorErrorColor(),
                                onTapOutside:
                                    CustomTextFormField.onTapOutsideHandler,
                                obscureText: true, // 비밀번호 같은 민감한 정보는 true처리
                                autovalidateMode: AutovalidateMode
                                    .onUserInteraction, // 실시간 검사
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
                              ))
                        ],
                      ),
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
