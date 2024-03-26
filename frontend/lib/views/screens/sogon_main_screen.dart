import 'package:flutter/material.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/modal.dart';

class SogonMainScreen extends StatefulWidget {
  const SogonMainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SogonMainScreen();
  }
}

class _SogonMainScreen extends State<SogonMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "소곤",
              style: TextStyle(fontSize: FontSizes.LARGE),
            ),
          ),
          FloatingActionButton(onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => CustomModal.showCustomDialog(
                        title: '사장님이신가요?',
                        content: '사장님께서는 사업자 인증 후 점포와 소콘을 등록하실 수 있습니다.'
                            '추후   인증할 수 있습니다.',
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                  child: BasicButton(
                                text: '아니오',
                                btnSize: 's',
                                color: 'gray',
                                textColor: 'black',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                  child: BasicButton(
                                text: '예',
                                btnSize: 's',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ))
                            ],
                          )
                        ]));
          })
        ],
      ),
    );
  }
}
