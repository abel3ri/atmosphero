import 'package:flutter/material.dart';

class TextFieldProvider with ChangeNotifier {
  late TextEditingController controller;

  TextFieldProvider() {
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
