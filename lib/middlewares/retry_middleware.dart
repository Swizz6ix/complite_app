
import 'package:complite/events/company_event.dart';
import 'package:complite/middlewares/middleware.dart';
import 'package:complite/states/results.dart';
import 'package:logging/logging.dart';

class RetryMiddleware extends Middleware{
  final _logger = Logger("CompanyApp.RetryMiddleware");
  final int maxRetries;

  RetryMiddleware({this.maxRetries = 3});

  @override
 Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
  E event,
  Future<Results<T>> Function(E event) next,
 ) async {
  int attempt = 0;

  while (true) {
    try {
      return await next(event);
    } catch (e) {
      attempt++;

      if (attempt >= maxRetries) rethrow;
      _logger.info("[${event.requestId}] RETRY $attempt");
    }
  }
 }
}