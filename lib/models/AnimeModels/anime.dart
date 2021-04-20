import '../basic_model.dart';

class AnimeModel extends BasicModel {
  final String original_title,
      overview,
      poster_path,
      country,
      release_date,
      //This will determine which route to send when clicking on a tile->send to anime_detail screen
      content_type = "anime";
  String status;
  final int id, run_time;
  final double rating;
  final List genre;
  AnimeModel(
      {this.country,
      this.rating,
      this.genre,
      this.release_date,
      this.run_time,
      this.original_title,
      this.overview,
      this.status,
      this.poster_path,
      this.id});

  //Factory to convert JSON data to AnimeModel
  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    
    return AnimeModel(

    );
  }
}
