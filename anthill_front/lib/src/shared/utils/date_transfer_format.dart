/// Matches dates in format 2YYY-MM-DD.
final _dateRegex = RegExp(r'^(2\d\d\d)-(\d\d)-(\d\d)$');

/// Serializes the given [date] as a string of format `YYYY-MM-DD`.
String serializeDateQueryParam(DateTime date) =>
    '${date.year}-${'${date.month}'.padLeft(2, '0')}-${'${date.day}'.padLeft(2, '0')}';

/// Tries to deserialize a date from the given [str] of format `YYYYMMDD`.
/// If not successful, returns null.
DateTime? deserializeDateQueryParam(String str) {
  final match = _dateRegex.matchAsPrefix(str);

  if (match == null || match.groupCount != 3) {
    return null;
  }

  final intValues = match.groups([1, 2, 3]).nonNulls.map(int.parse).toList(growable: false);

  return DateTime(intValues[0], intValues[1], intValues[2]);
}
