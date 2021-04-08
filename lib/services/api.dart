import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:track_my_show/models/featured_movie_model.dart';
import 'package:track_my_show/models/genre_model.dart';
import 'package:track_my_show/models/movie_model.dart';

class Api {
  var httpClient = http.Client();

  static const url = "https://api.themoviedb.org/3";
  static const apiKey = "4590b21894178ded2cc7cd5cd61e6b29";

  Future<List<GenreModel>> getGenreList() async {
    Uri genreUri = Uri.parse('$url/genre/movie/list?api_key=$apiKey');
    final response = await http.get(genreUri);

    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['genres'].cast<Map<String, dynamic>>();

      return parsed
          .map<GenreModel>((json) => GenreModel.fromJson(json))
          .toList();
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<FeaturedMovieModel>> getFeaturedMovies() async {
    Uri featuredMovieUri = Uri.parse('$url/trending/movie/day?api_key=$apiKey');
    final response = await http.get(featuredMovieUri);
    print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      print(parsed);
      return parsed
          .map<FeaturedMovieModel>((json) => FeaturedMovieModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load featured movies');
    }
  }

  Future<MovieModel> getMovieInfo(int movieId) async {
    Uri movieUri = Uri.parse("$url/movie/$movieId?api_key=$apiKey");
    final response = await http.get(movieUri);

    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Movie Information');
    }
  }
}
