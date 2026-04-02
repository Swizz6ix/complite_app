import 'dart:io';

// import 'package:logger/logger.dart';
import 'package:logging/logging.dart';

Logger initFileLogger(String name) {
  // Enable logging from child loggers.
  hierarchicalLoggingEnabled = true;

  // Create a logger instance with the provided name
  final logger = Logger(name);
  final now = DateTime.now();

  // Get the path to the project directory from the current script.
  final scriptFile = File(Platform.script.toFilePath());
  final projectDir = scriptFile.parent.parent.path;

  // Create a 'logs' Directory if it doesn't exist
  final dir = Directory('$projectDir/logs');
  if (!dir.existsSync()) dir.createSync();

  // Create a log file with a unique name base on the current
  // date and logger name.
  final logFile = File(
    '${dir.path}/${now.year}_${now.month}_${now.day}_$name.txt'
  );

  // Open a write sink in append mode
  final sink = logFile.openWrite(mode: FileMode.append);

  // Set the logger to ALL, so it logs all messages regardless of severity.
  logger.level = Level.ALL;

  // Listen for log records and write each one to the log file
  logger.onRecord.listen((record) {
    final msg =
      '[${record.time} - ${record.loggerName}] ${record.level.name}: ${record.message}';
    
    // print to console so you can still see it while debugging
    print(msg);

    // write to File
    sink.writeln(msg);
  });

  return logger;
}