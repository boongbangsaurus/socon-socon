import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrPublishingService {
  
  Future<String?> makeQrCode() async{
    try{
      print("qr을 만들어볼게");

      // PrettyQrView.data(
      //   data: "소콘소콘이 소곤소곤",
      //   decoration: const PrettyQrDecoration(
      //     image: PrettyQrDecorationImage(image:
      //       AssetImage("images/osou.jpg"),
      //     )
      //   )
      // );



    }catch(error){
      print("qrCode 만들기 실패 $error");
      return null;
    }
  }

}