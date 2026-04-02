import 'package:complite/events/event_handler.dart';
import 'package:complite/events/fetch_company_data.dart';
import 'package:complite/handlers/event_handler.dart';
import 'package:complite/models/company_dto.dart';
import 'package:complite/providers/network_info.dart';
import 'package:complite/repositories/company_repository.dart';
import 'package:complite/repositories/queue_repository.dart';
import 'package:complite/states/results.dart';

class FetchCompanyHandler implements EventHandler<FetchCompanyData, Results<List<CompanyDto>>> {
  final CompanyRepository repository;
  final QueueRepository _queue;
  final NetworkInfo network;
  

  FetchCompanyHandler(this.repository, this._queue, this.network);

  @override
  Future<Results<List<CompanyDto>>> handle(FetchCompanyData event) async {
    event.stopwatch?.start();

    try {
      // Optional simulated API delay
      await Future.delayed(Duration(milliseconds: 300));
      
      if (!await network.isConnected){
        await _queue.enqueue(event);
        return Failure(
          requestId: event.requestId, 
          errorMessage:  "No internet connection"
        );
      }

      return await repository.fetchCompany(
        // page: event.page,
        // limit: event.limit,
      );
    } finally {
      event.stopwatch?.stop();
    }
  }
}
