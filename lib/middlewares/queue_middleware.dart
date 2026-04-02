import 'dart:async';

import 'package:complite/events/company_event.dart';
import 'package:complite/middlewares/middleware.dart';
import 'package:complite/states/results.dart';


class QueueMiddleware extends Middleware {
  bool _isProcessing = false;
  final _queue = <Future Function()>[];

  @override
  Future<Results<T>> handle<E extends CompanyEvent<E>, T>(
    E event,
    Future<Results<T>> Function(E event) next,
  ) async {
    final completer = Completer<Results<T>>();

    _queue.add(() async {
      try {
        final result = await next(event);
        completer.complete(result);
      } catch (e, s) {
        completer.completeError(e, s);
      }
    });

    _processQueue();

    return completer.future;
  }

  void _processQueue() async {
    if (_isProcessing) return;

    _isProcessing = true;

    while (_queue.isNotEmpty) {
      final task = _queue.removeAt(0);
      await task();
    }

    _isProcessing = false;
  }
}