// import 'dart:ui';

// import 'dart:convert';

// import 'package:complite/events/cacheable_event.dart';
// import 'package:complite/events/company_event.dart';
// import 'package:complite/middlewares/cache_database.dart';
// import 'package:complite/middlewares/middleware.dart';
// import 'package:complite/models/company_dto.dart';
// import 'package:complite/states/results.dart';
// import 'package:complite/utlities/cache_entry.dart';
// import 'package:logging/logging.dart';
// import 'package:sqflite/sqflite.dart';


// class CacheMiddleware implements Middleware {
//   final _logger = Logger('CompanyApp.cache');
//   final Duration ttl = Duration(minutes: 5);

//   // In-memory cache: key -> CacheEntry
//   final Map<String, CacheEntry> _memoryCache = {};

//   bool _initialized = false;

//   /// Load all cache from SQLite into memory
//   Future<void> _loadCache() async {
//     if (_initialized) return;
//     _initialized = true;

//     final db = await CacheDatabase.instance;
//     final rows = await db.query('cache');

//     for (var row in rows) {
//       final key = row['key'] as String;
//       final timestamp = DateTime.parse(row['timestamp'] as String);
//       final dataJson = jsonDecode(row['data'] as String) as List;
//       final companies = dataJson.map((e) => CompanyDto.fromJson(e)).toList();
//       _memoryCache[key] = CacheEntry(companies)..timestamp = timestamp;
//     }

//     _logger.info("Loaded ${_memoryCache.length} cache entries into memory");
//   }

//   @override
//   Future<R> handle<E extends CompanyEvent<E>, R>(
//     E event,
//     Future<R> Function(E event) next,
//   ) async {
//     await _loadCache(); // ensure memory is populated
//     final key  = _buildKey(event);
//     final db = await CacheDatabase.instance;

//     if (_memoryCache.containsKey(key)) {
//       final entry = _memoryCache[key];
//       final isExpired = DateTime.now().difference(entry!.timestamp) > ttl;

//       if (!isExpired) {
//         final companies = entry.data as List<CompanyDto>;

//         _logger.info("Returning valid cache -> $key, data: ${companies.map((c) => c.name).join(',')}");
//         return entry.data as R;
//       } else {
//         _logger.info('Cache expired -> $key');
//       }
//     }

//     // if no valid cache, try network
//     final result = await next(event);

//     if (result is Success<List<CompanyDto>>) {
//       final entry = CacheEntry(result.data);
//       _memoryCache[key] = entry;
      
//       // Write through to SQLite
//       await db.insert(
//         'cache',
//         {
//           'key': key,
//           'timestamp': entry.timestamp.toIso8601String(),
//           'data': jsonEncode(result.data.map((c) => c.toJson()).toList()),
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );

//       print("see--> $result");
//       _logger.info("Cache STORE -> $key");
//       print('1st keys ${_memoryCache[key]}');
//       return result;
//     } else if (result is Failure<List<CompanyDto>>) {
//       _logger.warning("Request failed $key");

//       // Fallback to expire cache if availble
//       if (_memoryCache.containsKey(key)) {
//         _logger.info("Returning expired cache -> $key");
//         final entry = _memoryCache[key]!;
//         final companies = entry.data as List<CompanyDto>;

//         _logger.info("Returning expired cache -> $key, data: ${companies.map((c) => c.name).join(',')}");
//         return entry.data as R;
//       } else {
//         _logger.info("Cache expire -> $key");
//       }
//     }
//     print('2nd keys --> $_memoryCache');
//     return result;
//   }

//   String _buildKey<E>(E event){
//     // Best practice event defines its own cache identity
//     if (event is CacheableEvent) {
//       return event.cacheKey;
//     }

//     return "${event.runtimeType}";
//   }
// }