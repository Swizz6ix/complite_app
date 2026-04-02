import 'package:complite/controllers/company_notifier.dart';
import 'package:complite/events/fetch_company_data.dart';
import 'package:complite/providers/company_provider.dart';
import 'package:complite/states/results.dart';
import 'package:complite/utilities/cancellation_token.dart';
import 'package:complite/utilities/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class CompanyListPage extends ConsumerWidget {
  const CompanyListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(companyProvider);

    return Center(
      child: state.when(
        idle: () => Center(
          child: ElevatedButton(
            onPressed: () {
               final token = CancellationToken();
              ref.read(companyProvider.notifier).fetch(token);
            },
            child: const Text("Load Companies"),
          )
        ),
        loading: (_) =>  Center(child: const CircularProgressIndicator()),
        success: (_, companies) => Expanded(
          child: ListView.builder(
          itemCount: companies.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(companies[index].name),
              subtitle: Text(companies[index].industry),
            );
          }),
        ),
        failure: (_, err) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Error: $err"),
              ElevatedButton(
                onPressed: () {
                  final token = CancellationToken();
                  ref.read(companyProvider.notifier).fetch(token);
                }, 
                child: const Text("Retry"),
              ),
            ],
          ),
      )),
    );
  }
}