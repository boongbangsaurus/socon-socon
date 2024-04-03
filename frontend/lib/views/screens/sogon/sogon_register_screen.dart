import 'package:flutter/material.dart';
import 'package:socon/models/sogon_register.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(
        title: '소곤 작성',
      ),
      body: Padding(
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
            BasicButton(
              text: '보유 소콘',
              onPressed: () async {
                final res = await sogonViewModel.socons();
              },
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
    );
  }
}
