// todo replace with intl formats
({String date, String time}) formatDate(DateTime date) {
  final [dateStr, timeStr] = '$date'.split('.').first.split(' ');

  return (
    date: dateStr.split('-').reversed.join('.'),
    time: timeStr.substring(0, timeStr.lastIndexOf(':')),
  );
}
