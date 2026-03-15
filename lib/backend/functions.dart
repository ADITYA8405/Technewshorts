import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:technewshorts/components/searchbar.dart';
import 'package:technewshorts/utils/key.dart';

Future<List> fetchnews() async {
  final response = await http.get(
    Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=technology&pageSize=100&apiKey=' +
        Key.apiKey +
        '&q=' +
        SearchBar.searchcontroller.text),
  );
  Map result = jsonDecode(response.body);
  print('Fetched');

  return (result['articles']);
}