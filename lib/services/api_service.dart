import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class ApiService {
  static const _url = 'https://rickandmortyapi.com/api/character';

  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode != 200) {
      throw Exception('API error');
    }
    final data = jsonDecode(response.body);
    final results = data['results'] as List;
    return results.map((e) => Character.fromJson(e)).toList();
  }
}
