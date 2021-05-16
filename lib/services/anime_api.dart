import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:track_my_show/models/AnimeModels/anime_model.dart';
import 'package:track_my_show/models/AnimeModels/anime_result_model.dart';

class AnimeApi {
  Future<List<AnimeModel>> getTrendingAnime() async {
    Uri trendingUri = Uri.parse('https://kitsu.io/api/edge/trending/anime');
    final response = await http.get(trendingUri);
    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      final anime = AnimeResultModel.fromJson(parsedJson).anime;
      print(anime);
      return anime;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
