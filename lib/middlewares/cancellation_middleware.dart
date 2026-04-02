import 'package:complite/events/company_event.dart';
import 'package:complite/states/results.dart';
import 'package:complite/utlities/cancellation_token.dart';
import 'package:complite/middlewares/middleware.dart';

class CancellationMiddleware implements Middleware {
  @override
  Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
    E event,
    Future<Results<T>> Function(E event) next, {
    CancellationToken? token,
  }) async {
    token?.throwIfCancelled(); // before execution
    final result = await next(event);
    token?.throwIfCancelled(); // After execution

    return result;
  }
}