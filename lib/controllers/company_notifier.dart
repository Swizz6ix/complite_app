import 'package:complite/events/event_bus.dart';
import 'package:complite/events/fetch_company_data.dart';
import 'package:complite/utlities/cancellation_token.dart';
import 'package:complite/models/company_dto.dart';
import 'package:complite/states/results.dart';
import 'package:complite/utlities/result_state.dart';
import 'package:logging/logging.dart';
import 'package:riverpod/legacy.dart';

class CompanyNotifier extends StateNotifier<Results<List<CompanyDto>>> {
  final _logger = Logger('complite.notifier');
  final EventBus bus;

  CompanyNotifier(this.bus) : super(Idle());

  Future<void> fetch(CancellationToken? token) async {
    final companyId = DateTime.now().toIso8601String();
    final event = FetchCompanyData(companyId);
    state = Loading(event.requestId);
    print("notifier");

      final data = await bus.dispatch<FetchCompanyData, List<CompanyDto>> (
        event,
        token: token,
      );
      print("nofity suc");

      print("return state1 --> $state");
      state = data;
      print("return state2 --> $state");
      
      state.when(
        idle: () {},
        loading: (_) => print("loading"),
        success: (_, data) => print("success $data"),
        failure: (_, err) => print("failed $err"),
      );
  }
}
