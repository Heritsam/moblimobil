import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/repositories/help_repository.dart';

final helpViewModel = ChangeNotifierProvider((ref) => HelpViewModel(ref.read));

class HelpViewModel extends ChangeNotifier {
  final Reader _read;

  HelpViewModel(this._read);

  bool isLoading = false;
  String description = '';

  void sendHelp(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      await _read(helpRepository).sendHelp(description: description);

      Navigator.popUntil(context, ModalRoute.withName('/home'));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }

    isLoading = false;
    notifyListeners();
  }
}
