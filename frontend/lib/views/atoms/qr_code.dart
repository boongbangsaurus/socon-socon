import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:socon/utils/responsive_utils.dart';

class QrCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveUtils.getWidthWithPixels(context, 180),
      child: PrettyQrView.data(

          data: "소콘소콘이 소곤소곤",
          decoration: const PrettyQrDecoration(
              image: PrettyQrDecorationImage(
            image: AssetImage("assets/images/sogumbbang.png"),
          ))),
    );
  }
}
