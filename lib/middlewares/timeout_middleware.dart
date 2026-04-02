import 'package:complite/events/company_event.dart';
import 'package:complite/middlewares/middleware.dart';
import 'package:complite/states/results.dart';
import 'package:logging/logging.dart';

class TimeoutMiddleware implements Middleware {
  final _logger = Logger('CompanyApp.TimeoutMiddleware');
  final Duration timeout;

  TimeoutMiddleware({required this.timeout});

  @override
  Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
    E event,
    Future<Results<T>> Function(E event) next,
  ) async {
    _logger.info("TimeoutMiddleware START ${event.requestId}");
    
    final result = await next(event).timeout(timeout, onTimeout: () {
      _logger.severe("TIMEOUT ${event.requestId}");
      throw Exception("[${event.requestId}] Timeout after $timeout");
    });

    _logger.info("TimeoutMiddleware END ${event.requestId}");
    return result;
  }
}