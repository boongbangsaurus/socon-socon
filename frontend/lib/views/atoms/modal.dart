import 'package:flutter/material.dart';

class CustomModal {
  static AlertDialog showCustomDialog({
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions,
    );
  }
}
