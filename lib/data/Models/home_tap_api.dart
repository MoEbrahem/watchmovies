class Movie {
  int id;
  String title;
  String backDropPath;
  String originalTitle;
  String overView;
  String posterPath;
  String releaseDate;
  double voteAverage;



  Movie({
    required this.id,
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overView,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json["title"],
      backDropPath: json["backdrop_path"],
      originalTitle: json["original_title"],
      overView: json["overview"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      voteAverage: json["vote_average"],
    );
  }
}


  Movie(
      {
      required this.id,
      required this.title,
      required this.backDropPath,
      required this.originalTitle,
      required this.overView,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage,
      });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json["title"] as String,
        backDropPath: json["backdrop_path"] as String,
        originalTitle: json["original_title"] as String,
        overView: json["overview"] as String,
        posterPath: json["poster_path"] as String,
        releaseDate: json["release_date"] as String,
        voteAverage: json["vote_average"] as double);
  }
}
