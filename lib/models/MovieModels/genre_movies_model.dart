import 'package:track_my_show/models/MovieModels/movie_model.dart';

class GenreMovieModel extends MovieModel {
  final String original_title, overview, poster_path, country, release_date;
  final int id, run_time;
  final double rating;
  final List genre;
  GenreMovieModel(
      {this.country,
      this.rating,
      this.genre,
      this.release_date,
      this.run_time,
      this.original_title,
      this.overview,
      this.poster_path,
      this.id});
  factory GenreMovieModel.fromJson(Map<String, dynamic> json) {
    return GenreMovieModel(
        original_title: json['original_title'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        id: json['id'],
        // country: json['production_companies'][0]['origin_country'],
        release_date: json['release_date'],
        // run_time: json['runtime'],
        // genre: json['genres'],
        rating: json['vote_average']);
  }
}
