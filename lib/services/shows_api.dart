import 'dart:convert';
import 'package:track_my_show/models/ShowModels/popular_shows_model.dart';
import 'package:http/http.dart' as http;
import 'package:track_my_show/models/ShowModels/show_model.dart';

class ShowsApi {
  var httpClient = http.Client();

  static const url = "https://api.themoviedb.org/3";
  static const apiKey = "4590b21894178ded2cc7cd5cd61e6b29";

  Future<List<PopularShowModel>> getPopularShows() async {
    Uri popularShowsUri =
        Uri.parse('$url/tv/popular?api_key=$apiKey&language=en-US&page=1');
    final response = await http.get(popularShowsUri);
    // print(response.body);
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)['results'].cast<Map<String, dynamic>>();
      print(parsed);
      return parsed
          .map<PopularShowModel>((json) => PopularShowModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load popular shows');
    }
  }

  Future<ShowModel> getShowInfo(int tvId) async {
    Uri tvUri = Uri.parse("$url/tv/$tvId?api_key=$apiKey&language=en-US");
    final response = await http.get(tvUri);

    if (response.statusCode == 200) {
      return ShowModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the show of id : $tvId');
    }
  }
}
