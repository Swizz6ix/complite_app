import 'package:complite/events/company_event.dart';

abstract class QueueRepository {
  Future<void> enqueue(CompanyEvent event);
  Future<List<CompanyEvent>> getPending();
  Future<void> remove(CompanyEvent event);
}