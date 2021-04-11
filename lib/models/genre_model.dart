class GenreModel {
  final String name;
  final int id;

  GenreModel({this.name, this.id});

  factory GenreModel.fromJson(Map json) {
    return GenreModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
