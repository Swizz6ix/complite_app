import 'package:complite/events/company_event.dart';
import 'package:complite/repositories/queue_repository.dart';

class InMemoryQueueRepository implements QueueRepository {
  final List<CompanyEvent> _queue = [];

  @override
  Future<void> enqueue(CompanyEvent event) async {
    _queue.add(event);
  }

  @override
  Future<List<CompanyEvent>> getPending() async {
    return List.unmodifiable(_queue);
  }

  @override
  Future<void> remove(CompanyEvent event) async {
    _queue.remove(event);
  }
}