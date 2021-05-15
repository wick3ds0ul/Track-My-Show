import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:track_my_show/models/AnimeModels/anime_model.dart';

class AnimeApi {
  Future<List<AnimeModel>> getTrendingAnime() async {
    Uri trendingUri = Uri.parse('https://kitsu.io/api/edge/trending/anime');
    final response = await http.get(trendingUri);
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return parsed
          .map<AnimeModel>((json) => AnimeModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load post');
    }
  }
}
