class AnimeModel {
  String id;
  Attributes attributes;

  AnimeModel({
    this.id,
    this.attributes,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      id: json['id'],
      attributes: json['attributes'] != null
          ? new Attributes.fromJson(json['attributes'])
          : null,
    );
  }
}

// final String original_title,
//     overview,
//     poster_path,
//     country,
//     release_date,
//     content_type = "movie";
// String status;
// final int id, run_time;
// final double rating;
// final List genre;

//
// this.description,
// // this.titles,
// this.canonicalTitle,
// this.averageRating,
// this.startDate,
// this.ageRatingGuide,
// this.posterImage,
// this.episodeCount,
// this.episodeLength,
// this.totalLength,
// this.nsfw
class Attributes {
  String description;
  // Titles titles;
  String canonicalTitle;
  String averageRating;
  String startDate;
  String ageRatingGuide;
  String posterImage;
  int episodeCount;
  int episodeLength;
  int totalLength;
  bool nsfw;
  Attributes(
      {this.description,
      // this.titles,
      this.canonicalTitle,
      this.averageRating,
      this.startDate,
      this.ageRatingGuide,
      this.posterImage,
      this.episodeCount,
      this.episodeLength,
      this.totalLength,
      this.nsfw});

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
        description: json['description'],
        // titles :
        // json['titles'] != null ? new Titles.fromJson(json['titles']) : null,
        canonicalTitle: json['canonicalTitle'],
        averageRating: json['averageRating'],
        startDate: json['startDate'],
        posterImage:
            json['posterImage'] != null ? json['posterImage']['small'] : null,
        episodeCount: json['episodeCount'],
        episodeLength: json['episodeLength'],
        totalLength: json['totalLength'],
        ageRatingGuide: json['ageRatingGuide'],
        nsfw: json['nsfw']);
  }
}

class Titles {
  String en;
  String enJp;
  String jaJp;
  String enUs;

  Titles({this.en, this.enJp, this.jaJp, this.enUs});

  Titles.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    enJp = json['en_jp'];
    jaJp = json['ja_jp'];
    enUs = json['en_us'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['en_jp'] = this.enJp;
    data['ja_jp'] = this.jaJp;
    data['en_us'] = this.enUs;
    return data;
  }
}
