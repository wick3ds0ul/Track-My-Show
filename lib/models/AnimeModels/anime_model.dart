import 'movie_entity.dart';

class AnimeModel extends AnimeEntity {
  final String id;
  final String description;
  final String canonicalTitle;
  final String averageRating;
  final String startDate;
  final String ageRatingGuide;
  final String posterImage;
  final int episodeCount;
  final int episodeLength;
  final int totalLength;
  final bool nsfw;
  AnimeModel(
      {this.id,
      this.description,
      this.canonicalTitle,
      this.averageRating,
      this.startDate,
      this.ageRatingGuide,
      this.posterImage,
      this.episodeCount,
      this.episodeLength,
      this.totalLength,
      this.nsfw})
      : super(id: id, title: canonicalTitle);
  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
        id: json['id'],
        canonicalTitle: json['attributes']['canonicalTitle'],
        description: json['attributes']['description'],
        startDate: json['attributes']['startDate'],
        posterImage: json['attributes']['posterImage']['small'],
        averageRating: json['attributes']['averageRating'],
        ageRatingGuide: json['attributes']['ageRatingGuide'],
        episodeCount: json['attributes']['episodeCount'],
        episodeLength: json['attributes']['episodeLength'],
        totalLength: json['attributes']['totalLength'],
        nsfw: json['attributes']['nsfw']);
  }
}
