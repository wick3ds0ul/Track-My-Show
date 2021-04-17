class BasicModel {
  final String original_title,
      overview,
      poster_path,
      country,
      release_date,
      content_type;
  final int id, run_time;
  final double rating;
  final List genre;
  BasicModel(
      {this.country,
      this.rating,
      this.genre,
      this.release_date,
      this.run_time,
      this.original_title,
      this.overview,
      this.poster_path,
      this.content_type,
      this.id});
}
