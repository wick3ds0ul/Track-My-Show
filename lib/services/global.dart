String getPosterImage(String input) {
  return "https://image.tmdb.org/t/p/original/$input";
}

String getTileImage(String input) {
  return "https://image.tmdb.org/t/p/w200/$input";
}

enum ContentType { movie, tv }
