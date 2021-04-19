String getPosterImage(String input) {
  return "https://image.tmdb.org/t/p/w500/$input";
}

String getTileImage(String input) {
  return "https://image.tmdb.org/t/p/w200/$input";
}

enum ContentType { movie, tv }
