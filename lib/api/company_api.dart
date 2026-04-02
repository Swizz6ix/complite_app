import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:complite/errors/app_error.dart';
import 'package:complite/models/company_dto.dart';
import 'package:complite/repositories/company_repository.dart';
import 'package:complite/states/results.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:retry/retry.dart';

class CompanyApi implements CompanyRepository {
  final _logger = Logger("CompanyApp.Repository");
  @override
  Future<Results<List<CompanyDto>>> fetchCompany(
    // String requestId, 
    // {
      // int page = 1,
      // int limit = 10
    // }
    ) async {
      final requestId = DateTime.now().toIso8601String();
    try {
      final response = await retry(
        () => http
        .get(Uri.parse(
          'https://json-placeholder.mock.beeceptor.com/companies'))
        .timeout(Duration(seconds: 10)),

        retryIf: (e) => e is SocketException || e is TimeoutException,
        maxAttempts: 2,
        maxDelay: Duration(seconds: 1),
      );

      if (response.statusCode != 200) {
        return Failure(
          requestId: "[$requestId]:", 
          errorMessage: "server error ${response.statusCode}");
      }

      _logger.info("[$requestId] HTTP status code: ${response.statusCode}");
      
      final List<dynamic> jsonList = jsonDecode(response.body);
      final companies = jsonList
      .map((json) => CompanyDto.fromJson(json))
      .toList();

      _logger.fine("[$requestId] Parse ${companies.length} Companies");
      print("done");
      return Success("[$requestId]: page", companies);
    } on SocketException {
      _logger.warning("[$requestId] No internet connection");
    return Failure(requestId: requestId, error:NoInternetError());
    } on TimeoutException {
      _logger.warning("[$requestId] Request time out");
      return Failure(requestId: requestId, error:NoInternetError());
    } on FormatException catch (e) {
      _logger.severe("[$requestId] Json parsing error: ${e.message}");
      return Failure(requestId: requestId, error:ParsingError());
    } catch (e, stack) {
      _logger.severe("[$requestId] Unknown error: $e", e, stack);
      return Failure(requestId: requestId, error:BusinessLogicError("Unknow error occurred"));
    }
  }
}