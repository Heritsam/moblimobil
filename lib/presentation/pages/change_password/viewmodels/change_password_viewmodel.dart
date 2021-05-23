import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.dart';
part 'change_password_viewmodel.freezed.dart';

final changePasswordViewModel =
    StateNotifierProvider<ChangePasswordViewModel, ChangePasswordState>(
        (ref) => ChangePasswordViewModel());

class ChangePasswordViewModel extends StateNotifier<ChangePasswordState> {
  ChangePasswordViewModel() : super(ChangePasswordState.initial());

  void initialize() {
    state = ChangePasswordState.initial();
  }

  void sendOldForm() async {
    state = ChangePasswordState.loading();

    await Future.delayed(Duration(seconds: 1));

    state = ChangePasswordState.newForm();
  }

  void sendNewForm() async {
    state = ChangePasswordState.loading();

    await Future.delayed(Duration(seconds: 1));

    state = ChangePasswordState.success('Success');
  }
}
