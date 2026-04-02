import 'package:complite/ui/company_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // initFileLogger('compile');
  // final logger = Logger('compile-app');
  // logger.info('app start');

  runApp(
    ProviderScope(
      // overrides: [],
      // observers: [ProviderLogger()],
      child: const MainApp()
    )
    );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: CompanyListPage(),
      ),
    );
  }
}
