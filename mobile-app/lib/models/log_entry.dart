class LogEntry {
  final String timestamp;
  final String result;
  final String cost;

  LogEntry({
    required this.timestamp,
    required this.result,
    required this.cost,
  });

  factory LogEntry.fromJson(Map<String, dynamic> json) {
    return LogEntry(
      timestamp: json['timestamp'] as String,
      result: json['result'] as String,
      cost: json['cost'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'result': result,
      'cost': cost,
    };
  }
}
