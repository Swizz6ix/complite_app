import 'package:complite/events/company_event.dart';

base class RetryFetch extends CompanyEvent<RetryFetch> {
  RetryFetch({super.requestId, super.stopwatch});

  @override
  RetryFetch create({String? requestId, Stopwatch? stopwatch}) {
    return RetryFetch(requestId: requestId, stopwatch: stopwatch);
  }
}