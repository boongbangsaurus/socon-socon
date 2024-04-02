import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:socon/models/user.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/viewmodels/login_state_view_model.dart';
import 'package:socon/viewmodels/sign_in_view_model.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/inputs.dart';
import 'package:socon/views/atoms/modal.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:socon/views/screens/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final User user = User(
    email: '',
    password: '',
  );

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context, listen: false);

    return ChangeNotifierProvider<SignInViewModel>(
        create: (context) => SignInViewModel(),
        child: Consumer<SignInViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
              body: Center(
                  // child: Form(
                  //     key: _formKey,
                  child: SingleChildScrollView(
                      child: Container(
                          width: 320,
                          // margin: EdgeInsets.all(0),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // ---------welcom soconsocon Start----------
                                // Container(
                                //   alignment: Alignment.centerLeft,
                                //   child: const Column(
                                //     children: [
                                //       Text(
                                //         '안녕하세요',
                                //         textAlign: TextAlign.start,
                                //       ),
                                //       Text('소콘소콘 입니다.'),
                                //     ],
                                //   ),
                                // ),
                                Container(
                                  alignment:
                                      Alignment.centerLeft, // 여기에서 왼쪽 정렬 설정
                                  child: const Text('안녕하세요.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: FontSizes.XXXLARGE,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      SoconSocon(),
                                      const Text('입니다.',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold,
                                          ))
                                    ]),
                                // ---------welcom soconsocon End----------
                                // ---------user input form Start----------
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 30, top: 10),
                                          child: CustomTextFormField
                                              .setCustomTextFormField(
                                                  labelText: '아이디(이메일)',
                                                  // helperText: '이메일을 입력해주세요.',
                                                  textFormField: TextFormField(
                                                    decoration:
                                                        CustomTextFormField
                                                            .getDecoration(),
                                                    style: CustomTextFormField
                                                        .getTextStyle(),
                                                    cursorColor:
                                                        CustomTextFormField
                                                            .getCursorColor(),
                                                    cursorErrorColor:
                                                        CustomTextFormField
                                                            .getCursorErrorColor(),
                                                    onTapOutside:
                                                        CustomTextFormField
                                                            .onTapOutsideHandler,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    // 실시간 검사
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    onSaved: (String? val) {
                                                      if (val != null) {
                                                        user.email = val;
                                                      }
                                                    },
                                                    validator: (String? val) {
                                                      if (val!.isEmpty) {
                                                        return '이메일을 입력해주세요.';
                                                      } else if (!val
                                                          .contains('@')) {
                                                        return '유효한 이메일 주소를 입력해주세요.';
                                                      }
                                                      return null;
                                                    },
                                                  )),
                                        ),
                                        Container(
                                          child: CustomTextFormField
                                              .setCustomTextFormField(
                                                  labelText: '비밀번호',
                                                  textFormField: TextFormField(
                                                    decoration:
                                                        CustomTextFormField
                                                            .getDecoration(),
                                                    style: CustomTextFormField
                                                        .getTextStyle(),
                                                    cursorColor:
                                                        CustomTextFormField
                                                            .getCursorColor(),
                                                    cursorErrorColor:
                                                        CustomTextFormField
                                                            .getCursorErrorColor(),
                                                    onTapOutside:
                                                        CustomTextFormField
                                                            .onTapOutsideHandler,
                                                    obscureText: true,
                                                    // 비밀번호 같은 민감한 정보는 true처리
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    // 실시간 검사
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onSaved: (String? val) {
                                                      if (val != null) {
                                                        user.password = val;
                                                      }
                                                    },
                                                    validator: (String? val) {
                                                      if (val!.isEmpty) {
                                                        return '비밀번호를 입력해주세요.';
                                                      }
                                                      return null;
                                                    },
                                                  )),
                                        ),
                                        // ---------user input form End----------
                                        // ---------user find password button Start----------
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                              onPressed: () {
                                                print('find password');
                                              },
                                              child: const Text(
                                                '비밀번호를 잊어버리셨나요?',
                                                style: TextStyle(
                                                    color: AppColors.BLACK,
                                                    fontSize:
                                                        FontSizes.XXXSMALL),
                                              )),
                                        ),
                                        // ---------user find password button End----------
                                        // ---------user signin button Start----------
                                        BasicButton(
                                          text: '로그인',
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              _formKey.currentState!.save();
                                              debugPrint(
                                                  'send user ################################################');
                                              debugPrint('$user');
                                              debugPrint(
                                                  '################################################');
                                              bool isSuccess = await Provider
                                                      .of<SignInViewModel>(
                                                          context,
                                                          listen: false)
                                                  .signIn(user);
                                              debugPrint(
                                                  '####$isSuccess############################################');
                                              if (isSuccess) {
                                                // 메인 페이지로 이동
                                                loginState.setLoggedIn(true);
                                                debugPrint(
                                                    'SignInScreen ################################################');
                                                print(loginState.isLoggedIn);
                                                debugPrint(
                                                    'SignInScreen ################################################');

                                                GoRouter.of(context).go('/');
                                              } else {
                                                return showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        CustomModal
                                                            .showCustomDialog(
                                                                title: '로그인 실패',
                                                                content:
                                                                    '로그인에 실패했습니다. 다시 시도해주세요.',
                                                                actions: [
                                                              BasicButton(
                                                                text: '닫기',
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              )
                                                            ]));
                                              }
                                            }
                                          },
                                        ),
                                        // ---------user signin button End----------
                                        // ---------user siginup text button Start----------
                                        Container(
                                          child: TextButton(
                                              onPressed: () {
                                                print('router signup');
                                                GoRouter.of(context)
                                                    .push('/signup');
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             const SignUpScreen()));
                                              },
                                              child: const Text(
                                                '처음 오셨나요? 회원가입 하러 가기',
                                                style: TextStyle(
                                                    color: AppColors.BLACK,
                                                    fontSize:
                                                        FontSizes.XXXSMALL),
                                              )),
                                        ),
                                        // ---------user siginup text button End----------
                                      ],
                                    )),
                              ])))));
        }));
  }

  SizedBox SoconSocon() {
    return SizedBox(
      child: DefaultTextStyle(
        style: const TextStyle(
          // color: AppColors.YELLOW,
          color: AppColors.BLACK,
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
        child: AnimatedTextKit(
          animatedTexts: [
            WavyAnimatedText('소콘소콘 '),
          ],
          isRepeatingAnimation: true,
          // repeatForever: true,
          totalRepeatCount: 10,
        ),
      ),
    );
  }
}
