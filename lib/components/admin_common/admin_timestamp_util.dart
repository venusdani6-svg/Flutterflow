/// Parses Firestore Timestamp JSON from Cloud Functions callable responses.
DateTime? parseAdminTimestamp(dynamic raw) {
  if (raw == null) {
    return null;
  }
  if (raw is String) {
    return DateTime.tryParse(raw);
  }
  if (raw is Map) {
    final sec = raw['_seconds'] ?? raw['seconds'];
    if (sec is int) {
      return DateTime.fromMillisecondsSinceEpoch(sec * 1000);
    }
    if (sec is num) {
      return DateTime.fromMillisecondsSinceEpoch(sec.toInt() * 1000);
    }
  }
  return null;
}
