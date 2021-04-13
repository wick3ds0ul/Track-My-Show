import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:track_my_show/models/action_movies_model.dart';
import 'package:track_my_show/models/adventure_movies_model.dart';
import 'package:track_my_show/models/animation_movie_model.dart';
import 'package:track_my_show/models/genre_movies_model.dart';
import 'package:track_my_show/models/genre_movies_model.dart';
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

  Future<List<ActionMovieModel>> getActionMovies() async {
    String id = '28';
    Uri genreMovieUri = Uri.parse(
        '$url/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_genres=$id&with_original_language=en');
    final response = await http.get(genreMovieUri);
    print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      print(parsed);
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
    print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      print(parsed);
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
    print(response);
    print(response.body);
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
}

class SearchItem extends MovieModel {
  // final String original_title, overview, poster_path, country, release_date;
  // final int id, run_time;
  // final double rating;
  // final List genre;
  //
  // SearchItem(
  //     {this.country,
  //     this.rating,
  //     this.genre,
  //     this.release_date,
  //     this.run_time,
  //     this.original_title,
  //     this.overview,
  //     this.poster_path,
  //     this.id});

  final String name, imageURL, desc, type;
  SearchItem({this.name, this.imageURL, this.desc, this.type});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
        name: json['original_title'] ?? json['original_name'],
        // overview: json['overview'],
        imageURL: json['poster_path'],
        desc: json['overview']
        // id: json['id'],
        // country: json['production_companies'][0]['origin_country'],
        // release_date: json['release_date'],
        // run_time: json['runtime'],
        // genre: json['genres'],
        // rating: json['vote_average'].toDouble()
        );
  }
}
