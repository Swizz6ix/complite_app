import 'package:complite/events/company_event.dart';
import 'package:complite/middlewares/middleware.dart';
import 'package:complite/states/results.dart';

class DeduplicationMiddleware implements Middleware {
  final _activeRequests = <String, Future>{};

  @override
  Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
    E event,
    Future<Results<T>> Function(E event) next,
  ) {
    if (_activeRequests.containsKey(event.requestId)) {
      return _activeRequests[event.requestId] as Future<Results<T>>;
    }

    final future = next(event);
    _activeRequests[event.requestId] = future;

    future.whenComplete(() => _activeRequests.remove(event.requestId));

    return future;
  }
}