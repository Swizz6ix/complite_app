import 'package:complite/middlewares/cache_middleware.dart';
import 'package:complite/middlewares/cancellation_middleware.dart';
import 'package:complite/middlewares/concurrency_queue_middleware.dart';
import 'package:complite/middlewares/debouncing_middleware.dart';
import 'package:complite/middlewares/deduplication_middleware.dart';
import 'package:complite/middlewares/logging_middleware.dart';
import 'package:complite/middlewares/middleware.dart';
import 'package:complite/middlewares/performance_middleware.dart';
import 'package:complite/middlewares/retry_middleware.dart';
import 'package:complite/middlewares/throttling_middleware.dart';
import 'package:complite/middlewares/timeout_middleware.dart';

class Pipeline {
  final List<Middleware> pre;
  final List<Middleware> control;
  final List<Middleware> execution;
  final List<Middleware> post;

  Pipeline({
    required this.pre,
    required this.control,
    required this.execution,
    required this.post,
  });

  List<Middleware> get all =>
    [...pre, ...control, ...execution, ...post ];
}

final deFaultPipeline = Pipeline(
  pre: [
    DeduplicationMiddleware(),
    // CacheMiddleware(),
  ], 

  control: [
    DebouncingMiddleware(),
    ThrottlingMiddleware(),
    CancellationMiddleware(),
    ConcurrencyQueueMiddleware(),
  ], 

  execution: [
    RetryMiddleware(maxRetries: 3),
    TimeoutMiddleware(timeout: Duration(seconds: 10)),
  ], 

  post: [
    PerformanceMiddleware(),
    LoggingMiddleware(),
    // CacheMiddleware(),
  ]
);
