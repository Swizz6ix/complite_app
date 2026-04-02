import 'package:complite/errors/app_error.dart';

sealed class Results<T> {}

class Idle<T> extends Results<T> {}

class Loading<T> extends Results<T> {
  final String requestId;
  Loading(this.requestId);
}

class Success<T> extends Results<T> {
  final String requestId;
  final T data;
  Success(this.requestId, this.data);
}

class Failure<T> extends Results<T> {
  final String requestId;
  final AppError? error;
  final String? errorMessage;

  Failure({
    required this.requestId, 
    this.error, 
    this.errorMessage
  });

  @override
  String toString() =>
    'Failure(required: $requestId, error: $errorMessage)';

  String get message => errorMessage!;
}