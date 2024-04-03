import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/responsive_utils.dart';

class QrCodeSocon extends StatefulWidget {
  final int soconId;

  const QrCodeSocon({
    super.key, required this.soconId,
  });

  @override
  State<QrCodeSocon> createState() => _QrCodeSoconState();
}

class _QrCodeSoconState extends State<QrCodeSocon> {
  @protected
  late QrCode qrCode;

  @protected
  late QrImage qrImage;

  @protected
  late PrettyQrDecoration decoration;

  @protected
  late PrettyQrDecorationImage decorationImage;

  @override
  void initState() {
    super.initState();

    var soconData = "socon://info"; // 이동할 링크 /api/v1/socons/{socon_id}/approval
    qrCode = QrCode(6, QrErrorCorrectLevel.H);
    qrCode.addData(soconData);

    qrImage = QrImage(qrCode);

    decoration = const PrettyQrDecoration(
      shape: _PrettyQrSettings.kDefaultQrSmoothSymbol,
      image: _PrettyQrSettings.kDefaultQrDecorationImage,
    );
  }

  @override
  Widget build(BuildContext context) {
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
  @protected
  final PrettyQrDecoration decoration;

  @protected
  @protected
  final ValueChanged<PrettyQrDecoration>? onChanged;

  static const kDefaultQrDecorationImage = PrettyQrDecorationImage(
    image: NetworkImage(
        "https://firebasestorage.googleapis.com/v0/b/socon-socon.appspot.com/o/images%2Fsocon%2Fsocon4.png?alt=media&token=3b6beeab-c92f-45e7-82f2-15280678509c"),
    position: PrettyQrDecorationImagePosition.embedded,
    fit: BoxFit.fill,
  );

  static const kDefaultQrDecorationBrush = AppColors.GRAY900;

  static const kDefaultQrSmoothSymbol = PrettyQrSmoothSymbol(
    color: _PrettyQrSettings.kDefaultQrDecorationBrush,
    roundFactor: 1,
  );

  const _PrettyQrSettings({
    required this.decoration,
    this.onChanged,
  });
}
