import 'package:complite/providers/in_memory_queue_repository.dart';
import 'package:riverpod/riverpod.dart';

final queueRepositoryProvider = Provider((ref) {
  return InMemoryQueueRepository();
});