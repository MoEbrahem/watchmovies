class Movie {
  String title;
  String backDropPath;
  String originalTitle;
  String overView;
  String posterPath;
  String releaseDate;
  double voteAverage;

  Movie(
      {required this.title,
      required this.backDropPath,
      required this.originalTitle,
      required this.overView,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json["title"] as String,
        backDropPath: json["backdrop_path"] as String,
        originalTitle: json["original_title"] as String,
        overView: json["overview"] as String,
        posterPath: json["poster_path"] as String,
        releaseDate: json["release_date"] as String,
        voteAverage: json["vote_average"] as double);
  }
}
