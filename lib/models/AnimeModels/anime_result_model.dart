import 'anime_model.dart';

class AnimeResultModel {
  List<AnimeModel> anime;
  AnimeResultModel({this.anime});
  AnimeResultModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      anime = new List<AnimeModel>();
      json['data'].forEach((v) {
        anime.add(new AnimeModel.fromJson(v));
      });
    }
  }
}
