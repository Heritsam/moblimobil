import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerNotifier = ChangeNotifierProvider((ref) => RegisterNotifier());

class RegisterNotifier extends ChangeNotifier {
  bool isObscured = true;

  void toggleObscure() {
    isObscured = !isObscured;
    notifyListeners();
  }
}