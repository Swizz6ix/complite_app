import 'package:complite/events/company_event.dart';
import 'package:complite/states/results.dart';

abstract class Middleware {
  Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
    E event,
    Future<Results<T>> Function(E event) next,
  );
}