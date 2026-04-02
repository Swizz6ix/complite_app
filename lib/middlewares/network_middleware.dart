// import 'dart:nativewrappers/_internal/vm/bin/common_patch.dart';

// import 'package:complite/events/company_event.dart';
// import 'package:complite/middlewares/middleware.dart';
// import 'package:complite/providers/network_info.dart';
// import 'package:complite/repositories/queue_repository.dart';

// class NetworkMiddleware extends Middleware {
//   final NetworkInfo _networkInfo;
//   final QueueRepository _queueRepository;

//   NetworkMiddleware(this._networkInfo, this._queueRepository);
  
//   @override
//   Future<R> handle<E extends CompanyEvent<E>, R>(
//     E event,
//     Future<R> Function(E) next,
//   ) async {
//     if (!await _networkInfo.isConnected) {
//       await _queueRepository.enqueue(event);
//       throw Exception("No internet connection");
//     }

//     return next(event);
//   }

//   Future<bool> get isConnected async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       return result.isNotEmpty;
//     } catch (_) {
//       return false;
//     }
//   }
// }