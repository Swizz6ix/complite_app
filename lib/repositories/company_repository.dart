import 'package:complite/models/company_dto.dart';
import 'package:complite/states/results.dart';

abstract class CompanyRepository {
  Future<Results<List<CompanyDto>>> fetchCompany(
    // String requestId, 
    // {
      // int page, 
      // int limit
      // }
      );
}