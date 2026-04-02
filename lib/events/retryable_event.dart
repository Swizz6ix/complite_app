
import 'package:complite/events/company_event.dart';

abstract base class RetryableEvent<T extends CompanyEvent<T>> extends CompanyEvent<T> {
  final int retryCount;

  RetryableEvent({
    super.requestId,
    super.stopwatch,
    this.retryCount = 0,
  });

  T createWithRetry({
    String? requestId,
    Stopwatch? stopwatch,
    int? retryCount,
  });
}               