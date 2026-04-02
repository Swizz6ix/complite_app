import 'package:complite/events/cacheable_event.dart';
import 'package:complite/events/retryable_event.dart';

base class FetchCompanyData extends RetryableEvent<FetchCompanyData> implements CacheableEvent {
  final String companyId;
  // final int page;
  // final int limit;
 
  FetchCompanyData(
    this.companyId, {
      // this.page = 1,
      // this.limit = 5,
      super.requestId, 
      super.stopwatch, 
      super.retryCount
  });

  @override
  String get cacheKey => "company-$companyId";

  @override
  FetchCompanyData create({String? requestId, Stopwatch? stopwatch}) {
    return FetchCompanyData(
      companyId,
      // page: page,
      // limit: limit,
      requestId: requestId, 
      stopwatch: stopwatch, 
      retryCount: retryCount
    );
  }

  @override
  FetchCompanyData createWithRetry({
    String? requestId,
    Stopwatch? stopwatch,
    int? retryCount,
  }) {
    return FetchCompanyData(
      companyId,
      // page: page,
      // limit: limit,
      requestId: requestId, 
      stopwatch: stopwatch,
      retryCount: retryCount ?? this.retryCount,
    );
  }
}