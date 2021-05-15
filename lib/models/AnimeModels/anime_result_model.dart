import 'anime_model.dart';

class AnimeResultModel {
  List<AnimeModel> data;

  AnimeResultModel({this.data});

  AnimeResultModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<AnimeModel>();
      json['data'].forEach((v) {
        data.add(new AnimeModel.fromJson(v));
      });
    }
  }
}
