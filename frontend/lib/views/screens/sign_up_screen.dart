import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socon/models/user.dart';
import 'package:socon/services/auth_service.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/viewmodels/sign_up_view_model.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/checkbox.dart';
import 'package:socon/views/atoms/inputs.dart';
import 'package:socon/views/modules/app_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final User user = User(
    email: '',
    password: '',
    name: '',
    nickname: '',
    phoneNumber: '',
    isAgreed: false,
  );

  bool _isAllAgreed = false; // 모든 약관에 동의했는지 여부
  bool _isTermsAgreed = false; // 이용약관 동의
  bool _isPrivacyAgreed = false; // 개인정보 수집 동의

  // user checkbox 전체 선택 상태관리
  void _setAllAgreed(bool value) {
    setState(() {
      _isAllAgreed = value;
      _isTermsAgreed = value;
      _isPrivacyAgreed = value;
    });
  }

  // user 이용약관동의 선택 상태관리
  void _setTermsAgreed(bool value) {
    setState(() {
      _isTermsAgreed = value;
      if (_isTermsAgreed && _isPrivacyAgreed) {
        _isAllAgreed = true;
      } else {
        _isAllAgreed = false;
      }
    });
  }

  // user 개인정보처리방침 선택 상태관리
  void _setPrivacyAgreed(bool value) {
    setState(() {
      _isPrivacyAgreed = value;
      if (_isTermsAgreed && _isPrivacyAgreed) {
        _isAllAgreed = true;
      } else {
        _isAllAgreed = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
        create: (context) => SignUpViewModel(),
        child: Consumer<SignUpViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
              appBar: CustomAppBarWithArrow(title: '가입하기'),
              body: Center(
                  child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                          child: Container(
                        width: 320,
                        // margin: EdgeInsets.all(0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // ---------user input form Start----------
                            Container(
                              margin: EdgeInsets.only(bottom: 30, top: 10),
                              child: CustomTextFormField.setCustomTextFormField(
                                  labelText: '아이디(이메일)',
                                  // helperText: '이메일을 입력해주세요.',
                                  textFormField: TextFormField(
                                    decoration:
                                        CustomTextFormField.getDecoration(),
                                    style: CustomTextFormField.getTextStyle(),
                                    cursorColor:
                                        CustomTextFormField.getCursorColor(),
                                    cursorErrorColor: CustomTextFormField
                                        .getCursorErrorColor(),
                                    onTapOutside:
                                        CustomTextFormField.onTapOutsideHandler,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // 실시간 검사
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (String? val) {
                                      if (val != null) {
                                        user.email = val;
                                      }
                                    },
                                    validator: (String? val) {
                                      if (val == null || val.isEmpty) {
                                        return '이메일을 입력해주세요.';
                                      } else if (!val.contains('@')) {
                                        return '유효한 이메일 주소를 입력해주세요.';
                                      }
                                      return null;
                                    },
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: CustomTextFormField.setCustomTextFormField(
                                  labelText: '비밀번호',
                                  helperText: '최소 8자 이상 입력해주세요.',
                                  textFormField: TextFormField(
                                    decoration:
                                        CustomTextFormField.getDecoration(),
                                    style: CustomTextFormField.getTextStyle(),
                                    cursorColor:
                                        CustomTextFormField.getCursorColor(),
                                    cursorErrorColor: CustomTextFormField
                                        .getCursorErrorColor(),
                                    onTapOutside:
                                        CustomTextFormField.onTapOutsideHandler,
                                    obscureText: true,
                                    // 비밀번호 같은 민감한 정보는 true처리
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // 실시간 검사
                                    keyboardType: TextInputType.text,
                                    onSaved: (String? val) {
                                      if (val != null) {
                                        user.password = val;
                                      }
                                    },
                                    validator: (String? val) {
                                      if (val == null || val.isEmpty) {
                                        return '비밀번호를 입력해주세요.';
                                      } else if (val.length < 8) {
                                        return '비밀번호는 최소 8자 이상이어야 합니다.';
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
                                    decoration:
                                        CustomTextFormField.getDecoration(),
                                    style: CustomTextFormField.getTextStyle(),
                                    cursorColor:
                                        CustomTextFormField.getCursorColor(),
                                    cursorErrorColor: CustomTextFormField
                                        .getCursorErrorColor(),
                                    onTapOutside:
                                        CustomTextFormField.onTapOutsideHandler,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // 실시간 검사
                                    keyboardType: TextInputType.text,
                                    onSaved: (String? val) {
                                      if (val != null) {
                                        user.name = val;
                                      }
                                    },
                                    validator: (String? val) {
                                      if (val == null || val.isEmpty) {
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
                                    decoration:
                                        CustomTextFormField.getDecoration(),
                                    style: CustomTextFormField.getTextStyle(),
                                    cursorColor:
                                        CustomTextFormField.getCursorColor(),
                                    cursorErrorColor: CustomTextFormField
                                        .getCursorErrorColor(),
                                    onTapOutside:
                                        CustomTextFormField.onTapOutsideHandler,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // 실시간 검사
                                    keyboardType: TextInputType.text,
                                    onSaved: (String? val) {
                                      if (val != null) {
                                        user.nickname = val;
                                      }
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
                                  helperText: '숫자만 입력해주세요.',
                                  textFormField: TextFormField(
                                    decoration:
                                        CustomTextFormField.getDecoration(),
                                    style: CustomTextFormField.getTextStyle(),
                                    cursorColor:
                                        CustomTextFormField.getCursorColor(),
                                    cursorErrorColor: CustomTextFormField
                                        .getCursorErrorColor(),
                                    onTapOutside:
                                        CustomTextFormField.onTapOutsideHandler,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    // 실시간 검사
                                    keyboardType: TextInputType.number,
                                    onSaved: (String? val) {
                                      if (val != null) {
                                        user.phoneNumber = val;
                                      }
                                    },
                                    validator: (String? val) {
                                      if (val == null || val.isEmpty) {
                                        return '전화번호를 입력해주세요.';
                                      } else if (val.contains('-')) {
                                        return '전화번호에는 "-"를 포함할 수 없습니다.';
                                      } else if (!RegExp(r'^[0-9]+$')
                                          .hasMatch(val)) {
                                        // 숫자만 포함하는지 검사하는 정규식
                                        return '전화번호는 숫자만 포함해야 합니다.';
                                      }
                                      return null;
                                    },
                                  )),
                            ),
                            // ---------user input form End----------
                            // ---------user checkbox form Start----------
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.GRAY300),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _isAllAgreed,
                                        onChanged: (bool? value) {
                                          _setAllAgreed(value!);
                                          debugPrint(
                                              '$_isAllAgreed, $_isPrivacyAgreed, $_isTermsAgreed');
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        fillColor: MaterialStateProperty
                                            .resolveWith<Color>((states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return Colors
                                                .blue; // 선택됐을 때의 내부 바탕색 설정
                                          }
                                          return Colors.white; // 기본 내부 바탕색 설정
                                        }),
                                      ),
                                      Text('약관 전체동의'),
                                    ],
                                  ),
                                  Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                width: 1.0,
                                                color: AppColors.GRAY300)),
                                      ),
                                      child: Column(children: [
                                        Row(children: [
                                          Checkbox(
                                            value: _isTermsAgreed,
                                            onChanged: (bool? value) {
                                              _setTermsAgreed(value!);
                                              debugPrint(
                                                  '$_isAllAgreed, $_isPrivacyAgreed, $_isTermsAgreed');
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            fillColor: MaterialStateProperty
                                                .resolveWith<Color>((states) {
                                              if (states.contains(
                                                  MaterialState.selected)) {
                                                return Colors
                                                    .blue; // 선택됐을 때의 내부 바탕색 설정
                                              }
                                              return Colors
                                                  .white; // 기본 내부 바탕색 설정
                                            }),
                                          ),
                                          Text('이용약관에 동의합니다.'),
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                '본문보기',
                                                style: TextStyle(
                                                  color: AppColors.BLUE500,
                                                  fontSize: FontSizes.XXXSMALL,
                                                  decorationColor:
                                                      AppColors.BLUE500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ))
                                        ]),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 48, right: 10),
                                          child: Text(
                                            '이용약관에는 마케팅 정보 수신에 대한 동의와 관련된 내용이 포함되어 있습니다.',
                                          ),
                                        ),
                                        Row(children: [
                                          Checkbox(
                                            value: _isPrivacyAgreed,
                                            onChanged: (bool? value) {
                                              _setPrivacyAgreed(value!);
                                              debugPrint(
                                                  '$_isAllAgreed, $_isPrivacyAgreed, $_isTermsAgreed');
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            fillColor: MaterialStateProperty
                                                .resolveWith<Color>((states) {
                                              if (states.contains(
                                                  MaterialState.selected)) {
                                                return Colors
                                                    .blue; // 선택됐을 때의 내부 바탕색 설정
                                              }
                                              return Colors
                                                  .white; // 기본 내부 바탕색 설정
                                            }),
                                          ),
                                          Text('개인정보 수집 및 이용에 동의합니다.'),
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                '본문보기',
                                                style: TextStyle(
                                                  color: AppColors.BLUE500,
                                                  fontSize: FontSizes.XXXSMALL,
                                                  decorationColor:
                                                      AppColors.BLUE500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ))
                                        ]),
                                      ])),
                                ],
                              ),
                            ),
                            // ---------user checkbox form End----------
                            // ---------user signup button Start----------
                            BasicButton(
                              text: '회원가입',
                              onPressed: (_formKey.currentState?.validate() ??
                                          false) &&
                                      _isAllAgreed
                                  ? () async {
                                      _formKey.currentState!.save();
                                      user.isAgreed = true;
                                      debugPrint('$user');
                                      // AuthService authService = AuthService();
                                      // bool isSuccess =
                                      //     await authService.signUp(user);
                                      // if (isSuccess) {
                                      // 성공 알림 표시 및 로그인 페이지로 이동
                                      // } else {
                                      // 실패 알림 표시
                                      // }
                                    }
                                  : null,
                            ),
                            // ---------user signup button End----------
                            const SizedBox(
                              height: 25,
                            )
                          ],
                        ),
                      )))));
        }));
  }
}
