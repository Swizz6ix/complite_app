import 'package:complite/states/results.dart';

extension ResultState<T> on Results<T> {
  R when<R>({
    required R Function() idle,
    required R Function(String requestId) loading,
    required R Function(String requestId, T data) success,
    required R Function(String requestId, Object? err) failure,
  }) {
    final state = this;
    if (state is Idle<T>) return idle();
    if (state is Loading<T>) return loading(state.requestId);
    if (state is Success<T>) return success(state.requestId, state.data);
    if (state is Failure<T>) return failure(state.requestId, state.errorMessage ?? state.error);
    throw Exception('Unknown state');
  }
}