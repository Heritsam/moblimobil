import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructures/models/other/choose_us.dart';
import '../../../../infrastructures/repositories/other_repository.dart';

final chooseUsNotifier = ChangeNotifierProvider<ChooseUsNotifier>((ref) {
  return ChooseUsNotifier(ref.read);
});

class ChooseUsNotifier extends ChangeNotifier {
  final Reader _read;

  ChooseUsNotifier(this._read) {
    fetch();
  }

  List<ChooseUs> items = [];
  bool isLoading = false;

  Future<void> fetch() async {
    isLoading = true;
    notifyListeners();

    try {
      items = await _read(otherRepository).getChooseUs();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      fetch();
    }
  }
}
