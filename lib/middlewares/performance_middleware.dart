import 'package:complite/events/company_event.dart';
import 'package:complite/middlewares/middleware.dart';
import 'package:complite/states/results.dart';
import 'package:logging/logging.dart';

class PerformanceMiddleware extends Middleware {
  final _logger = Logger('CompanyApp.Performance');

  @override
  Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
    E event,
    Future<Results<T>> Function(E event) next,
  ) async {
    final stopwatch = Stopwatch()..start();

    try {
      final result = await next(event);
      return result;
    } finally {
      stopwatch.stop();
      _logger.info("[${event.requestId}] TIME -> ${stopwatch.elapsedMilliseconds}ms");
    }
  }
}