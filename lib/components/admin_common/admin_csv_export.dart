import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Generates CSV text from rows and column headers.
String buildCsv({
  required List<String> headers,
  required List<List<String>> rows,
}) {
  final buffer = StringBuffer();
  buffer.writeln(headers.map(_escapeCsvCell).join(','));
  for (final row in rows) {
    buffer.writeln(row.map(_escapeCsvCell).join(','));
  }
  return buffer.toString();
}

String _escapeCsvCell(String value) {
  if (value.contains(',') || value.contains('"') || value.contains('\n')) {
    return '"${value.replaceAll('"', '""')}"';
  }
  return value;
}

/// Downloads CSV on web; logs on other platforms (share can be added later).
Future<void> downloadCsvFile({
  required String filename,
  required String csvContent,
}) async {
  if (kIsWeb) {
    final bytes = utf8.encode(csvContent);
    final uri = Uri.dataFromBytes(
      bytes,
      mimeType: 'text/csv',
      parameters: {'filename': filename},
    );
    await launchUrl(uri);
    return;
  }
  debugPrint('CSV export ($filename):\n$csvContent');
}
