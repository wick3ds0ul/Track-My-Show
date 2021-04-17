import '../basic_model.dart';

class ShowModel extends BasicModel {
  final String original_title,
      overview,
      poster_path,
      country,
      release_date,
      content_type;
  final int id, run_time;
  final double rating;
  final List genre;
  ShowModel(
      {this.country,
      this.rating,
      this.genre,
      this.release_date,
      this.run_time,
      this.original_title,
      this.overview,
      this.poster_path,
      this.content_type,
      this.id});
  factory ShowModel.fromJson(Map<String, dynamic> json) {
    return ShowModel(
        original_title: json['original_name'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        id: json['id'],
        country: json['production_companies'][0]['origin_country'],
        release_date: json['first_air_date'],
        run_time: json['runtime'],
        genre: json['genres'],
        content_type: "tv",
        rating: json['vote_average'].toDouble());
  }
}
