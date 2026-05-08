final class QueuedSyncRequest {
  const QueuedSyncRequest({
    required this.id,
    required this.method,
    required this.endpoint,
    required this.payload,
    required this.attemptCount,
    required this.createdAt,
    this.lastAttemptAt,
  });

  final String id;
  final String method;
  final String endpoint;
  final String payload;
  final int attemptCount;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
}
