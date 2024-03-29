import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageManagerService extends ChangeNotifier {
  Future<bool> captureAndSaveImage(GlobalKey globalKey) async {
    bool _isSaving = false;
    final byteData = await _capturePng(globalKey);
    if (byteData != null) {
      _isSaving = await _saveImg(byteData);
    }

    return _isSaving;
  }

  Future<ByteData?> _capturePng(GlobalKey globalKey) async {
    if (kDebugMode) {
      print("_capturePng 실행");
    }

    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    if (kDebugMode) {
      print(byteData);
    }

    return byteData;
  }

  Future<bool> _saveImg(ByteData byteData) async {
    print("_saveImg 실행");

    final result = await ImageGallerySaver.saveImage(
        byteData.buffer.asUint8List(),
        quality: 80,
        name: "육개장");
    if (kDebugMode) {
      print(result);
    }

    return true;
  }
}
