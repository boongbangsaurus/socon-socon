import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../view/atoms/toast.dart';

Map<String, String> toastMsgList = {
  "answerAccepted" : "댓글이 채택되었어요!",
  "paymentCompleted" : "결제가 완료되었어요!",
  "paymentFailed" : "결제가 실패했어요!",
  "availableSocon" : "근처에 사용가능한 소콘이 있어요!",
  "productIssued" : "상품이 발급되었어요!",
};

class ToastUtil {
  static void initToast(BuildContext context) {
    FToast fToast = FToast();
    fToast.init(context);
  }

  static void showCustomToast(BuildContext context, String type) {
    FToast fToast = FToast();
    fToast.init(context);
    String toastMsg;

    if( toastMsgList.containsKey(type)) {
      toastMsg = toastMsgList[type].toString();
    }else{
      toastMsg = "알림이 도착했어요!";
    }

    fToast.showToast(
      child: CustomToast(type : toastMsg),
      toastDuration: Duration(seconds: 2),
    );
  }
}
