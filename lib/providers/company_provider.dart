import 'package:complite/controllers/company_notifier.dart';
import 'package:complite/models/company_dto.dart';
import 'package:complite/providers/event_bus_provider.dart';
import 'package:complite/states/results.dart';
import 'package:riverpod/legacy.dart';

final companyProvider = StateNotifierProvider<CompanyNotifier, Results<List<CompanyDto>>>((ref) {
  return CompanyNotifier(ref.read(eventBusProvider));
});