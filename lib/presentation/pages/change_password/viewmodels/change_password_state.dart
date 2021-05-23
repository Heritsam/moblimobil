part of 'change_password_viewmodel.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.initial() = _Initial;
  const factory ChangePasswordState.newForm() = _NewForm;
  const factory ChangePasswordState.success(String message) = _Success;
  const factory ChangePasswordState.failure(String message) = _Failure;
  const factory ChangePasswordState.loading() = _Loading;
}
