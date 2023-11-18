import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

Future<List<List<dynamic>>> loadCsvData() async {
  final data = await rootBundle.loadString('assets/data/flag_data.csv');
  List<List<dynamic>> csvTable = CsvToListConverter().convert(data);
  return csvTable;
}

List<List<dynamic>> filterByContinent(List<List<dynamic>> data, String continent) {
  if (continent == "all") {
    return data;
  }
  return data.where((row) => row[2].toLowerCase() == continent.toLowerCase()).toList();
}

