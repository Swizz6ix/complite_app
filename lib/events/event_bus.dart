import 'dart:async';

import 'package:complite/events/company_event.dart';
import 'package:complite/events/event_handler.dart';
import 'package:complite/handlers/event_handler.dart';
import 'package:complite/utlities/cancellation_token.dart';
import 'package:complite/middlewares/middleware.dart';
import 'package:complite/states/results.dart';

class EventBus {
  final List<Middleware> _middleware;
  final Map<Type, List<EventHandler>> _handlers;



  EventBus({
    required List<Middleware> middlewares,
    required Map<Type, List<EventHandler>> handlers,
  }) : _middleware = middlewares,
       _handlers = handlers;

  Future<Results<R>> dispatch<E extends CompanyEvent<E>, R>(
    E event, {
    CancellationToken? token,
    }) async {
      print('received');
      final handlers = _handlers[event.runtimeType];

      if (handlers == null || handlers.isEmpty) {
        return Failure(
          requestId: event.requestId,
          errorMessage: "No handler registered for ${E.toString()}"
        );
      }

      

      // Buid middleware chain (reverse Composition)
      try {
        final handler = handlers.first;

        Future<Results<R>> callHandler(E e) async {
          token?.throwIfCancelled();
          print("called token");
          final typedHandler = handler as EventHandler<E, Results<R>>;
          return await typedHandler.handle(e);
        }
        print("called after token");
        return await _buildPipeline(callHandler)(event);
      
      } catch (e) {
        return Failure(
          requestId: event.requestId, 
          errorMessage: e.toString()
        );
        
      }
  }
  
  Future<Results<R>> Function(E) _buildPipeline<E extends CompanyEvent<E>, R>(
    Future<Results<R>> Function(E event) handler,
  ) {
    Future<Results<R>> Function(E) pipeline = handler;
    print("called 2");
    for (final middleware in _middleware.reversed) {
      final next = pipeline;
      print('called inner 2');
      pipeline = (event) {
        print("called inner 2 inner ${event.runtimeType}");
        return middleware.handle<E, R>(event, next);
      };
    }
    print("piping");
    print("pipip --> $pipeline");
    return pipeline;
  }
}