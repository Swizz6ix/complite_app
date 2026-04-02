import 'package:complite/models/company_dto.dart';

class CacheEntry {
  final dynamic data;
  late final DateTime timestamp;

  CacheEntry(this.data) : timestamp = DateTime.now();

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'data': (data as List<CompanyDto>).map((c) => c.toJson()).toList(),
  };

  static CacheEntry fromJson(Map<String, dynamic> json) {
    final companies = (json['data'] as List)
      // .map((e) => Company.fromJson(e))
      .toList();

    final entry = CacheEntry(companies);
    return entry;
  }
}