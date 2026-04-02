import 'package:complite/events/company_event.dart';
import 'package:complite/middlewares/middleware.dart';
import 'package:complite/states/results.dart';
import 'package:logging/logging.dart';

class LoggingMiddleware implements Middleware {
  final _logger = Logger('CompanyApp.Middleware');

  @override
  Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
    E event,
    Future<Results<T>> Function(E event) next,
  ) async {
    _logger.info("[${event.requestId}] START -> ${event.runtimeType}");

    try {
      final result = await next(event);

      _logger.info("${event.requestId} SUCCESS");
      return result;
    } catch (e) {
      _logger.info("[${event.requestId}] ERROR -> $e");
      rethrow;
    }
  }
}