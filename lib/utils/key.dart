import 'package:flutter_dotenv/flutter_dotenv.dart';

class Key {
  static String get apiKey {
    final key = dotenv.env['NEWS_API_KEY'];

    if (key == null || key.isEmpty) {
      throw Exception("NEWS_API_KEY not found in .env file");
    }

    return key;
  }
}