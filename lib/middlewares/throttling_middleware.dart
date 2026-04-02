import 'package:complite/events/company_event.dart';
import 'package:complite/middlewares/middleware.dart';
import 'package:complite/states/results.dart';

class ThrottlingMiddleware implements Middleware {
  final Duration interval;
  DateTime? _lastExecution;

  ThrottlingMiddleware({this.interval = const Duration(seconds: 10)});

  @override
  Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
    E event,
    Future<Results<T>> Function(E event) next
  ) async {
    final now = DateTime.now();

    if (_lastExecution == null || now.difference(_lastExecution!) >= interval) {
      _lastExecution = now;
      return next(event);
    } else {
      return Future.error('Event throttled');
    }
  }
}