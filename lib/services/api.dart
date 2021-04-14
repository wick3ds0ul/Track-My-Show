import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:track_my_show/models/MovieModels/action_movies_model.dart';
import 'package:track_my_show/models/MovieModels/adventure_movies_model.dart';
import 'package:track_my_show/models/MovieModels/animation_movie_model.dart';
import 'package:track_my_show/models/MovieModels/featured_movie_model.dart';
import 'package:track_my_show/models/MovieModels/genre_model.dart';
import 'package:track_my_show/models/MovieModels/movie_model.dart';
import 'package:track_my_show/models/MovieModels/search_item.dart';

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
    // print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      // print(parsed);
      return parsed
          .map<FeaturedMovieModel>((json) => FeaturedMovieModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load featured movies');
    }
  }

  Future<List<ActionMovieModel>> getActionMovies() async {
    String id = '28';
    Uri genreMovieUri = Uri.parse(
        '$url/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_genres=$id&with_original_language=en');
    final response = await http.get(genreMovieUri);
    // print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      // print(parsed);
      return parsed
          .map<ActionMovieModel>((json) => ActionMovieModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load this genre\'s movie movies');
    }
  }

  Future<List<AdventureMovieModel>> getAdventureMovies() async {
    String id = '12';
    Uri genreMovieUri = Uri.parse(
        '$url/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_genres=$id&with_original_language=en');
    final response = await http.get(genreMovieUri);
    // print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      // print(parsed);
      return parsed
          .map<AdventureMovieModel>(
              (json) => AdventureMovieModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load this genre\'s movie movies');
    }
  }

  Future<List<AnimationMovieModel>> getAnimationMovies() async {
    String id = '16';
    Uri genreMovieUri = Uri.parse(
        '$url/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_genres=$id&with_original_language=en');
    final response = await http.get(genreMovieUri);
    print(response);
    print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      return parsed
          .map<AnimationMovieModel>(
              (json) => AnimationMovieModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load this genre\'s movie movies');
    }
  }

  //Search movies by Name

  Future<List<SearchItem>> searchItems(String name) async {
    //todo:Fix the URL,Need to implement search for 1.search/movie?query=name 2.search/?query=titanic 3.
    //   http://api.themoviedb.org/3/search/multi?query=titanic&api_key=676a81313bcfbe018c137400e97d6a1a
    Uri searchUrl =
        Uri.parse('$url/search/multi?query=${name}&api_key=$apiKey');
    final response = await http.get(searchUrl);
    // print(response);
    // print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      return parsed
          .map<SearchItem>((json) => SearchItem.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load this genre\'s movie movies');
    }
  }

  Future<MovieModel> getMovieInfo(int movieId) async {
    Uri movieUri = Uri.parse("$url/movie/$movieId?api_key=$apiKey");
    final response = await http.get(movieUri);

    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Movie Information');
    }
  }

  Future<TV> getTVInfo(String name) async {
    //Get details by name
    //https://api.themoviedb.org/3/search/tv?query=game%20of%20thrones&api_key=4590b21894178ded2cc7cd5cd61e6b29&language=en-US&page=1&include_adult=false
    Uri tvURL = Uri.parse(
        "$url/search/tv?query=${name}&api_key=$apiKey&language=en-US&page=1&include_adult=false");
    final response = await http.get(tvURL);

    if (response.statusCode == 200) {
      // var parsed = json.decode(response.body)['results'][0];
      //     .
      // cast<Map<String, dynamic>>();
      // print("************");
      // print(parsed);
      // print("*****DATA*******");
      // print(parsed[]);
      //     {backdrop_path: /78DJ6cBSWzUCb1HrLTvltWpT9ZV.jpg, first_air_date: 2012-03-11, genre_ids: [10764], id: 62113, name: Shahs of Sunset, origin_country: [], original_language: en, original_name: Shahs of Sunset, overview: Follow a group of affluent young Persian-American friends who juggle their flamboyant, fast-paced L.A. lifestyles with the demands of their families and traditions., popularity: 5.833, poster_path: /imocZNiNbsFua19Z0hidmTbOWv1.jpg, vote_average: 6.2, vote_count: 21}
      return TV.fromJson(json.decode(response.body)['results'][0]);
    } else {
      throw Exception('Failed to load Movie Information');
    }
  }

  //todo:Fix this. Genres is in a data model for now.
//   Future getTVGenreName(String id) async {
//     // https://api.themoviedb.org/3/genre/tv/list?api_key=4590b21894178ded2cc7cd5cd61e6b29&language=en-US
//     Uri tvGenreURL = Uri.parse(
//         "$url/genre/tv/list?&api_key=$apiKey&language=en-US&page=1&include_adult=false");
//     final response = await http.get(tvGenreURL);
//     print(response);
//     var parsed = json.decode(response.body);
//     print(parsed.toString());
//   }
// }

}
