abstract class CompanyEvent< T extends CompanyEvent<T>> {
  final String requestId;
  final Stopwatch? stopwatch;

  CompanyEvent({String? requestId, this.stopwatch})
    : requestId = requestId ?? _generateId();

    static String _generateId() {
      return DateTime.now().microsecondsSinceEpoch.toString();
    }

    /// Child must implement this
    T create({String? requestId, Stopwatch? stopwatch});

    T copyWith({Stopwatch? stopwatch}) {
      return create(requestId: requestId, stopwatch: stopwatch ?? this.stopwatch);
    }
}
