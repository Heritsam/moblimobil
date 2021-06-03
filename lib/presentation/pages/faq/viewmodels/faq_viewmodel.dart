import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../infrastructures/models/faq/faq.dart';
import '../../../../infrastructures/repositories/faq_repository.dart';

part 'faq_state.dart';
part 'faq_viewmodel.freezed.dart';

final faqViewModel = StateNotifierProvider<FaqViewModel, FaqState>((ref) {
  return FaqViewModel(ref.read);
});

class FaqViewModel extends StateNotifier<FaqState> {
  final Reader _read;

  FaqViewModel(this._read) : super(FaqState.initial()) {
    fetchFaq();
  }

  Future<void> fetchFaq() async {
    state = FaqState.initial();

    try {
      final faqs = await _read(faqRepository).faqs();

      state = FaqState.data(faqs);
    } on NetworkExceptions catch (e) {
      state = FaqState.error(e.message);
    }
  }
}
