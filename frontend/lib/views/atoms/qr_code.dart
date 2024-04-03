import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/responsive_utils.dart';

class QrCodeSocon extends StatefulWidget {
  final int soconId;
  final String soconImage;

  const QrCodeSocon({
    required this.soconId,
    this.soconImage = "https://firebasestorage.googleapis.com/v0/b/socon-socon.appspot.com/o/images%2Fsocon%2Fsocon4.png?alt=media&token=3b6beeab-c92f-45e7-82f2-15280678509c"
  });

  @override
  State<QrCodeSocon> createState() => _QrCodeSoconState();
}


class _QrCodeSoconState extends State<QrCodeSocon> {
  late QrCode qrCode;
  late QrImage qrImage;
  late PrettyQrDecoration decoration;

  @override
  void initState() {
    super.initState();

    var soconData = "socon://approval/${widget.soconId}"; // 이동할 링크 /api/v1/socons/{socon_id}/approval
    qrCode = QrCode(6, QrErrorCorrectLevel.H);
    qrCode.addData(soconData);

    qrImage = QrImage(qrCode);

    // Here we pass the 'soconImage' from the widget to the '_PrettyQrSettings' class constructor
    decoration = PrettyQrDecoration(
      shape: _PrettyQrSettings.kDefaultQrSmoothSymbol,
      image: _PrettyQrSettings.kDefaultQrDecorationImage(widget.soconImage),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("[qrcode] 소콘 아이디 ${widget.soconId}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: ResponsiveUtils.getWidthWithPixels(context, 190),
          child: PrettyQrView(
            qrImage: qrImage,
            decoration: decoration,
          ),
        )
      ],
    );
  }
}

class _PrettyQrSettings {
  final PrettyQrDecoration decoration;
  final ValueChanged<PrettyQrDecoration>? onChanged;

  static const kDefaultQrDecorationBrush = AppColors.GRAY900;

  static const kDefaultQrSmoothSymbol = PrettyQrSmoothSymbol(
    color: _PrettyQrSettings.kDefaultQrDecorationBrush,
    roundFactor: 1,
  );

  // Modified constructor to accept 'soconImage' parameter
  _PrettyQrSettings({
    required this.decoration,
    this.onChanged,
    required String soconImage,
  });

  // Modified default decoration image to accept 'soconImage'
  static final kDefaultQrDecorationImage = (String soconImage) => PrettyQrDecorationImage(
    image: NetworkImage(
      soconImage,
    ),
    position: PrettyQrDecorationImagePosition.embedded,
    fit: BoxFit.fill,
  );
}
