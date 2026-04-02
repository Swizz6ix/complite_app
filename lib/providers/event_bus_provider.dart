import 'package:complite/events/event_bus.dart';
import 'package:complite/events/fetch_company_data.dart';
import 'package:complite/handlers/fetch_company_handler.dart';
import 'package:complite/middlewares/pipeline.dart';
import 'package:complite/providers/company_repository_provider.dart';
import 'package:complite/providers/network_provider.dart';
import 'package:complite/providers/queue_repository_provider.dart';
import 'package:riverpod/riverpod.dart';

final eventBusProvider = Provider<EventBus>((ref) {
  final repo = ref.read(companyRepositoryProvider);
  final queueRepo = ref.read(queueRepositoryProvider);
  final network = ref.read(networkProvider); 

  final bus = EventBus(middlewares: deFaultPipeline.all, handlers: {
    FetchCompanyData: [FetchCompanyHandler(repo, queueRepo, network)],
  });


  return bus;
});