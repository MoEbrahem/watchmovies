class Movie {
  final String imageUrl;
  final String title;
  final String year;
  final String actors;

  Movie({
    required this.imageUrl,
    required this.title,
    required this.year,
    required this.actors,
  });

  factory Movie.fromJson(
      Map<String, dynamic> json, String baseUrl, String posterSize) {
    return Movie(
      imageUrl: json['poster_path'] != null
          ? '$baseUrl/t/p/$posterSize${json['poster_path']}'
          : '',
      title: json['title'] ?? '',
      year: json['release_date']?.substring(0, 4) ?? '',
      actors: 'Actors information not available',
    );
  }
}
