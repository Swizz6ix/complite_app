
import 'package:complite/events/company_event.dart';

abstract class EventHandler<E extends CompanyEvent<E>, R> {
  Future<R> handle(E event);
}