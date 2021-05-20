import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_screen_notifier.freezed.dart';
part 'splash_screen_state.dart';

final splashScreenNotifier =
    StateNotifierProvider<SplashScreenNotifier, SplashScreenState>(
        (ref) => SplashScreenNotifier());

class SplashScreenNotifier extends StateNotifier<SplashScreenState> {
  SplashScreenNotifier() : super(SplashScreenState.initial());

  void initialize() async {
    await Future.delayed(Duration(seconds: 1));

    state = SplashScreenState.initialized();
  }
}
