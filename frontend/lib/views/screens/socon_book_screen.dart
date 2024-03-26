import 'package:flutter/material.dart';
import 'package:socon/utils/toast_utils.dart';

import '../../utils/fontSizes.dart';
import '../../viewmodels/notification_view_model.dart';

class SoconBookScreen extends StatefulWidget {
  const SoconBookScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SoconBookScreenState();
  }
}

class _SoconBookScreenState extends State<SoconBookScreen> {
  final NotificationViewModel notificationViewModel = NotificationViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "소콘북",
              style: TextStyle(fontSize: FontSizes.LARGE),
            ),
            ElevatedButton(
              child: const Text("Show Toast"),
              onPressed: () async {
                bool success = await notificationViewModel.getFcmToken();
                print("성공 $success");
                if (success) {
                  ToastUtil.showCustomToast(context, "availableSocon");
                } else {
                  ToastUtil.showCustomToast(context, "FCM 토큰 가져오기 실패");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}