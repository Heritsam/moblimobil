import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const NetworkExceptions._();
  
  const factory NetworkExceptions.requestCancelled() = _RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest() = _UnauthorisedRequest;

  const factory NetworkExceptions.badRequest() = _BadRequest;

  const factory NetworkExceptions.notFound(String reason) = _NotFound;

  const factory NetworkExceptions.methodNotAllowed() = _MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = _NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = _RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = _SendTimeout;

  const factory NetworkExceptions.conflict() = _Conflict;

  const factory NetworkExceptions.internalServerError() = _InternalServerError;

  const factory NetworkExceptions.notImplemented() = _NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = _ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() =
      _NoInternetConnection;

  const factory NetworkExceptions.formatException() = _FormatException;

  const factory NetworkExceptions.unableToProcess() = _UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = _DefaultError;

  const factory NetworkExceptions.unexpectedError() = _UnexpectedError;

  String get message {
    String errorMessage = '';

    this.when(
      notImplemented: () {
        errorMessage = 'Not Implemented';
      },
      requestCancelled: () {
        errorMessage = 'Request Cancelled';
      },
      internalServerError: () {
        errorMessage = 'Internal Server Error';
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = 'Service unavailable';
      },
      methodNotAllowed: () {
        errorMessage = 'Method Not Allowed';
      },
      badRequest: () {
        errorMessage = 'Bad request';
      },
      unauthorisedRequest: () {
        errorMessage = 'Unauthorised request';
      },
      unexpectedError: () {
        errorMessage = 'Unexpected error occurred';
      },
      requestTimeout: () {
        errorMessage = 'Connection request timeout';
      },
      noInternetConnection: () {
        errorMessage = 'No internet connection';
      },
      conflict: () {
        errorMessage = 'Error due to a conflict';
      },
      sendTimeout: () {
        errorMessage = 'Send timeout in connection with API server';
      },
      unableToProcess: () {
        errorMessage = 'Unable to process the data';
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      formatException: () {
        errorMessage = 'Unexpected error occurred';
      },
      notAcceptable: () {
        errorMessage = 'Not acceptable';
      },
    );

    return errorMessage;
  }
}
