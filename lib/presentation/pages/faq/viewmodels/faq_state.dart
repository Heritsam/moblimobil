part of 'faq_viewmodel.dart';

@freezed
class FaqState with _$FaqState {
  const factory FaqState.initial() = _Initial;
  const factory FaqState.data(List<FAQ> faqs) = _Data;
  const factory FaqState.error(String message) = _Error;
}
