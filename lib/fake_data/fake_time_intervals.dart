import 'package:intl/intl.dart';

///
/// FormatterDay
///
final formatterDay = DateFormat('MMM dd, yyyy');
final formatterMonth = DateFormat('MMM, yyyy');

List<String> generateFakeLast10SessionsLabels() {
  List<String> fakeLastMonthLabels = [];

  DateTime currentDate = DateTime.now();
  DateTime firstDate = currentDate.add(const Duration(days: -10));

  while (currentDate.isAfter(firstDate)) {
    fakeLastMonthLabels.add(formatterDay.format(currentDate));
    currentDate = currentDate.add(const Duration(days: -1));
  }

  fakeLastMonthLabels.add(" ");
  return fakeLastMonthLabels;
}

List<String> generateFakeLast20SessionsLabels() {
  List<String> fakeLastMonthLabels = [];

  DateTime currentDate = DateTime.now();
  DateTime firstDate = currentDate.add(const Duration(days: -20));

  while (currentDate.isAfter(firstDate)) {
    fakeLastMonthLabels.add(formatterDay.format(currentDate));
    currentDate = currentDate.add(const Duration(days: -1));
  }

  fakeLastMonthLabels.add(" ");
  return fakeLastMonthLabels;
}

List<String> generateFakeLastMonthLabels() {
  List<String> fakeLastMonthLabels = [];

  DateTime currentDate = DateTime.now();
  DateTime firstDate = currentDate.add(const Duration(days: -30));

  while (currentDate.isAfter(firstDate)) {
    fakeLastMonthLabels.add(formatterDay.format(currentDate));
    currentDate = currentDate.add(const Duration(days: -1));
  }

  fakeLastMonthLabels.add(" ");
  return fakeLastMonthLabels;
}

List<String> generateFakeLastThreeMonthsLabels() {
  List<String> fakeLastThreeMonthsLabels = [];

  DateTime currentDate = DateTime.now();
  DateTime firstDate = DateTime.now().add(const Duration(days: -90));

  while (currentDate.isAfter(firstDate)) {
    fakeLastThreeMonthsLabels.add(formatterDay.format(currentDate));
    currentDate = currentDate.add(const Duration(days: -8));
  }

  fakeLastThreeMonthsLabels.add(" ");
  return fakeLastThreeMonthsLabels;
}

List<String> generateFakeLastSixMonthsLabels() {
  List<String> fakeLastSixMonthsLabels = [];

  DateTime currentDate = DateTime.now();

  for (var i = 0; i < 6; i++) {
    fakeLastSixMonthsLabels.add(formatterMonth.format(currentDate));
    currentDate = currentDate.add(const Duration(days: -30));
  }

  fakeLastSixMonthsLabels.add(" ");
  return fakeLastSixMonthsLabels;
}

List<String> generateFakeLastYearLabels() {
  List<String> fakeLastYearLabels = [];

  DateTime currentDate = DateTime.now();

  for (var i = 0; i < 12; i++) {
    fakeLastYearLabels.add(formatterMonth.format(currentDate));
    currentDate = currentDate.add(const Duration(days: -30));
  }

  fakeLastYearLabels.add(" ");

  return fakeLastYearLabels;
}
