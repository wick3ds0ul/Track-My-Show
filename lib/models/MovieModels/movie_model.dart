import '../basic_model.dart';

class MovieModel extends BasicModel {
  final String original_title,
      overview,
      poster_path,
      country,
      release_date,
      content_type = "movie";
  String status = "want to watch";
  final int id, run_time;
  final double rating;
  final List genre;

  MovieModel(
      {this.country,
      this.rating,
      this.genre,
      this.release_date,
      this.run_time,
      this.original_title,
      this.overview,
      this.status,
      this.poster_path,
      // this.content_type,
      this.id});
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // print("JSON DATA");
    // print(json);
    // print('original_title: ${json['original_title'] ?? json['name']} ');
    // print('imageURL:${json['poster_path'] ?? json['backdrop_path']}');
    // print('overview:${json['overview']}');
    // // print(' ${json['poster_path'] ?? json['backdrop_path']}');
    // print('id:${json['id']}');
    // // print('country:${json['origin_country'][0] ?? "N/A"}');
    // print('release_date:${json['release_date']}');
    // print('Genres:${json['genres']}');
    // print('rating:${json['vote_average'].toDouble()}');
    var country = json['production_countries'];
    // print("Country:${country}");
    if (country.length == 0) {
      country = "N/A";
    } else {
      country = json['production_countries'][0]['name'];
    }
    print("Country:${country}");
    return MovieModel(
        original_title: json['original_title'] ?? json['title'],
        overview: json['overview'],
        poster_path: json['poster_path'] ?? json['backdrop_path'],
        id: json['id'],
        country: country ?? json['production_companies'][0]['origin_country'],
        release_date: json['release_date'],
        run_time: json['runtime'],
        genre: json['genres'],
        // content_type: "movie",
        rating: json['vote_average']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'run_time': run_time,
        'rating': rating,
        'genre': genre,
        'original_title': original_title,
        'overview': overview,
        'poster_path': poster_path,
        'country': country,
        'release_date': release_date
      };
}

class TV {
  final String original_title, overview, poster_path, country, release_date;
  final int id;
  final double rating;
  final List genre;
  TV(
      {this.country,
      this.rating,
      this.genre,
      this.release_date,
      this.original_title,
      this.overview,
      this.poster_path,
      this.id});
  factory TV.fromJson(Map<String, dynamic> json) {
    // print("JSON DATA");
    // print(json);
    // print('original_title: ${json['original_name'] ?? json['name']} ');
    // print('imageURL:${json['poster_path'] ?? json['backdrop_path']}');
    // print('overview:${json['overview']}');
    // // print(' ${json['poster_path'] ?? json['backdrop_path']}');
    // print('id:${json['id']}');
    // // print('country:${json['origin_country'][0] ?? "N/A"}');
    // print('release_date:${json['first_air_date']}');
    // print('Genres:${json['genre_ids']}');
    print('rating:${json['vote_average'].toDouble()}');
    var country = json['origin_country'];
    // print("Country:${country}");
    if (country.length == 0) {
      country = "N/A";
    } else {
      country = json['origin_country'][0];
    }
    print("Country:${country}");
    return TV(
        original_title: json['original_name'] ?? json['name'],
        overview: json['overview'],
        poster_path: json['poster_path'] ?? json['backdrop_path'],
        id: json['id'],
        country: country.toString(),
        release_date: json['first_air_date'],
        genre: json['genre_ids'],
        rating: json['vote_average'].toDouble());
  }
}

//Example of response
// {backdrop_path: /78DJ6cBSWzUCb1HrLTvltWpT9ZV.jpg, first_air_date: 2012-03-11, genre_ids: [10764], id: 62113, name: Shahs of Sunset, origin_country: [], original_language: en, original_name: Shahs of Sunset, overview: Follow a group of affluent young Persian-American friends who juggle their flamboyant, fast-paced L.A. lifestyles with the demands of their families and traditions., popularity: 5.833, poster_path: /imocZNiNbsFua19Z0hidmTbOWv1.jpg, vote_average: 6.2, vote_count: 21}
