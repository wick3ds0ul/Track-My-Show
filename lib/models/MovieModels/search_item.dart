import 'movie_model.dart';

class SearchItem extends MovieModel {
  final String name,
      imageURL,
      overview,
      media_type,
      origin_country,
      release_date;
  final int id;
  // final int run_time;
  double rating;
  final List genre;
  SearchItem({
    this.id,
    this.name,
    this.rating,
    this.imageURL,
    this.origin_country,
    this.genre,
    // this.run_time,
    this.release_date,
    this.overview,
    this.media_type,
  });

//todo:Fix Rating
// We are getting the data for only those objects that have ID,title,description.
  factory SearchItem.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("known_for")) {
      String desc = json["known_for"][0]['overview'];
      // print(json["known_for"][0]['original_title'] ??
      //     json["known_for"][0]['original_name']);
      // print(desc.length);
      return SearchItem(
        id: json['known_for'][0]['id'],
        name: json["known_for"][0]['original_title'] ??
            json["known_for"][0]['original_name'],
        imageURL: json["known_for"][0]['poster_path'] ??
            json["known_for"][0]['backdrop_path'],
        overview: desc.length > 0 ? desc : null,
        media_type: json["known_for"][0]['media_type'] ?? null,
      );
    }
    String desc = json['overview'];
    return SearchItem(
      id: json['id'],
      name: json['original_title'] ?? json['original_name'],
      imageURL: json['poster_path'] ?? json['backdrop_path'],
      overview: desc.length > 0 ? desc : null,
      media_type: json['media_type'] ?? null,
    );
  }

  //Check for null values
  bool checkNullValues() {
    return [id, name, imageURL, overview, media_type].contains(null);
  }
}
