import 'package:complite/api/company_api.dart';
import 'package:complite/repositories/company_repository.dart';
import 'package:riverpod/riverpod.dart';

final companyRepositoryProvider = Provider<CompanyRepository>((ref) {
  return CompanyApi();
});